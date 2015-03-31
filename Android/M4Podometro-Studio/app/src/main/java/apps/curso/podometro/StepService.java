

package apps.curso.podometro;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.hardware.Sensor;
import android.hardware.SensorManager;
import android.os.Binder;
import android.os.IBinder;
import android.os.PowerManager;
import android.preference.PreferenceManager;
import android.widget.Toast;

public class StepService extends Service {
	private static final String TAG = "apps.curso.podometro.StepService";
    private SharedPreferences mAjustes;
    private AjustesPodometro mAjustesPodometro;
    private SharedPreferences mState;
    private SharedPreferences.Editor mStateEditor;
    private SensorManager mSensorManager;
    private Sensor mSensor;
    private StepDetector mStepDetector;
    private StepDisplayer mStepDisplayer;
    private NotificarRatio mNotificarRatio;
    private NotificarDistancia mNotificarDistancia;
    private NotificarVelocidad mNotificarVelocidad;
    
    private PowerManager.WakeLock wakeLock;
    private NotificationManager mNM;

    private int mPasos;
    private int mRatio;
    private float mDistancia;
    private float mVelocidad;
    
    /**
     * Class for clients to access.  Because we know this service always
     * runs in the same process as its clients, we don't need to deal with
     * IPC.
     */
    public class StepBinder extends Binder {
        StepService getService() {
            return StepService.this;
        }
    }
    
    @Override
    public void onCreate() {
        super.onCreate();
        
        mNM = (NotificationManager)getSystemService(NOTIFICATION_SERVICE);
        showNotification();
        
        // Load settings
        mAjustes = PreferenceManager.getDefaultSharedPreferences(this);
        mAjustesPodometro = new AjustesPodometro(mAjustes);
        mState = getSharedPreferences("state", 0);

        acquireWakeLock();
        
        // Start detecting
        mStepDetector = new StepDetector();
        mSensorManager = (SensorManager) getSystemService(SENSOR_SERVICE);
        registerDetector();

        // Register our receiver for the ACTION_SCREEN_OFF action. This will make our receiver
        // code be called whenever the phone enters standby mode.
        IntentFilter filter = new IntentFilter(Intent.ACTION_SCREEN_OFF);
        registerReceiver(mReceiver, filter);

        mStepDisplayer = new StepDisplayer(mAjustesPodometro);
        mStepDisplayer.setSteps(mPasos = mState.getInt("pasos", 0));
        mStepDisplayer.addListener(mStepListener);
        mStepDetector.addStepListener(mStepDisplayer);

        mNotificarRatio = new NotificarRatio(mAjustesPodometro);
        mNotificarRatio.setPace(mRatio = mState.getInt("ratio", 0));
        mNotificarRatio.addListener(mRatioListener);
        mStepDetector.addStepListener(mNotificarRatio);

        mNotificarDistancia = new NotificarDistancia(mDistanciaListener, mAjustesPodometro);
        mNotificarDistancia.setDistance(mDistancia = mState.getFloat("distancia", 0));
        mStepDetector.addStepListener(mNotificarDistancia);
        
        mNotificarVelocidad    = new NotificarVelocidad(mVelocidadListener, mAjustesPodometro);
        mNotificarVelocidad.setSpeed(mVelocidad = mState.getFloat("velocidad", 0));
        mNotificarRatio.addListener(mNotificarVelocidad);
        
        // Used when debugging:
        // mStepBuzzer = new StepBuzzer(this);
        // mStepDetector.addStepListener(mStepBuzzer);

        // Start voice
        reloadSettings();

        // Tell the user we started.
        Toast.makeText(this, getText(R.string.iniciado), Toast.LENGTH_SHORT).show();
    }
    
    @Override
    public void onStart(Intent intent, int startId) {
        super.onStart(intent, startId);
    }

    @Override
    public void onDestroy() {
        // Unregister our receiver.
        unregisterReceiver(mReceiver);
        unregisterDetector();
        
        mStateEditor = mState.edit();
        mStateEditor.putInt("steps", mPasos);
        mStateEditor.putInt("pace", mRatio);
        mStateEditor.putFloat("distance", mDistancia);
        mStateEditor.putFloat("speed", mVelocidad);
        mStateEditor.commit();
        
        mNM.cancel(R.string.app_name);

        wakeLock.release();
        
        super.onDestroy();
        
        // Stop detecting
        mSensorManager.unregisterListener(mStepDetector);
        
        // Tell the user we stopped.
        Toast.makeText(this, getText(R.string.parado), Toast.LENGTH_SHORT).show();
    }

    private void registerDetector() {
        mSensor = mSensorManager.getDefaultSensor(
            Sensor.TYPE_ACCELEROMETER /*| 
            Sensor.TYPE_MAGNETIC_FIELD | 
            Sensor.TYPE_ORIENTATION*/);
        mSensorManager.registerListener(mStepDetector,
            mSensor,
            SensorManager.SENSOR_DELAY_FASTEST);
    }

    private void unregisterDetector() {
        mSensorManager.unregisterListener(mStepDetector);
    }

    @Override
    public IBinder onBind(Intent intent) {
        return mBinder;
    }

    /**
     * Receives messages from activity.
     */
    private final IBinder mBinder = new StepBinder();

    public interface ICallback {
        public void stepsChanged(int value);
        public void paceChanged(int value);
        public void distanceChanged(float value);
        public void speedChanged(float value);
    }
    
    private ICallback mCallback;

    public void registerCallback(ICallback cb) {
        mCallback = cb;
        //mStepDisplayer.passValue();
        //mRatioListener.passValue();
    }
    
    private int mDesiredPace;
    private float mDesiredSpeed;
    
    /**
     * Called by activity to pass the desired pace value, 
     * whenever it is modified by the user.
     * @param desiredPace
     */
    public void setDesiredPace(int desiredPace) {
        mDesiredPace = desiredPace;
        if (mNotificarRatio != null) {
            mNotificarRatio.setDesiredPace(mDesiredPace);
        }
    }
    /**
     * Called by activity to pass the desired speed value, 
     * whenever it is modified by the user.
     * @param desiredSpeed
     */
    public void setDesiredSpeed(float desiredSpeed) {
        mDesiredSpeed = desiredSpeed;
        if (mNotificarVelocidad != null) {
            mNotificarVelocidad.setDesiredSpeed(mDesiredSpeed);
        }
    }
    
    public void reloadSettings() {
    	mAjustes = PreferenceManager.getDefaultSharedPreferences(this);
        
        if (mStepDetector != null) { 
            mStepDetector.setSensitivity(
                    Integer.valueOf(mAjustes.getString("sensibilidad", "30"))
            );
        }
        
        if (mStepDisplayer    != null) mStepDisplayer.reloadSettings();
        if (mNotificarRatio     != null) mNotificarRatio.reloadSettings();
        if (mNotificarDistancia != null) mNotificarDistancia.reloadSettings();
        if (mNotificarVelocidad    != null) mNotificarVelocidad.reloadSettings();
    }
    
    public void resetValues() {
        mStepDisplayer.setSteps(0);
        mNotificarRatio.setPace(0);
        mNotificarDistancia.setDistance(0);
        mNotificarVelocidad.setSpeed(0);
    }
    
    /**
     * Forwards pace values from PaceNotifier to the activity. 
     */
    private StepDisplayer.Listener mStepListener = new StepDisplayer.Listener() {
        public void stepsChanged(int value) {
            mPasos = value;
            passValue();
        }
        public void passValue() {
            if (mCallback != null) {
                mCallback.stepsChanged(mPasos);
            }
        }
    };
    /**
     * Forwards pace values from PaceNotifier to the activity. 
     */
    private NotificarRatio.Listener mRatioListener = new NotificarRatio.Listener() {
        public void paceChanged(int value) {
            mRatio = value;
            passValue();
        }
        public void passValue() {
            if (mCallback != null) {
                mCallback.paceChanged(mRatio);
            }
        }
    };
    /**
     * Forwards distance values from DistanceNotifier to the activity. 
     */
    private NotificarDistancia.Listener mDistanciaListener = new NotificarDistancia.Listener() {
        public void valueChanged(float value) {
            mDistancia = value;
            passValue();
        }
        public void passValue() {
            if (mCallback != null) {
                mCallback.distanceChanged(mDistancia);
            }
        }
    };
    /**
     * Forwards speed values from SpeedNotifier to the activity. 
     */
    private NotificarVelocidad.Listener mVelocidadListener = new NotificarVelocidad.Listener() {
        public void valueChanged(float value) {
            mVelocidad = value;
            passValue();
        }
        public void passValue() {
            if (mCallback != null) {
                mCallback.speedChanged(mVelocidad);
            }
        }
    };
    /**
     * Show a notification while this service is running.
     */
    private void showNotification() {
        CharSequence text = getText(R.string.app_name);
        Notification notification = new Notification(R.drawable.ic_notification, null,
                System.currentTimeMillis());
        notification.flags = Notification.FLAG_NO_CLEAR | Notification.FLAG_ONGOING_EVENT;
        Intent pedometerIntent = new Intent();
        pedometerIntent.setComponent(new ComponentName(this, Podometro.class));
        pedometerIntent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        PendingIntent contentIntent = PendingIntent.getActivity(this, 0,
                pedometerIntent, 0);
        notification.setLatestEventInfo(this, text,
                getText(R.string.notification_subtitle), contentIntent);

        mNM.notify(R.string.app_name, notification);
    }


    // BroadcastReceiver for handling ACTION_SCREEN_OFF.
    private BroadcastReceiver mReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            // Check action just to be on the safe side.
            if (intent.getAction().equals(Intent.ACTION_SCREEN_OFF)) {
                // Unregisters the listener and registers it again.
                StepService.this.unregisterDetector();
                StepService.this.registerDetector();
                if (mAjustesPodometro.wakeAggressively()) {
                    wakeLock.release();
                    acquireWakeLock();
                }
            }
        }
    };

    private void acquireWakeLock() {
        PowerManager pm = (PowerManager) getSystemService(Context.POWER_SERVICE);
        int wakeFlags;
        if (mAjustesPodometro.wakeAggressively()) {
            wakeFlags = PowerManager.SCREEN_DIM_WAKE_LOCK | PowerManager.ACQUIRE_CAUSES_WAKEUP;
        }
        else if (mAjustesPodometro.keepScreenOn()) {
            wakeFlags = PowerManager.SCREEN_DIM_WAKE_LOCK;
        }
        else {
            wakeFlags = PowerManager.PARTIAL_WAKE_LOCK;
        }
        wakeLock = pm.newWakeLock(wakeFlags, TAG);
        wakeLock.acquire();
    }

}


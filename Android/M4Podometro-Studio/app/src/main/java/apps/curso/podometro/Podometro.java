
package apps.curso.podometro;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.preference.PreferenceManager;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;

public class Podometro extends Activity {
	@SuppressWarnings("unused")
	private static final String TAG = "Podometro";
    private SharedPreferences mAjustes;
    @SuppressWarnings("unused")
	private AjustesPodometro mAjustesPodometro;
    
    private TextView mPasoView;
    private TextView mRatioView;
    private TextView mDistanciaView;
    private TextView mVelocidadView;

    private int mPaso;
    private int mRatio;
    private float mDistancia;
    private float mVelocidad;
    
    /**
     * True, when service is running.
     */
    private boolean mIsRunning;
    
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        mPaso = 0;
        mRatio = 0;
        
        setContentView(R.layout.main);
        
        startStepService();
    }

    @Override
    protected void onResume() {
        super.onResume();
        
        mAjustes = PreferenceManager.getDefaultSharedPreferences(this);
        mAjustesPodometro = new AjustesPodometro(mAjustes);
        
        if (mIsRunning) { bindStepService(); }
        
        mPasoView     = (TextView) findViewById(R.id.pasos);
        mRatioView     = (TextView) findViewById(R.id.ratio);
        mDistanciaView = (TextView) findViewById(R.id.distancia);
        mVelocidadView    = (TextView) findViewById(R.id.velocidad);

        ((TextView) findViewById(R.id.unidades_distancia)).setText(getString(R.string.kilometros));
        ((TextView) findViewById(R.id.unidades_velocidad)).setText(getString(R.string.kilometros_por_hora));
        
    }
    
    @Override
    protected void onPause() {
        if (mIsRunning) {
            unbindStepService();
        }
        super.onPause();
    }

    @Override
    protected void onStop() {
        super.onStop();
    }

    protected void onDestroy() {
        super.onDestroy();
    }
    
    private StepService mService;
    
    private ServiceConnection mConnection = new ServiceConnection() {
        public void onServiceConnected(ComponentName className, IBinder service) {
            mService = ((StepService.StepBinder)service).getService();

            mService.registerCallback(mCallback);
            mService.reloadSettings();
            
        }

        public void onServiceDisconnected(ComponentName className) {
            mService = null;
        }
    };
    

    private void startStepService() {
        mIsRunning = true;
        startService(new Intent(Podometro.this,
                StepService.class));
    }
    
    private void bindStepService() {
        bindService(new Intent(Podometro.this, 
                StepService.class), mConnection, Context.BIND_AUTO_CREATE);
    }

    private void unbindStepService() {
        unbindService(mConnection);
    }
    
    private void stopStepService() {
        mIsRunning = false;
        if (mService != null) {
            stopService(new Intent(Podometro.this,
                  StepService.class));
        }
    }
    
    private void resetValues(boolean updateDisplay) {
        if (mService != null && mIsRunning) {
            mService.resetValues();                    
        }
        else {
            mPasoView.setText("0");
            mRatioView.setText("0");
            mDistanciaView.setText("0");
            mVelocidadView.setText("0");
            SharedPreferences state = getSharedPreferences("state", 0);
            SharedPreferences.Editor stateEditor = state.edit();
            if (updateDisplay) {
                stateEditor.putInt("pasos", 0);
                stateEditor.putInt("ratio", 0);
                stateEditor.putFloat("distancia", 0);
                stateEditor.putFloat("velocidad", 0);
                stateEditor.commit();
            }
        }
    }

    private static final int MENU_SETTINGS = 8;
    private static final int MENU_QUIT     = 9;

    private static final int MENU_PAUSE = 1;
    private static final int MENU_RESUME = 2;
    private static final int MENU_RESET = 3;
    
    /* Creates the menu items */
    public boolean onPrepareOptionsMenu(Menu menu) {
        menu.clear();
        if (mIsRunning) {
            menu.add(0, MENU_PAUSE, 0, R.string.pausa)
            .setIcon(android.R.drawable.ic_media_pause)
            .setShortcut('1', 'p');
        }
        else {
            menu.add(0, MENU_RESUME, 0, R.string.continuar)
            .setIcon(android.R.drawable.ic_media_play)
            .setShortcut('1', 'p');
        }
        menu.add(0, MENU_RESET, 0, R.string.reset)
        .setIcon(android.R.drawable.ic_menu_close_clear_cancel)
        .setShortcut('2', 'r');
        menu.add(0, MENU_SETTINGS, 0, R.string.ajustes)
        .setIcon(android.R.drawable.ic_menu_preferences)
        .setShortcut('8', 's')
        .setIntent(new Intent(this, Ajustes.class));
        menu.add(0, MENU_QUIT, 0, R.string.quit)
        .setIcon(android.R.drawable.ic_lock_power_off)
        .setShortcut('9', 'q');
        return true;
    }

    /* Handles item selections */
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case MENU_PAUSE:
                unbindStepService();
                stopStepService();
                return true;
            case MENU_RESUME:
                startStepService();
                bindStepService();
                return true;
            case MENU_RESET:
                resetValues(true);
                return true;
            case MENU_QUIT:
                resetValues(false);
                stopStepService();
                finish();
                return true;
        }
        return false;
    }
 
    private StepService.ICallback mCallback = new StepService.ICallback() {
        public void stepsChanged(int value) {
            mHandler.sendMessage(mHandler.obtainMessage(STEPS_MSG, value, 0));
        }
        public void paceChanged(int value) {
            mHandler.sendMessage(mHandler.obtainMessage(PACE_MSG, value, 0));
        }
        public void distanceChanged(float value) {
            mHandler.sendMessage(mHandler.obtainMessage(DISTANCE_MSG, (int)(value*1000), 0));
        }
        public void speedChanged(float value) {
            mHandler.sendMessage(mHandler.obtainMessage(SPEED_MSG, (int)(value*1000), 0));
        }
    };
    
    private static final int STEPS_MSG = 1;
    private static final int PACE_MSG = 2;
    private static final int DISTANCE_MSG = 3;
    @SuppressLint("HandlerLeak")
	private static final int SPEED_MSG = 4;
    
    @SuppressLint("HandlerLeak")
	private Handler mHandler = new Handler() {
        @Override public void handleMessage(Message msg) {
            switch (msg.what) {
                case STEPS_MSG:
                    mPaso = (int)msg.arg1;
                    mPasoView.setText("" + mPaso);
                    break;
                case PACE_MSG:
                    mRatio = msg.arg1;
                    if (mRatio <= 0) { 
                        mRatioView.setText("0");
                    } else {
                        mRatioView.setText("" + (int)mRatio);
                    }
                    break;
                case DISTANCE_MSG:
                	mDistancia = ((int)msg.arg1)/1000f;
                    if (mDistancia <= 0) { 
                        mDistanciaView.setText("0");
                    } else {
                        mDistanciaView.setText(
                                ("" + (mDistancia + 0.000001f)).substring(0, 5)
                        );
                    }
                    break;
                case SPEED_MSG:
                	mVelocidad = ((int)msg.arg1)/1000f;
                    if (mVelocidad <= 0) { 
                        mVelocidadView.setText("0");
                    } else {
                        mVelocidadView.setText(
                                ("" + (mVelocidad + 0.000001f)).substring(0, 4)
                        );
                    }
                    break;
                default:
                    super.handleMessage(msg);
            }
        }
        
    };
    
}
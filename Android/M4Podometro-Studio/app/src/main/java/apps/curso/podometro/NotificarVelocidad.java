

package apps.curso.podometro;

public class NotificarVelocidad implements NotificarRatio.Listener{

    public interface Listener {
        public void valueChanged(float value);
        public void passValue();
    }
    private Listener mListener;
    
    int mCounter = 0;
    float mSpeed = 0;
    float mStepLength;

    AjustesPodometro mSettings;

    /** Desired speed, adjusted by the user */
    float mDesiredSpeed;
  
    public NotificarVelocidad(Listener listener, AjustesPodometro settings) {
        mListener = listener;
        mSettings = settings;
        reloadSettings();
    }
    public void setSpeed(float speed) {
        mSpeed = speed;
        notifyListener();
    }
    public void reloadSettings() {
        mStepLength = mSettings.getStepLength();
    }
    public void setDesiredSpeed(float desiredSpeed) {
        mDesiredSpeed = desiredSpeed;
    }
    
    private void notifyListener() {
        mListener.valueChanged(mSpeed);
    }
    
    public void paceChanged(int value) {
        mSpeed = value * mStepLength / 100000f * 60f; // centimeters/kilometer
        notifyListener();
    }
    public void passValue() {
        // Not used
    }

}


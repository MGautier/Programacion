
package apps.curso.podometro;

public class NotificarDistancia implements StepListener {

    public interface Listener {
        public void valueChanged(float value);
        public void passValue();
    }
    private Listener mListener;
    
    float mDistance = 0;
    
    AjustesPodometro mSettings;
    
    float mStepLength;

    public NotificarDistancia (Listener listener, AjustesPodometro settings) {
        mListener = listener;
        mSettings = settings;
        reloadSettings();
    }
    public void setDistance(float distance) {
        mDistance = distance;
        notifyListener();
    }
    
    public void reloadSettings() {
        mStepLength = mSettings.getStepLength();
        notifyListener();
    }
    
    public void onStep() {
        
        mDistance += (float)(mStepLength / 100000.0); // centimeters/kilometer
                notifyListener();
    }
    
    private void notifyListener() {
        mListener.valueChanged(mDistance);
    }
    
    public void passValue() {
        // Callback of StepListener - Not implemented
    }

}


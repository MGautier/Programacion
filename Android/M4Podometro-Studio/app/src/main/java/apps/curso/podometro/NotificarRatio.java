

package apps.curso.podometro;

import java.util.ArrayList;

public class NotificarRatio implements StepListener {

    public interface Listener {
        public void paceChanged(int value);
        public void passValue();
    }
    private ArrayList<Listener> mListeners = new ArrayList<Listener>();
    
    int mCounter = 0;
    
    private long mLastStepTime = 0;
    private long[] mLastStepDeltas = {-1, -1, -1, -1};
    private int mLastStepDeltasIndex = 0;
    private long mPace = 0;
    
    AjustesPodometro mSettings;
    
    /** Desired pace, adjusted by the user */
    int mDesiredPace;

    public NotificarRatio (AjustesPodometro settings) {
        mSettings = settings;
    }
    public void setPace(int pace) {
        mPace = pace;
        int avg = (int)(60*1000.0 / mPace);
        for (int i = 0; i < mLastStepDeltas.length; i++) {
            mLastStepDeltas[i] = avg;
        }
        notifyListener();
    }
    
    public void addListener(Listener l) {
        mListeners.add(l);
    }

    public void setDesiredPace(int desiredPace) {
        mDesiredPace = desiredPace;
    }
    
    public void onStep() {
        mCounter ++;
        
        // Calculate pace based on last x steps
        if (mLastStepTime > 0) {
            long now = System.currentTimeMillis();
            long delta = now - mLastStepTime;
            
            mLastStepDeltas[mLastStepDeltasIndex] = delta;
            mLastStepDeltasIndex = (mLastStepDeltasIndex + 1) % mLastStepDeltas.length;
            
            long sum = 0;
            boolean isMeaningfull = true;
            for (int i = 0; i < mLastStepDeltas.length; i++) {
                if (mLastStepDeltas[i] < 0) {
                    isMeaningfull = false;
                    break;
                }
                sum += mLastStepDeltas[i];
            }
            if (isMeaningfull) {
                long avg = sum / mLastStepDeltas.length;
                mPace = 60*1000 / avg;
            }
            else {
                mPace = -1;
            }
        }
        mLastStepTime = System.currentTimeMillis();
        notifyListener();
    }
    
    private void notifyListener() {
        for (Listener listener : mListeners) {
            listener.paceChanged((int)mPace);
        }
    }
    
    public void reloadSettings() {
    	
    }
    
    public void passValue() {
        // Not used
    }
    

}


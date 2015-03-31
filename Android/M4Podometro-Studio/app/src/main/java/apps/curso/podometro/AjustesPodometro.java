

package apps.curso.podometro;

import android.content.SharedPreferences;

public class AjustesPodometro{

    SharedPreferences mSettings;
    
    public static int M_NONE = 1;
    public static int M_PACE = 2;
    public static int M_SPEED = 3;
    
    public AjustesPodometro(SharedPreferences settings) {
        mSettings = settings;
    }
    
    public float getStepLength() {
        try {
            return Float.valueOf(mSettings.getString("step_length", "20").trim());
        }
        catch (NumberFormatException e) {
            // TODO: reset value, & notify user somehow
            return 0f;
        }
    }
    
    public boolean isRunning() {
        return mSettings.getString("exercise_type", "running").equals("running");
    }

    public boolean wakeAggressively() {
        return mSettings.getString("operation_level", "run_in_background").equals("wake_up");
    }
    public boolean keepScreenOn() {
        return mSettings.getString("operation_level", "run_in_background").equals("keep_screen_on");
    }
}

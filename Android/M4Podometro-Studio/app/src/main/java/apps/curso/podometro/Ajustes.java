

package apps.curso.podometro;

import android.os.Bundle;
import android.preference.PreferenceActivity;

public class Ajustes extends PreferenceActivity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        addPreferencesFromResource(R.xml.preferencias);
    }
}

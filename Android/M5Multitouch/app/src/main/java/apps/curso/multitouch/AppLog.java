package apps.curso.multitouch;

import android.util.Log;

public class AppLog {
	private final static String APP_TAG = "apps.curso.multitouch";
	
	public static int log(String message){
		return Log.i(APP_TAG,message);
	}
}

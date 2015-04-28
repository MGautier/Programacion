package apps.curso.detectaletras;

import java.util.ArrayList;

import apps.curso.detectaletras.R;

import android.app.Activity;
import android.content.Intent;
import android.gesture.Gesture;
import android.gesture.GestureLibraries;
import android.gesture.GestureLibrary;
import android.gesture.GestureOverlayView;
import android.gesture.GestureOverlayView.OnGesturePerformedListener;
import android.gesture.Prediction;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class GestureActivity extends Activity {
	public static GestureLibrary gesturelib = null;
	
	private TextView gesturesText = null;
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        // Define la biblioteca de gestos a usar
        gesturelib = GestureLibraries.fromRawResource(this, R.raw.gestures);
        gesturesText = (TextView)findViewById(R.id.text_gestures);
        
        // Carga la biblioteca de gestos 
		if (!gesturelib.load()) {
			Log.w("GestureActivity", "No se puede cargar la Lista de Gestos");
			finish();
		}
		
		//Define la capa de Gestos
		GestureOverlayView gestureview = (GestureOverlayView)findViewById(R.id.gesture_view);
		Button button = (Button)findViewById(R.id.button_gestures);
		
		// Define los Listener para cada accion
		gestureview.addOnGesturePerformedListener(gesturelistener);
		button.setOnClickListener(btnClick);
    }
    
    // Crea el Listener de Gestos 
    private OnGesturePerformedListener gesturelistener = new OnGesturePerformedListener() {
		@Override
		// Detecta la realizacion de un gesto en la Vista de Gestos
		public void onGesturePerformed(GestureOverlayView overlay, Gesture gesture) {
			// Almacena una lista con las posibles soluciones y la puntuacion de cada una (ordenada de mayor a menor puntuacion)
			ArrayList<Prediction> predictions = gesturelib.recognize(gesture);

			gesturesText.setText("\n\nGesto previsto\n\n");
			
			if (predictions.size() > 1) {
				for(Prediction prediction: predictions){
					gesturesText.append("Nombre: " + prediction.name + ", Puntuación: " + prediction.score + "\n");
				}
			}

		}
	};
	
	private View.OnClickListener btnClick = new View.OnClickListener() {
		
		@Override
		public void onClick(View v) {
			startActivity(new Intent(GestureActivity.this,GestureList.class));
		}
	};
}
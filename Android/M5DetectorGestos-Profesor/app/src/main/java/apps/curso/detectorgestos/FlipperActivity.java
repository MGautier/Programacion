package apps.curso.detectorgestos;

import java.util.ArrayList;

import apps.curso.detectorgestos.R;

import android.app.Activity;
import android.graphics.Color;
import android.os.Bundle;
import android.os.Vibrator;
import android.view.GestureDetector;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.ViewGroup.LayoutParams;
import android.view.animation.Animation;
import android.view.animation.OvershootInterpolator;
import android.view.animation.TranslateAnimation;
import android.widget.TextView;
import android.widget.ViewFlipper;

public class FlipperActivity extends Activity 
							 implements GestureDetector.OnGestureListener,GestureDetector.OnDoubleTapListener{
	
	// Distancia minima del desplazamiento del dedo
	final private int SWIPE_MIN_DISTANCE = 100;
	// Velocidad minima del desplazamiento del dedo
	final private int SWIPE_MIN_VELOCITY = 100;
	
	private ViewFlipper flipper = null;
	private ArrayList<TextView> views = null;
	private GestureDetector gesturedetector = null;
	private Vibrator vibrator = null;
	//Colores de fondo de las vistas, tambien fija el numero de vistas en los desplazamientos
	int colors[] = { Color.rgb(255,128,128), Color.rgb(128,255,128), 
					 Color.rgb(128,128,255), Color.rgb(128,128,128), 
					 Color.BLUE, Color.GREEN, Color.YELLOW, Color.RED };
	
	private Animation animleftin = null;
	private Animation animleftout = null;
	
	private Animation animrightin = null;
	private Animation animrightout = null;
	
	private Animation animupin = null;
	private Animation animupout = null;
	
	private Animation animdownin = null;
	private Animation animdownout = null;
	
	private boolean isDragMode = false;
	private int currentview = 0;
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        flipper = new ViewFlipper(this);
        gesturedetector = new GestureDetector(this, this);
        vibrator = (Vibrator)getSystemService(VIBRATOR_SERVICE);
        gesturedetector.setOnDoubleTapListener(this);
        
        flipper.setInAnimation(animleftin);
        flipper.setOutAnimation(animleftout);
        flipper.setFlipInterval(3000);
        flipper.setAnimateFirstView(true);

        prepareAnimations();
        prepareViews();
        addViews();
        setViewText();
        
        setContentView(flipper);
    }

    // Fija los tipos de transicion entre vistas
	private void prepareAnimations() {
		animleftin = new TranslateAnimation(
        		Animation.RELATIVE_TO_PARENT,  +1.0f, Animation.RELATIVE_TO_PARENT,  0.0f,
        		Animation.RELATIVE_TO_PARENT,  0.0f, Animation.RELATIVE_TO_PARENT,   0.0f);
        		
        animleftout = new TranslateAnimation(
        		Animation.RELATIVE_TO_PARENT,  0.0f, Animation.RELATIVE_TO_PARENT,  -1.0f,
        		Animation.RELATIVE_TO_PARENT,  0.0f, Animation.RELATIVE_TO_PARENT,  0.0f);
        
        animrightin = new TranslateAnimation(
        		Animation.RELATIVE_TO_PARENT,  -1.0f, Animation.RELATIVE_TO_PARENT,  0.0f,
        		Animation.RELATIVE_TO_PARENT,  0.0f, Animation.RELATIVE_TO_PARENT,   0.0f);
        		
        animrightout = new TranslateAnimation(
        		Animation.RELATIVE_TO_PARENT,  0.0f, Animation.RELATIVE_TO_PARENT,  +1.0f,
        		Animation.RELATIVE_TO_PARENT,  0.0f, Animation.RELATIVE_TO_PARENT,  0.0f);
        
        animupin = new TranslateAnimation(
        		Animation.RELATIVE_TO_PARENT,  0.0f, Animation.RELATIVE_TO_PARENT,  0.0f,
        		Animation.RELATIVE_TO_PARENT,  +1.0f, Animation.RELATIVE_TO_PARENT,   0.0f);
        		
        animupout = new TranslateAnimation(
        		Animation.RELATIVE_TO_PARENT,  0.0f, Animation.RELATIVE_TO_PARENT,  0.0f,
        		Animation.RELATIVE_TO_PARENT,  0.0f, Animation.RELATIVE_TO_PARENT,  -1.0f);
        
        animdownin = new TranslateAnimation(
        		Animation.RELATIVE_TO_PARENT,  0.0f, Animation.RELATIVE_TO_PARENT,  0.0f,
        		Animation.RELATIVE_TO_PARENT,  -1.0f, Animation.RELATIVE_TO_PARENT,   0.0f);
        		
        animdownout = new TranslateAnimation(
        		Animation.RELATIVE_TO_PARENT,  0.0f, Animation.RELATIVE_TO_PARENT,  0.0f,
        		Animation.RELATIVE_TO_PARENT,  0.0f, Animation.RELATIVE_TO_PARENT,  +1.0f);
        
        //Duracion de las transiciones
        animleftin.setDuration(1000);
        animleftin.setInterpolator(new OvershootInterpolator());
        animleftout.setDuration(1000);
        animleftout.setInterpolator(new OvershootInterpolator());
        
        animrightin.setDuration(1000);
        animrightin.setInterpolator(new OvershootInterpolator());
        animrightout.setDuration(1000);
        animrightout.setInterpolator(new OvershootInterpolator());
        
        animupin.setDuration(1000);
        animupin.setInterpolator(new OvershootInterpolator());
        animupout.setDuration(1000);
        animupout.setInterpolator(new OvershootInterpolator());
        
        animdownin.setDuration(1000);
        animdownin.setInterpolator(new OvershootInterpolator());
        animdownout.setDuration(1000);
        animdownout.setInterpolator(new OvershootInterpolator());
	}
	
	// Crea las vistas y el texto a mostrar
	private void prepareViews(){
		TextView view = null;
		
		views = new ArrayList<TextView>();
		
		for(int color: colors)
		{
			view = new TextView(this);
			
			view.setBackgroundColor(color);
			view.setTextColor(Color.BLACK);
			view.setTextSize(30);
			view.setGravity(Gravity.CENTER_HORIZONTAL | Gravity.CENTER_VERTICAL);
			
			views.add(view);
		}
	}
	
	private void addViews(){
		for(int index=0; index<views.size(); ++index)
		{
			flipper.addView(views.get(index),index,
					new LayoutParams(LayoutParams.FILL_PARENT, LayoutParams.FILL_PARENT));
		}
	}
	
	private void setViewText(){
		String text = getString(isDragMode ? R.string.app_info_drag : R.string.app_info_flip);
		for(int index=0; index<views.size(); ++index)
		{
			views.get(index).setText(text);
		}
	}

	@Override
	public boolean onTouchEvent(MotionEvent event) {
		return gesturedetector.onTouchEvent(event);
	}

	@Override
	public boolean onDown(MotionEvent e) {
		return false;
	}

	@Override
	// Detecta los movimientos de desplazamiento durante el onDown inicial del MotionEvent
	// Mueve la vista segun se realice el desplazamiento
	// Calcula la velocidad en base a la distancia que se recorre entre los dos eventos
	public boolean onFling(MotionEvent event1, MotionEvent event2, float velocityX,float velocityY) {
		if(isDragMode)
			return false;
		
		final float ev1x = event1.getX();
		final float ev1y = event1.getY();
		final float ev2x = event2.getX();
		final float ev2y = event2.getY();
		final float xdiff = Math.abs(ev1x - ev2x);
		final float ydiff = Math.abs(ev1y - ev2y);
		final float xvelocity = Math.abs(velocityX);
		final float yvelocity = Math.abs(velocityY);
		
		if(xvelocity > this.SWIPE_MIN_VELOCITY && xdiff > this.SWIPE_MIN_DISTANCE)
		{
			if(ev1x > ev2x) //Swipe Izquierda
			{
				--currentview;
				if(currentview < 0) { currentview = views.size() - 1; }
				flipper.setInAnimation(animleftin);
				flipper.setOutAnimation(animleftout);
			}
			else //Swipe Derecha
			{
				++currentview;
				if(currentview >= views.size()) { currentview = 0; }				
				flipper.setInAnimation(animrightin);
				flipper.setOutAnimation(animrightout);
			}
			flipper.scrollTo(0,0);
			flipper.setDisplayedChild(currentview);
		}
		else if(yvelocity > this.SWIPE_MIN_VELOCITY && ydiff > this.SWIPE_MIN_DISTANCE)
		{
			if(ev1y > ev2y) //Swipe Arriba
			{
				--currentview;
				if(currentview < 0) { currentview = views.size() - 1; }				
				flipper.setInAnimation(animupin);
				flipper.setOutAnimation(animupout);
			}
			else //Swipe Abajo
			{
				++currentview;
				if(currentview >= views.size()) { currentview = 0; }
				flipper.setInAnimation(animdownin);
				flipper.setOutAnimation(animdownout);
			}
			flipper.scrollTo(0,0);
			flipper.setDisplayedChild(currentview);
		}
				
		return false;
	}

	@Override
	// Detecta la pulsacion larga durante el onDown inicial del MotionEvent
	public void onLongPress(MotionEvent e) {
		vibrator.vibrate(200);
		flipper.scrollTo(0,0);
		isDragMode = !isDragMode;
		setViewText();
	}

	@Override
	// Detecta la pulsacion larga durante el onDown y el Move inicial del MotionEvent
	public boolean onScroll(MotionEvent e1, MotionEvent e2, float distanceX,float distanceY) {
		if(isDragMode)	flipper.scrollBy((int)distanceX, (int)distanceY);
		
		return false;
	}

	@Override
	// Detecta que pulsamos, pero no nos movemos
	public void onShowPress(MotionEvent e) {
	}

	@Override
	// Detecta la pulsacion simple
	public boolean onSingleTapUp(MotionEvent e) {
		return false;
	}

	@Override
	// Detecta la pulsacion doble
	public boolean onDoubleTap(MotionEvent e) {
		flipper.scrollTo(0,0);
		
		return false;
	}

	@Override
	// Detecta movimientos durante la pulsacion doble
	public boolean onDoubleTapEvent(MotionEvent e) {
		return false;
	}

	@Override
	//Confirma la pulsacion simple
	public boolean onSingleTapConfirmed(MotionEvent e) {
		return false;
	}
}
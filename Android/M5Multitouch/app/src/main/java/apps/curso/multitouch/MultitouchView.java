package apps.curso.multitouch;

import java.util.ArrayList;
import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.PointF;
import android.util.AttributeSet;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;

public class MultitouchView extends View {
	private static final int STROKE_WIDTH = 3;
	private static final int CIRCLE_RADIUS = 10;
	
	// Lista de puntos pulsados en la pantalla
	private ArrayList<PointF> touchPoints = null;
	private Paint drawingPaint = null;
	
	public MultitouchView(Context context) {
		super(context);
		initialize();
	}

	public MultitouchView(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
		initialize();
	}

	public MultitouchView(Context context, AttributeSet attrs) {
		super(context, attrs);
		initialize();
	}
	
	@Override
	// Muestra los puntos en la pantalla (incluidos la linea y el punto medio)
	protected void onDraw(Canvas canvas) {
		super.onDraw(canvas);
		
		if(touchPoints.size() > 0)
		{
			if(touchPoints.size() == 1) // Muesta un punto en pantalla
			{
				canvas.drawCircle(touchPoints.get(0).x,touchPoints.get(0).y, 
						CIRCLE_RADIUS, drawingPaint);
			}
			else // Muestra un los puntos unidos con una linea y el punto medio
			{
				PointF midpt = null;
				for(int index=1; index<touchPoints.size(); ++index)
				{
					midpt = getMidPoint(
							touchPoints.get(index - 1).x,touchPoints.get(index - 1).y,
							touchPoints.get(index).x,touchPoints.get(index).y);
					canvas.drawCircle(
							touchPoints.get(index - 1).x,touchPoints.get(index - 1).y, 
							CIRCLE_RADIUS, drawingPaint);
					canvas.drawCircle(touchPoints.get(index).x,touchPoints.get(index).y, 
							CIRCLE_RADIUS, drawingPaint);
					canvas.drawLine(
							touchPoints.get(index - 1).x,touchPoints.get(index - 1).y,
							touchPoints.get(index).x,touchPoints.get(index).y,
							drawingPaint);
					canvas.drawCircle(midpt.x,midpt.y, CIRCLE_RADIUS/2, drawingPaint);
				}
			}
			// Redibuja el canvas
			invalidate();
		} 
			
	}


    public boolean onInterceptTouchEvent(MotionEvent event)
    {
        try {
            return super.onTouchEvent(event);
        }catch (IllegalArgumentException ex) {
            ex.printStackTrace();
        }

        return false;

    }
	
	@Override
	// METODO IMPORTANTE
	// Control de la multipulsacion de la pantalla
	public boolean onTouchEvent(MotionEvent event) {
		super.onTouchEvent(event);
		
		// Define que accion se esta realizando en la pantalla
		@SuppressWarnings("unused")
		int action = event.getAction() & MotionEvent.ACTION_MASK;

        switch (action) {
            // Pulsamos
            case MotionEvent.ACTION_DOWN: {

                invalidate(); // Redibuja
                setPoints(event); // Fija los puntos

                Log.i("INFO", "Presión: " + event.getPressure());
                Log.i("INFO", "Tamaño: " + event.getSize());
                break;
            }
            // Movemos
            case MotionEvent.ACTION_MOVE: {

                invalidate();
                setPoints(event); // Fija puntos nuevos

                Log.i("INFO", "Presión: " + event.getPressure());
                Log.i("INFO", "Tamaño: " + event.getSize());
                break;
            }
            // Levantamos
            case MotionEvent.ACTION_UP: {
                initialize();  // Borra la pantalla
                break;

            }

            case MotionEvent.ACTION_POINTER_DOWN: {
                // Pulsamos con mas de un dedo
                setPoints(event);
                invalidate();
                if(touchPoints.size() == 5)
                    Log.i("INFO","Cinco dedos");
                if(touchPoints.size() == 10)
                    Log.i("INFO", "Diez dedos");
                break;
            }

            case MotionEvent.ACTION_POINTER_UP: {
                initialize();
                break;
            }
        }
		
		
		return true;
	}	
	
	private void initialize(){
		drawingPaint = new Paint();
		drawingPaint.setColor(Color.RED);
		drawingPaint.setStrokeWidth(STROKE_WIDTH);
		drawingPaint.setStyle(Paint.Style.FILL);
		drawingPaint.setAntiAlias(true);
		touchPoints = new ArrayList<PointF>();
	}
	
	public void setPoints(MotionEvent event){
		// Elimina la lista anterior
		touchPoints.clear();
		int pointerIndex = 0;
        int number_points = event.getPointerCount();
		for(int index=0; index < number_points; ++index)
		{
			// Obtiene la lista de puntos pulsados del MotionEvent


            pointerIndex = event.findPointerIndex(event.getPointerId(index));
            try {
                touchPoints.add(new PointF(event.getX(pointerIndex),event.getY(pointerIndex)));
            }catch (IllegalArgumentException ex){
                ex.printStackTrace();
            }



		}
	}

	private PointF getMidPoint(float x1,float y1, float x2, float y2) {
		PointF point = new PointF();
		
		float x = x1 + x2;
		float y = y1 + y2;
		
		point.set(x / 2, y / 2);
		
		return point;
	}
}
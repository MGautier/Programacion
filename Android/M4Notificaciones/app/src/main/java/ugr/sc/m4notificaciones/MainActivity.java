package ugr.sc.m4notificaciones;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.support.v4.app.NotificationCompat;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Toast;


public class MainActivity extends ActionBarActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if(getIntent().getExtras() != null)
        {
            boolean mostrarToast = getIntent().getExtras().getBoolean("Desde notificación", false);
            if(mostrarToast)
            {
                Toast.makeText(this, "Desde notificación", Toast.LENGTH_SHORT).show();
            }
        }


    }

    public void mostrarNotificaciones(View button)
    {
        NotificationManager mNotificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);

        // Agregamos ahora el icono, el texto y momento para lanzar la aplicacion

        int icon = R.mipmap.ic_launcher;
        CharSequence tickerText = "Notification Bar";
        long when = System.currentTimeMillis();

        Notification notification;
        Context context = getApplicationContext();
        CharSequence contentTitle = "Notificación en barra";
        CharSequence contentText = "Mensaje corto de la notificación";

        final int sdkVersion = Build.VERSION.SDK_INT;
        Intent notificationIntent = new Intent(this, MainActivity.class);
        notificationIntent.putExtra("Desde Notificacion", true);
        PendingIntent contentIntent = PendingIntent.getActivity(this, 0, notificationIntent, 0);

        if (sdkVersion < Build.VERSION_CODES.HONEYCOMB)
        {
            notification = new Notification(icon,tickerText,when);
            notification.setLatestEventInfo(context,contentTitle,contentText,contentIntent);

            // Damos sonido

            notification.defaults |= Notification.DEFAULT_SOUND;

            // Damos vibración

            notification.defaults |= Notification.DEFAULT_VIBRATE;

            // oculta la notificación una vez pulsada

            notification.flags |= Notification.FLAG_AUTO_CANCEL;

            mNotificationManager.notify(0,notification);

        }
        else
        {
            NotificationCompat.Builder builder = new NotificationCompat.Builder(this);

            notification = builder.setContentIntent(contentIntent)
                    .setSmallIcon(icon).setTicker(tickerText).setWhen(when)
                    .setAutoCancel(true).setContentTitle(contentTitle)
                    .setContentText(contentText).build();

            mNotificationManager.notify(0, notification);
        }
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}

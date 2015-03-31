package ugr.sc.m2ciclovidaactividad;

import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.util.Log;


public class CicloVidaActivity extends ActionBarActivity {

    /* Atributos de la clase */



    @Override
    protected void onStart() {
        super.onStart();
        Log.d(szCabecera,"Ejecutando onStart");
    }

    @Override
    protected void onPause() {
        super.onPause();
        Log.d(szCabecera,"Ejecutando onPause");
    }

    @Override
    protected void onRestart() {
        super.onRestart();
        Log.d(szCabecera,"Ejecutando onRestart");
    }

    @Override
    protected void onResume() {
        super.onResume();
        Log.d(szCabecera,"Ejecutando onResume");
    }

    @Override
    protected void onStop() {
        super.onStop();
        Log.d(szCabecera,"Ejecutando onStop");
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Log.d(szCabecera,"Ejecutando onDestroy");
    }

    String szCabecera = "Función en ejecución";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ciclo_vida);
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_ciclo_vida, menu);
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

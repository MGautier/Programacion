package com.sc.ugr.m4actionbare;

import android.app.ActionBar;
import android.app.Activity;
import android.content.ClipData;
import android.support.v4.view.MenuItemCompat;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.support.v7.internal.view.menu.MenuBuilder;
import android.support.v7.widget.SearchView;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;


public class MainActivity extends ActionBarActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);

        // Incluyo un callback para la llamada del metodo Search del actionBar

        MenuItem searchItem = menu.findItem(R.id.search);
        SearchView searchView = (SearchView) MenuItemCompat.getActionView(searchItem);

        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
       //TODO Identificar que opcion fué la que se pulso

        switch (item.getItemId())
        {
            case R.id.add:
                Toast.makeText(getApplicationContext(), "Has seleccionado la opción de añadir", Toast.LENGTH_LONG).show();
                return true;

            case R.id.search:
                Toast.makeText(getApplicationContext(), "Has seleccionado la opción de buscar", Toast.LENGTH_LONG).show();
                return true;

            case R.id.edit:
                Toast.makeText(getApplicationContext(), "Has seleccionado la opción de edición", Toast.LENGTH_LONG).show();
                return true;

            case R.id.delete:
                Toast.makeText(getApplicationContext(), "Has seleccionado la opción de borrar", Toast.LENGTH_LONG).show();
                return true;

            case R.id.action_settings:
                Toast.makeText(getApplicationContext(), "Has seleccionado la opción de configuración", Toast.LENGTH_LONG).show();
                return true;

            default:
                return super.onOptionsItemSelected(item);
        }

    }
}

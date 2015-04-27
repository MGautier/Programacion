package com.sc.ugr.m4fragmentde;

import android.app.Activity;
import android.app.Fragment;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;


public class MainActivity extends Activity implements View.OnClickListener{

    private Button add_fragment ;
    private FragmentManager fragmentManager;
    private FragmentTransaction transaction;
    private BlankFragment fragment;


    @Override
    protected void onCreate(final Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        add_fragment = (Button)findViewById(R.id.add_fragment);

        //Seteando la escucha del botón
        add_fragment.setOnClickListener(this);
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

    @Override
    public void onClick(View v) {
        
        Fragment main_fragment = getFragmentManager().findFragmentByTag("main_fragment");

        fragmentManager = getFragmentManager();
        transaction = fragmentManager.beginTransaction();
        transaction.remove(main_fragment).commit();

        fragment = new BlankFragment();

        transaction.add(R.id.contenedor,fragment,"main_fragment");
        transaction.commit();
    }
}

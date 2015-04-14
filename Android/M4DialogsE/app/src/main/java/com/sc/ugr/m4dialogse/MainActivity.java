package com.sc.ugr.m4dialogse;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.preference.DialogPreference;
import android.provider.ContactsContract;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.view.View.OnClickListener;
import android.widget.Toast;

import java.util.Enumeration;

public class MainActivity extends ActionBarActivity {

    final String[] StrItems = {"Español", "Inglés", "Francés"};
    boolean[] CheckedItems = new boolean [StrItems.length];

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        inicializaUI();
    }

    protected void inicializaUI(){

        Button BtnBotones=(Button) findViewById(R.id.botones);


        BtnBotones.setOnClickListener(new OnClickListener(){

            public void onClick(View v) {
                // Abrimos el dialogo correspondiente a la id 0 (dialogo de botones)
                ((Dialog) crear_dialogo(0)).show();


            }

        });


        Button Btnlistas=(Button) findViewById(R.id.listas);
        Btnlistas.setOnClickListener(new OnClickListener(){

            public void onClick(View v) {
                // Abrimos el dialogo correspondiente a la id 1 (dialogo de listas)
                ((Dialog) crear_dialogo(1)).show();

            }

        });


        Button BtnCheck=(Button) findViewById(R.id.check);
        BtnCheck.setOnClickListener(new OnClickListener(){

            public void onClick(View v) {
                // Abrimos el dialogo correspondiente a la id 2 (dialogo de listas)
                ((Dialog) crear_dialogo(2)).show();

            }
        });

        Button BtnRadio=(Button) findViewById(R.id.radio);
        BtnRadio.setOnClickListener(new OnClickListener(){

            public void onClick(View v) {
                // Abrimos el dialogo correspondiente a la id 3 (dialogo de listas)
                ((Dialog) crear_dialogo(3)).show();

            }

        });
    }

    protected Dialog crear_dialogo(int id) {
        Dialog DiaResult=null;
        switch (id) {
            case 0:
                DiaResult=crearDialogoConfirmacion();
                break;
            case 1:
                DiaResult=crearDialogoSeleccion();
                break;
            case 2:
                DiaResult=crearDialogoCheckBox();
                break;
            case 3:
                DiaResult=crearDialogoRadioButton();
                break;
        }
        return DiaResult;
    }


    //Metodo para brear un dialogo con botones de confirmación
    private Dialog crearDialogoConfirmacion(){

        AlertDialog.Builder Altbuilder = new AlertDialog.Builder(this);

        Altbuilder.setTitle("Confirmacion");
        Altbuilder.setMessage("¿Confirma la accion seleccionada?");
        //TODO añadir los botones de cofirmación

        Altbuilder.setPositiveButton("Aceptar", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.cancel();
            }
        });

        Altbuilder.setNegativeButton("Cancelar", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.cancel();
            }
        });

        return Altbuilder.create();
    }


    //Función para el dialogo de selección
    private Dialog crearDialogoSeleccion()
    {


        AlertDialog.Builder Altbuilder = new AlertDialog.Builder(this);

        //TODO crear un dialogo con la lista incluida en la variable "items"

        Altbuilder.setTitle("Selección");
        Altbuilder.setItems(StrItems, new DialogInterface.OnClickListener(){

            public void onClick(DialogInterface DiaInt, int item)
            {
                Toast.makeText(getApplicationContext(), "Opción elegida: " + StrItems[item], Toast.LENGTH_SHORT).show();
            }
        });

        return Altbuilder.create();
    }

    //Función para el dialogo de seleccion unica
    private Dialog crearDialogoCheckBox()
    {



        AlertDialog.Builder Altbuilder = new AlertDialog.Builder(this);

        //TODO crear un dialogo con la lista incluida en la variable "items", se usará un checkbox para permitir opciones multiples

        Altbuilder.setTitle("Selección");
        Altbuilder.setMultiChoiceItems(StrItems, CheckedItems, new DialogInterface.OnMultiChoiceClickListener() {
            @Override
            public void onClick(DialogInterface DiaInt, int item, boolean isChecked) {
                Toast.makeText(getApplicationContext(), "Opción elegida: " + StrItems[item], Toast.LENGTH_SHORT).show();
            }
        });

        //TODO añadir las botones aceptar y cancelar como en el caso del dialogo de confirmación (se puede hacer copy&paste del metodo crearDialogoConfirmacion)

        Altbuilder.setPositiveButton("Aceptar", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface DiaInt, int item) {
                Toast.makeText(getApplicationContext(), "¡Ok!", Toast.LENGTH_SHORT).show();
                DiaInt.cancel();
            }
        });

        Altbuilder.setNegativeButton("Cancelar", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface DiaInt, int item) {
                Toast.makeText(getApplicationContext(), "¡Cancelar!", Toast.LENGTH_SHORT).show();
                DiaInt.cancel();
            }
        });

        return Altbuilder.create();

    }

    //Función para el dialogo de selección multiple
    private Dialog crearDialogoRadioButton()
    {


        AlertDialog.Builder Altbuilder = new AlertDialog.Builder(this);

        //TODO crear un dialogo con la lista incluida en la variable "items", se usará un radiobutton para evitar opciones multiples

        Altbuilder.setTitle("Selección");

        Altbuilder.setSingleChoiceItems(StrItems, -1, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface DiaInt, int item) {
                Toast.makeText(getApplicationContext(), "Opción elegida: " + StrItems[item], Toast.LENGTH_SHORT).show();
            }
        });

        //TODO añadir las botones aceptar y cancelar como en el caso del dialogo de confirmación (se puede hacer copy&paste del metodo crearDialogoConfirmacion)

        Altbuilder.setPositiveButton("Aceptar", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface DiaInt, int item) {
                Toast.makeText(getApplicationContext(), "¡Ok!", Toast.LENGTH_SHORT).show();
                DiaInt.cancel();
            }
        });

        Altbuilder.setNegativeButton("Cancelar", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface DiaInt, int item) {
                Toast.makeText(getApplicationContext(), "¡Cancelar!", Toast.LENGTH_SHORT).show();
                DiaInt.cancel();
            }
        });


        return Altbuilder.create();
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

package com.sc.ugr.m4fragmente;

import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import java.nio.BufferUnderflowException;

/**
 * Created by MGautier on 22/04/15.
 */

public class MyFragment extends Fragment {

    /* Instancio los objetos de la vista myfragment */

    private Button boton;
    private EditText edit;
    private TextView texto;

    public MyFragment()
    {

    }

    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState)
    {
        View view = inflater.inflate(R.layout.myfragment, container, false);

        boton = (Button) view.findViewById(R.id.main_button);
        edit = (EditText) view.findViewById(R.id.main_editText);
        texto = (TextView) view.findViewById(R.id.main_textview);

        boton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String msg = edit.getText().toString();
                texto.setText(String.valueOf(msg.length()));
            }
        });

        return view;
    }
}

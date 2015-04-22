package com.sc.ugr.m4fragmentde;

import android.app.Activity;
import android.net.Uri;
import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RelativeLayout;
import android.widget.TextView;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the

 * to handle interaction events.
 */
public class BlankFragment extends Fragment {

    private Button boton;
    private EditText edit;
    private TextView text;

    public BlankFragment() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        View view=inflater.inflate(R.layout.fragment_blank, container, false);

        //Nuevos parametros para el view del fragmento
        RelativeLayout.LayoutParams params =    new RelativeLayout.LayoutParams(
                RelativeLayout.LayoutParams.MATCH_PARENT,
                RelativeLayout.LayoutParams.MATCH_PARENT);
        //Nueva Regla: EL fragmento estara debajo del boton add_fragment
        params.addRule(RelativeLayout.BELOW, R.id.add_fragment);
        //Margenes: top:41dp
        params.setMargins(0,41,0,0);
        //Setear los parametros al view
        view.setLayoutParams(params);

        // Inflate the layout for this fragment
        boton = (Button)view.findViewById(R.id.main_button);
        edit = (EditText)view.findViewById(R.id.main_editText);
        text = (TextView)view.findViewById(R.id.main_textview);

        boton.setOnClickListener( new View.OnClickListener() {

            public void onClick(View view){

                String mensaje = edit.getText().toString();
                text.setText(String.valueOf(mensaje.length()));

            }

        });
        return view;
    }



}

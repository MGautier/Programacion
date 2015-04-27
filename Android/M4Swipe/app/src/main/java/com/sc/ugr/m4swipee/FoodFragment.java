package com.sc.ugr.m4swipee;

import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

/**
 * Created by MGautier on 27/04/15.
 */

public class FoodFragment extends android.support.v4.app.Fragment {

    // Variables internas
    // Array de enteros que contienen los valores de las imagenes en el sistema (drawable)

    static int[] imgIds = {R.drawable.platillo, R.drawable.muffin, R.drawable.milkshake};

    public static final String ARG_SECTION_NAME = "section_name";
    public static final String ARC_SECTION_IMAGE = "section_image";

    /**
     * Método consultor (sobreescrito) onCreateView
     * @param inflater
     * @param container
     * @param savedInstanceState
     * @return Devuelve la vista actual
     */
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState)
    {
        View rootView = inflater.inflate(R.layout.fragment_food, container, false);

        Bundle args = getArguments();

        ImageView image = (ImageView) rootView.findViewById(R.id.imageView);
        image.setImageResource(imgIds[args.getInt(ARC_SECTION_IMAGE)]);

        ((TextView) rootView.findViewById(android.R.id.text1)).setText(getString(R.string.section_title) +" "+args.getString(ARG_SECTION_NAME) );

        return rootView;
    }
}

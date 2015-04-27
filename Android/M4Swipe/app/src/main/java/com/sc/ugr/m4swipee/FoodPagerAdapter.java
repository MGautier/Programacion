package com.sc.ugr.m4swipee;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;

/**
 * Created by MGautier on 27/04/15.
 */

public class FoodPagerAdapter extends FragmentPagerAdapter {

    /**
     * Constructor de la clase
     * @param fm Pasamos a la superclase un objeto extendido de FragmenManager
     */
    public FoodPagerAdapter(FragmentManager fm) {
        super(fm);
    }

    /**
     * Método consultor (sobreescrito) getItem
     * @param position Lugar de los fragments que actualmente se visualizan en pantalla
     * @return Devuelve el fragment según la posición de la pantalla recorrida
     */

    @Override
    public Fragment getItem(int position) {
        // Crear un FoodFragment con el nombre como argumento

       Fragment fragment = new FoodFragment();
       Bundle args = new Bundle();
       args.putString(FoodFragment.ARG_SECTION_NAME, getPageTitle(position).toString());
       args.putInt(FoodFragment.ARC_SECTION_IMAGE,position);
       fragment.setArguments(args);

       return fragment;
    }

    /**
     * Método consultor (sobreescrito) getCount
     * @return Devuelve el número de item/fragment del que se compone la aplicacion
     */

    @Override
    public int getCount() {
        return 3;
    }

    /**
     * Método consultor (sobreescrito) getPageTitle
     * @param position Lugar de los fragments que actualmente se visualizan en pantalla
     * @return Devuelve el título asociado al fragment para visualizarlo en la pantalla (parte inferior)
     */

    @Override
    public CharSequence getPageTitle(int position)
    {
        switch (position){
            case 0: return "PLATILLOS";
            case 1: return "POSTRES";
            case 2: return "BEBIDAS";
            default: return "";
        }
    }
}

package ugr.sc.m4listimageview;

import android.media.Image;

import java.net.URL;
import java.util.HashMap;

/**
 * Created by MGautier on 20/04/15.
 */
public class Equipo {

    private String nombre_equipo; // Nombre del equipo de fútbol
    private String web_equipo; // URL que contiene la web del equipo
    private int escudo_equipo; // Entero del recurso imagen del escudo

    /**
     * Constructor de la clase
     * @param nombre_equipo Nombre del equipo de fútbol
     * @param web_equipo Web del equipo de fútbol
     * @param escudo_equipo Logo que representa el escudo del equipo
     */

    public Equipo (String nombre_equipo, String web_equipo, int escudo_equipo)
    {
        this.nombre_equipo = nombre_equipo;
        this.web_equipo = web_equipo;
        this.escudo_equipo = escudo_equipo;
    }

    /**
     * Método consultor
     * @return Devuelve el nombre del equipo de fútbol
     */

    public String getEquipo()
    {
        return nombre_equipo;
    }

    /**
     * Método modificador
     * @param nombre Nombre del equipo de fútbol a modificar
     */

    public void setEquipo(String nombre)
    {
        if(!nombre_equipo.contentEquals(nombre))
            nombre_equipo = nombre;
    }

    /**
     * Método consultor
     * @return Devuelve la url de la web del equipo
     */

    public String getWeb()
    {
        return web_equipo;
    }

    /**
     * Método modificador
     * @param web URL de la web del equipo a modificar
     */

    public void setWeb(String web)
    {
        if(!web_equipo.equals(web))
            web_equipo = web;
    }

    /**
     * Método consultor
     * @return Devuelve el nombre del archivo que representa el escudo del equipo
     */

    public int getEscudo()
    {
        return escudo_equipo;
    }

    /**
     * Método modificador
     * @param escudo Valor del nuevo archivo que representa el escudo del equipo
     */

    public void setEscudo(int escudo)
    {
        if(escudo_equipo != escudo)
            escudo_equipo = escudo;
    }
}

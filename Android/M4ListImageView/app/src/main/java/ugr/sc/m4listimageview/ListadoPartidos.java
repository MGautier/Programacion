package ugr.sc.m4listimageview;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by MGautier on 20/04/15.
 */
public class ListadoPartidos {

    static public List partidos = new ArrayList<Partido>();

    static private Equipo eq_uno = new Equipo("Real Madrid CF", "www.realmadrid.com", R.mipmap.rm_cf_logo);
    static private Equipo eq_dos = new Equipo("FC Barcelona", "www.fcbarcelona.es", R.mipmap.fc_b_logo );
    static private Equipo eq_tres = new Equipo("Granada CF", "www.granadacf.es", R.mipmap.gr_cf_logo);
    static private Equipo eq_cuatro = new Equipo("Malaga CF", "www.malagacf.com", R.mipmap.mal_cf_logo);
    static private Equipo eq_cinco = new Equipo("Valencia CF", "www.valenciacf.com", R.mipmap.val_cf_logo);
    static private Equipo eq_seis = new Equipo("RC Deportivo", "www.canaldeportivo.com", R.mipmap.rcd_logo);
    static private Equipo eq_siete = new Equipo("Elche CF", "www.elchecf.es", R.mipmap.elche_logo);
    static private Equipo eq_ocho = new Equipo("Levante UD", "es.levanteud.com", R.mipmap.lev_ud_logo);
    static private Equipo eq_nueve = new Equipo("Sevilla FC", "www.sevillafc.es", R.mipmap.sev_fc_logo);
    static private Equipo eq_diez = new Equipo("UD Almería", "www.udalmeriasad.com", R.mipmap.ud_alm_logo);


    static private Partido partido_uno = new Partido(eq_tres,eq_cuatro,"20:00","En abierto");
    static private Partido partido_dos = new Partido(eq_cinco,eq_seis, "21:00","De pago");
    static private Partido partido_tres = new Partido(eq_dos,eq_siete, "20:30", "De pago");
    static private Partido partido_cuatro = new Partido(eq_uno,eq_ocho, "15:45", "En abierto");
    static private Partido partido_cinco = new Partido(eq_nueve,eq_diez, "18:00", "En abierto");

    static{
        partidos.add(partido_uno);
        partidos.add(partido_dos);
        partidos.add(partido_tres);
        partidos.add(partido_cuatro);
        partidos.add(partido_cinco);
    }


    public static Partido getPartido(Integer item)
    {
        if(item < partidos.size())
            return (Partido) partidos.get(item);
        else
            return null;
    }
}

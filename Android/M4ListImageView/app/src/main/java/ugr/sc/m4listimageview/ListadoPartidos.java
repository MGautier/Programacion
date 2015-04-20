package ugr.sc.m4listimageview;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by MGautier on 20/04/15.
 */
public class ListadoPartidos {

    public ArrayList<Partido> partidos = new ArrayList<Partido>();

    private Equipo eq_uno = new Equipo("Real Madrid CF", "www.realmadrid.com", "rm_cf_logo");
    private Equipo eq_dos = new Equipo("FC Barcelona", "www.fcbarcelona.es", "fc_b_logo" );
    private Equipo eq_tres = new Equipo("Granada CF", "www.granadacf.es", "gr_cf_logo");
    private Equipo eq_cuatro = new Equipo("Malaga CF", "www.malagacf.com", "mal_cf_logo");
    private Equipo eq_cinco = new Equipo("Valencia CF", "www.valenciacf.com", "val_cf_logo");
    private Equipo eq_seis = new Equipo("RC Deportivo", "www.canaldeportivo.com", "rcd_logo");
    private Equipo eq_siete = new Equipo("Elche CF", "www.elchecf.es", "elche_logo");
    private Equipo eq_ocho = new Equipo("Levante UD", "es.levanteud.com", "lev_ud_logo");
    private Equipo eq_nueve = new Equipo("Sevilla FC", "www.sevillafc.es", "sev_fc_logo");
    private Equipo eq_diez = new Equipo("UD Almería", "www.udalmeriasad.com", "ud_alm_logo");


    private Partido partido_uno = new Partido(eq_tres,eq_cuatro,"20:00","En abierto");
    private Partido partido_dos = new Partido(eq_cinco,eq_seis, "21:00","De pago");
    private Partido partido_tres = new Partido(eq_dos,eq_siete, "20:30", "De pago");
    private Partido partido_cuatro = new Partido(eq_uno,eq_ocho, "15:45", "En abierto");
    private Partido partido_cinco = new Partido(eq_nueve,eq_diez, "18:00", "En abierto");

    partidos.add(partido_uno);
    partidos.add(partido_dos);
    partidos.add(partido_tres);
    partidos.add(partido_cuatro);
    partidos.add(partido_cinco);

}

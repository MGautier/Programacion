package ugr.sc.m4listimageview;


import android.app.Activity;
import android.graphics.drawable.Drawable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class ImageListAdapter<T> extends ArrayAdapter {


    private final Activity context; //Obtenemos el context del Activity
    private final ListadoPartidos listadoPartidos; //Instancio la clase ListadoPartidos


    /**
     * Constructor de la clase
     * @param context Context del Activity principal
     * @param object Clase ListadoPartidos que contiene los partidos de la jornada
     */

    public ImageListAdapter(Activity context, List<T> object)
    {
        super(context, R.layout.listimageview, object);

        this.context = context;
        this.listadoPartidos = (ListadoPartidos) object;

    }


    /**
     * Método consultor
     * @param position Índice de la posicion de la ListView en el Activity
     * @param view Objeto de la clase View
     * @param parent Objeto de la clase ViewGroup
     * @return Devuelve la vista para el Activity
     */

    public View getView(int position, View view, ViewGroup parent)
    {
        LayoutInflater inflater = context.getLayoutInflater();
        View rowView = inflater.inflate(R.layout.listimageview, null, true);

        ImageView escudo_local = (ImageView) rowView.findViewById(R.id.local);
        TextView equipo_local = (TextView) rowView.findViewById(R.id.equipo_local);
        TextView hora = (TextView) rowView.findViewById(R.id.hora_partido);

        TextView equipo_visitante = (TextView) rowView.findViewById(R.id.equipo_visitante);
        TextView television = (TextView) rowView.findViewById(R.id.tipo_visualizacion);
        ImageView escudo_visitante = (ImageView) rowView.findViewById(R.id.visitante);

        //Iterator<Partido> iterator = listadoPartidos.partidos.iterator();
        Partido jugando = listadoPartidos.getPartido(position);

        if(jugando != null)
        {
            escudo_local.setImageDrawable(Drawable.createFromPath(jugando.getEquipoLocal().getEscudo() + ".png"));
            equipo_local.setText(jugando.getEquipoLocal().getEquipo());
            hora.setText(jugando.getHora());

            equipo_visitante.setText(jugando.getEquipoVisitante().getEquipo());
            television.setText(jugando.getTelevision());
            escudo_visitante.setImageDrawable(Drawable.createFromPath(jugando.getEquipoVisitante().getEscudo() + ".png"));
        }

        //listadoPartidos.getPartido(position);
        /*while (iterator.hasNext())
        {
            escudo_local.setImageDrawable(Drawable.createFromPath(iterator.next().getEquipoLocal().getEscudo() + ".png"));
            equipo_local.setText(iterator.next().getEquipoLocal().getEquipo());
            hora.setText(iterator.next().getHora());

            equipo_visitante.setText(iterator.next().getEquipoVisitante().getEquipo());
            television.setText(iterator.next().getTelevision());
            escudo_visitante.setImageDrawable(Drawable.createFromPath(iterator.next().getEquipoVisitante().getEscudo() + ".png"));
        }*/

        return rowView;
    };
}

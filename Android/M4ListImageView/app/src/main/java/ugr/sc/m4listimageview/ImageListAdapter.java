package ugr.sc.m4listimageview;


import android.app.Activity;
import android.graphics.drawable.Drawable;
import android.os.Build;
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



    /**
     * Constructor de la clase
     * @param context Context del Activity principal
     * @param object Clase ListadoPartidos que contiene los partidos de la jornada
     */

    public ImageListAdapter(Activity context, List<T> object)
    {
        super(context, R.layout.listimageview, object);

        this.context = context;
        ListadoPartidos.partidos = object;

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


        Partido jugando = ListadoPartidos.getPartido(position);

        if(jugando != null)
        {
            if(Build.VERSION.SDK_INT < 22)
            {
                escudo_local.setImageDrawable(context.getResources().getDrawable(jugando.getEquipoLocal().getEscudo()));
            }
            else
            {
                escudo_local.setImageDrawable(context.getDrawable(jugando.getEquipoLocal().getEscudo()));
            }


            equipo_local.setText(jugando.getEquipoLocal().getEquipo());
            hora.setText(jugando.getHora());

            equipo_visitante.setText(jugando.getEquipoVisitante().getEquipo());
            television.setText(jugando.getTelevision());

            if(Build.VERSION.SDK_INT < 22)
            {
                escudo_visitante.setImageDrawable(context.getResources().getDrawable(jugando.getEquipoVisitante().getEscudo()));
            }
            else
            {
                escudo_visitante.setImageDrawable(context.getDrawable(jugando.getEquipoVisitante().getEscudo()));
            }


        }



        return rowView;
    };
}

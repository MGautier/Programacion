package ugr.sc.m4listimageview;


import android.app.Activity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

public class ImageListAdapter extends ArrayAdapter<String> {

    private final Activity context;
    private final String[] items;
    private final Integer[] imagenes;

    public ImageListAdapter(Activity context, String[] items, Integer[] imagenes)
    {
        super(context, R.layout.listimageview, items);

        this.context = context;
        this.items = items;
        this.imagenes = imagenes;
    }

    public View getView(int position, View view, ViewGroup parent)
    {
        LayoutInflater inflater = context.getLayoutInflater();
        View rowView = inflater.inflate(R.layout.listimageview, null, true);

        TextView titulo = (TextView) rowView.findViewById(R.id.item_uno);
        ImageView imagen = (ImageView) rowView.findViewById(R.id.image_icon);
        TextView extra = (TextView) rowView.findViewById(R.id.item_dos);

        titulo.setText(items[position]);
        imagen.setImageResource(imagenes[position]);
        extra.setText("Descripción" + items[position]);

        return rowView;
    };
}

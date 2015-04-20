package ugr.sc.m4listimageview;

import android.app.Activity;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.Toast;


public class MainActivity extends ActionBarActivity {

    ListView list;
    String[] nombres = {
            "Safari",
            "Camera",
            "Global",
            "Firefox",
            "UC Browser",
            "Android folder",
            "VLC Player",
            "Cold War"
    };

    Integer[] imagenes = {
            R.mipmap.pic1,
            R.mipmap.pic2,
            R.mipmap.pic3,
            R.mipmap.pic4,
            R.mipmap.pic5,
            R.mipmap.pic6,
            R.mipmap.pic7,
            R.mipmap.pic8,
    };


    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ImageListAdapter adapter = new ImageListAdapter(this,nombres,imagenes);
        list = (ListView) findViewById(R.id.lista);
        list.setAdapter(adapter);

        list.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                String Item_selected = nombres[+position];
                Toast.makeText(getApplicationContext(), Item_selected, Toast.LENGTH_SHORT).show();
            }
        });
    }
}

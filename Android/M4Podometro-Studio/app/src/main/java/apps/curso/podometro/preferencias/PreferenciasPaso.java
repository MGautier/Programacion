

package apps.curso.podometro.preferencias;

import android.content.Context;
import android.util.AttributeSet;
import apps.curso.podometro.R;

public class PreferenciasPaso extends PreferenciasMedidas {

	public PreferenciasPaso(Context context) {
		super(context);
	}
	public PreferenciasPaso(Context context, AttributeSet attr) {
		super(context, attr);
	}
	public PreferenciasPaso(Context context, AttributeSet attr, int defStyle) {
		super(context, attr, defStyle);
	}

	protected void initPreferenceDetails() {
		mTitleResource = R.string.titulo_longitud_paso;
		mMetricUnitsResource = R.string.centimetros;
	}
}


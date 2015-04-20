package ugr.sc.m4listimageview;

/**
 * Created by MGautier on 20/04/15.
 */
public class Partido {

    private Equipo local; // Equipo local
    private Equipo visitante; // Equipo visitante
    private String hora; // Hora del encuentro
    private String television; // Si el partido es en abierto o de pago (televisión por cable)

    /**
     * Constructor de la clase
     * @param local Equipo local en el partido
     * @param visitante Equipo visitante en el partido
     * @param hora Hora del partido
     * @param television Si el partido es en abierto o de pago
     */

    public Partido (Equipo local, Equipo visitante, String hora, String television)
    {
        this.local = local;
        this.visitante = visitante;
        this.hora = hora;
        this.television = television;
    }

    /**
     * Método consultor
     * @return Devuelve el equipo local del partido
     */

    public Equipo getEquipoLocal()
    {
        return local;
    }

    /**
     * Método modificador
     * @param local Equipo local del partido a modificar
     */

    public void setEquipoLocal(Equipo local)
    {
        if(!this.local.equals(local))
            this.local = local;
    }

    /**
     * Método consultor
     * @return Devuelve el equipo visitante del partido
     */

    public Equipo getEquipoVisitante()
    {
        return visitante;
    }

    /**
     * Método modificador
     * @param visitante Equipo visitante del partido a modificar
     */

    public void setEquipoVisitante(Equipo visitante)
    {
        if(!this.visitante.equals(visitante))
            this.visitante = visitante;
    }

    /**
     * Método consultor
     * @return Devuelve la hora del partido
     */

    public String getHora()
    {
        return hora;
    }

    /**
     * Método modificador
     * @param hora Introduce la nueva hora del partido de fútbol
     */

    public void setHora(String hora)
    {
        if(!this.hora.equals(hora))
            this.hora = hora;
    }

    /**
     * Método consultor
     * @return Devuelve si el partido es en abierto o de pago
     */

    public String getTelevision()
    {
        return television;
    }

    /**
     * Método modificador
     * @param television Introduce si el partido es en abierto o de pago
     */

    public void setTelevision(String television)
    {
        if(!this.television.equals(television))
            this.television = television;
    }

}

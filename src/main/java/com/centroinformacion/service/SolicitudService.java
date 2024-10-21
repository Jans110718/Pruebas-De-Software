package com.centroinformacion.service;

import java.util.Date;
import java.util.List;

import com.centroinformacion.entity.Solicitud; // Asegúrate de que la entidad Solicitud esté importada

public interface SolicitudService {
    public abstract Solicitud registraSolicitud(Solicitud obj); // Cambiado a Solicitud
    public abstract List<Solicitud> listaConsultaEspacio(int idEspacio, Date fecDesde, Date fecHasta);

}

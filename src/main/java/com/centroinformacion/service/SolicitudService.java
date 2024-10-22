package com.centroinformacion.service;

import java.util.Date;
import java.util.List;

import com.centroinformacion.entity.Solicitud; // Aseg&ntilde;;rate de que la entidad Solicitud est&ntilde;; importada

public interface SolicitudService {
    public abstract Solicitud registraSolicitud(Solicitud obj); // Cambiado a Solicitud
    public abstract List<Solicitud> listaConsultaEspacio(int idEspacio,int tipoVehiculo, Date fecDesde, Date fecHasta);

}

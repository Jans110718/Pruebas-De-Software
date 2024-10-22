package com.centroinformacion.service;

import java.util.Date;
import java.util.List;

import com.centroinformacion.entity.Solicitud; // Aseg&uacute;rate de que la entidad Solicitud est&eacute; importada

public interface SolicitudService {
    public abstract Solicitud registraSolicitud(Solicitud obj); // Cambiado a Solicitud
    public abstract List<Solicitud> listaConsultaEspacio(int idEspacio,int tipoVehiculo, Date fecDesde, Date fecHasta);

}

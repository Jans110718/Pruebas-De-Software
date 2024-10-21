package com.centroinformacion.service;

import java.util.Date;
import java.util.List;

import com.centroinformacion.entity.SolicitudIngreso; // Asegúrate de que la entidad Solicitud esté importada

public interface SolicitudService {
    public abstract SolicitudIngreso registraSolicitud(SolicitudIngreso obj); // Cambiado a Solicitud
    public abstract List<SolicitudIngreso> listaConsultaEspacio(int idEspacio, Date fecDesde, Date fecHasta);

}

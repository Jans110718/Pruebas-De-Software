package com.centroinformacion.service;

import com.centroinformacion.entity.SolicitudIngreso; // Asegúrate de que la entidad Solicitud esté importada

public interface SolicitudService {
    public abstract SolicitudIngreso registraSolicitud(SolicitudIngreso obj); // Cambiado a Solicitud
}

package com.centroinformacion.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.centroinformacion.entity.SolicitudIngreso; // Asegúrate de que la entidad Solicitud esté importada
import com.centroinformacion.repository.SolicitudIngresoRepository; // Cambia esto al repositorio adecuado

@Service
public class SolicitudServiceImp implements SolicitudService {

    @Autowired
    private SolicitudIngresoRepository repository; // Cambiado a SolicitudRepository

    @Override
    public SolicitudIngreso registraSolicitud(SolicitudIngreso obj) {
        return repository.save(obj); // Cambiado a guardar Solicitud
    }
}

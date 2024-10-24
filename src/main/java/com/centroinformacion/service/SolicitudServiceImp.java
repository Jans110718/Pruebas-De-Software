package com.centroinformacion.service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.centroinformacion.entity.Solicitud; // Aseg&uacute;rate de que la entidad Solicitud est&eacute; importada
import com.centroinformacion.repository.SolicitudIngresoRepository; // Cambia esto al repositorio adecuado

@Service
public class SolicitudServiceImp implements SolicitudService {

    @Autowired
    private SolicitudIngresoRepository repository; // Cambiado a SolicitudRepository

    @Override
    public Solicitud insertaActualizaSolicitud(Solicitud obj) {
        return repository.save(obj); // Cambiado a guardar Solicitud
    }

	@Override
	public List<Solicitud> listaConsultaEspacio(int idEspacio,int tipoVehiculo, Date fecDesde, Date fecHasta) {
		return repository.listaConsultaSolicitudAvanzado(idEspacio, tipoVehiculo, fecDesde, fecHasta);
	}
	@Override
	public Optional<Solicitud> buscaSolicitud(int idSolicitud) {
		return repository.findById(idSolicitud);
	}

}

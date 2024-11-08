package com.centroinformacion.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.centroinformacion.entity.Incidencia;
import com.centroinformacion.repository.IncidenciaRepository;
@Service

public class IncidenciaServiceImpl implements IncidenciaService {
	@Autowired
	    private IncidenciaRepository repository;
	@Override
	public Incidencia insertaActualizaIncidencia(Incidencia obj) {
		// TODO Auto-generated method stub
		return repository.save(obj);
	}

}

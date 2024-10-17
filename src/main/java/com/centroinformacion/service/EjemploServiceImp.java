 package com.centroinformacion.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.centroinformacion.entity.Ejemplo;
import com.centroinformacion.repository.EjemploRepository;

@Service
public class EjemploServiceImp implements EjemploService {

	@Autowired	
	private EjemploRepository repository;

	@Override
	public Ejemplo insertaActualizaEjemplo(Ejemplo obj) {
		return repository.save(obj);
	}

	
}

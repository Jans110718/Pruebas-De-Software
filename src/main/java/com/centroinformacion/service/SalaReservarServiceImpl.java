package com.centroinformacion.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.centroinformacion.entity.ReservaSala;
import com.centroinformacion.repository.SalaReservaRepository;

@Service
public class SalaReservarServiceImpl implements SalaReservarService{

	@Autowired
	private SalaReservaRepository repository;
	
	@Override
	public ReservaSala registraSalaReservado(ReservaSala obj) {
		return repository.save(obj);
	}
}

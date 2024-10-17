package com.centroinformacion.service;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.centroinformacion.entity.Editorial;
import com.centroinformacion.repository.EditorialRepository;

@Service
public class EditorialServiceImp implements EditorialService {

	@Autowired
	private EditorialRepository repository;
	
	@Override
	public Editorial insertaEditorial(Editorial obj) {
		return repository.save(obj);
	}

	
	
	@Override
	public List<Editorial> listaPorRuc(String ruc){
		return repository.findByRuc(ruc);
	}
	
	
	@Override
	public List<Editorial> listaPorRazonSocialLike(String filtro) {
		return repository.listaPorRazonSocialLike(filtro);
	}

	@Override
	public Optional<Editorial> buscaEditorial(int idEditorial) {
		return repository.findById(idEditorial);

	}

	
	
	
	@Override
	public List<Editorial> listaPorRucIgual(String ruc, int idEditorial) {
		return repository.listaEditorialRucIgualActualiza(ruc, idEditorial);

	}



	@Override
	public List<Editorial> listaConsultaEditorial(int estado, int idPais, String razonSocial, String direccion,
	String ruc, Date fecDesde, Date fecHasta) {
		
	return repository.listaConsultaEditorial(estado, idPais, razonSocial, direccion, ruc, fecDesde, fecHasta);	
	}
	}

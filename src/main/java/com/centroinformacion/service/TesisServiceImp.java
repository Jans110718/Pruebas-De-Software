package com.centroinformacion.service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.centroinformacion.entity.Tesis;
import com.centroinformacion.repository.TesisRepository;

@Service
public class TesisServiceImp implements TesisService{
	@Autowired	
	private TesisRepository repository;

	@Override
	public Tesis insertaActualizaTesis(Tesis obj) {
		return repository.save(obj);
	}
	
	@Override
	public Tesis actualizaTesis(Tesis obj) {
		return repository.save(obj);
	}
	
	@Override
	public List<Tesis> listaPorTituloOrTema(String titulo, String tema) {
		return repository.findByTituloOrTemaIgnoreCase(titulo, tema);
	}

	@Override
	public List<Tesis> listaPorTituloLike(String filtro) {
		return repository.listaPorTituloLike(filtro);
	}

	@Override
	public Optional<Tesis> buscaTesis(int idTesis) {
		return repository.findById(idTesis);
	}

	@Override
	public List<Tesis> listaPorTituloIgualRegistra(String titulo) {
		return repository.listaPorTituloIgualRegistra(titulo);
	}

	@Override
	public List<Tesis> listaPorTituloIgualActualiza(String titulo, int idTesis) {
		return repository.listaPorTituloIgualActualiza(titulo,idTesis);
	}

	@Override
	public List<Tesis> listaConsultaTesis(int estado, int idAlumno, String titulo, String tema, Date fecDesde,
			Date fecHasta) {
		return repository.listaConsultaTesis(estado, idAlumno, titulo,tema,  fecDesde, fecHasta);

	}



}

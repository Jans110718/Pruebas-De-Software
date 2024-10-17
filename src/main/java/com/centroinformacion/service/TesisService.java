package com.centroinformacion.service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import com.centroinformacion.entity.Tesis;

public interface TesisService {

	public abstract Tesis insertaActualizaTesis(Tesis obj);
	public abstract List<Tesis> listaPorTituloOrTema(String titulo, String tema);
	public abstract Tesis actualizaTesis(Tesis obj);
	public abstract List<Tesis>listaPorTituloLike(String filtro);
	public abstract Optional<Tesis> buscaTesis(int idTesis);
	
	
	
	public List<Tesis> listaPorTituloIgualRegistra(String titulo);
	public List<Tesis> listaPorTituloIgualActualiza(String titulo, int idTesis);
	
	//consultas
	public abstract List<Tesis> listaConsultaTesis(int estado, int idAlumno,  String titulo, String tema, Date fecDesde, Date fecHasta);
	

}

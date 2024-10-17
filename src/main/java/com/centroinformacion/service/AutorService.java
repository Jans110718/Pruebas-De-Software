package com.centroinformacion.service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import com.centroinformacion.entity.Autor;

public interface AutorService {

     /*CRUD*/
	public abstract Autor insertaActualizaAutor(Autor obj);
	public abstract List<Autor> listaPorTelefono(String telefono);

	public abstract List<Autor> listaPorNombresOrApellidos(String nombres, String apellidos);

	public abstract List<Autor>listaPorNombresApellidosLike(String filtro);
	/*Encapsula un objeto, java util*/
	public abstract Optional<Autor>buscaAutor(int idAutor);
	
	//Validaciones
	public abstract List<Autor> listaPorNombreApellidoIgual(String nombres, String apellidos); 
	public abstract List<Autor> listaPorNombreApellidoIgualActualiza(String nombres, String apellidos, int idAutor);
	public abstract List<Autor> listaPorTelefonoIgual(String telefono, int idAutor); 

	//Consulta
	public abstract List<Autor> listaConsultaAutor(int estado, int idPais ,int idGrado,  String nomApe, Date fecDesde, Date fecHasta);
	
	
	
	//SIFUENTES
	public abstract List<Autor> listaAutor();

}


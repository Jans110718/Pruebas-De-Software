package com.centroinformacion.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Pageable;

import com.centroinformacion.entity.Autor;
import com.centroinformacion.entity.Libro;
import com.centroinformacion.entity.LibroHasAutor;
import com.centroinformacion.entity.LibroHasAutorPK;


public interface LibroService {
	
	
	public abstract Libro insertaActualizaLibro(Libro obj);
	public abstract List<Libro> listaPorSerie(String serie);
	public abstract List<Libro> listaPorTitulo(String titulo);
	public abstract Optional<Libro> buscaTitulo(int titulo);
	public abstract List<Libro> listaPorTituloOrSerie(String titulo, String serie);
	public abstract List<Libro> listaPorTituloLike(String filtro);
	public abstract Libro actualizarLibro(Libro obj); 
	
	public abstract List<Libro> listaPorTituloActualizar(String titulo,int idLibro);
	public abstract List<Libro> listaPorSerieActualizar(String serie, int idLibro);
 	
	public abstract List<Libro> listaConsultaLibro(
			int estado, 
			int idCategoriaLibro, 
			int idTipoLibro, 
			String titulo, 
			String serie,
			int anio);
	
	
	/*Transaccion*/
	//consultas
	
	public abstract List<Libro> listaLibroDisponible(String filtro, Pageable pageable);

	



	public abstract List<Libro> listaLibro(String filtro, Pageable pageable);
	//SIFUENTES
	public abstract List<Autor> traerAutorDeLibro(int idLibro);
	public abstract List<Libro> listaLibro();
	public abstract LibroHasAutor insertaAutor(LibroHasAutor obj);
	public abstract void eliminaAutor(LibroHasAutor obj);
	public abstract Optional<LibroHasAutor> buscaAutor(LibroHasAutorPK obj);
	public abstract List<Libro> listaLibroNoDisponible(String string, Pageable pageable);
}

	
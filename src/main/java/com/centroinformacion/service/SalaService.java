package com.centroinformacion.service;

import java.util.List;
import java.util.Optional;

import com.centroinformacion.entity.Sala;

public interface SalaService {
	public abstract List<Sala> listaTodos();
	public abstract Sala insertaActualizaSala(Sala obj);
	public abstract List<Sala> listaPorNumero(String numero);
	public abstract Optional<Sala> buscaSala(int idSala);
	public abstract List<Sala> listaPorNumeros(String numero);
	public abstract List<Sala> listaPorNumeroLike(String filtro);
	public abstract List<Sala> listaPorNumeroIgualRegistra(String numero);
	public abstract List<Sala> listaPorNumeroIgualActualiza(String numero, int id);
	public abstract List<Sala> listaConsultaSala(int estado, String numero, int piso, int numAlumnos, String recursos,
			int idSede, int idTipoSala);
	

	public abstract List<Sala> listaSalaDisponibles();
	public Sala actualizarSala(Sala sala);


}

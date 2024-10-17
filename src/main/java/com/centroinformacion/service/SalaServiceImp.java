


package com.centroinformacion.service;

import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.centroinformacion.entity.Sala;
import com.centroinformacion.repository.SalaRepository;

@Service
public class SalaServiceImp implements SalaService {
	@Autowired
	private SalaRepository repository;

	@Override
	public List<Sala> listaTodos() {
		return repository.findByOrderByNumeroAsc();
	}

	@Override
	public Sala insertaActualizaSala(Sala obj) {
		return repository.save(obj);
	}

	@Override
	public List<Sala> listaPorNumero(String numero) {
		return repository.findByNumero(numero);
	}

	@Override
	public Optional<Sala> buscaSala(int idSala) {
		return repository.findById(idSala);
	}

	@Override
	public List<Sala> listaPorNumeroIgualRegistra(String numero) {
		return repository.listaPorNumeroIgualRegistra(numero);
	}

	@Override
	public List<Sala> listaPorNumeroIgualActualiza(String numero, int id) {
		return repository.listaPorNumeroIgualActualiza(numero, id);

	}

	@Override

	public List<Sala> listaPorNumeros(String numero) {

		return repository.findByNumeroIgnoreCase(numero);

	}

	@Override

	public List<Sala> listaPorNumeroLike(String filtro) {

// TODO Auto-generated method stub 

		return repository.listaPorNumeroLike(filtro);

	}

	@Override

	public List<Sala> listaConsultaSala(int estado,

			String numero,

			int piso,

			int numAlumnos,

			String recursos,

			int idSede,

			int idTipoSala) {

		return repository.listaConsultaSala(estado, numero, piso, numAlumnos, recursos, idSede, idTipoSala);

	}

	@Override
	public List<Sala> listaSalaDisponibles() {
		return repository.listaSalaDisponibles();
	}

	@Override
	public Sala actualizarSala(Sala sala) {
		return repository.save(sala);
	}

}


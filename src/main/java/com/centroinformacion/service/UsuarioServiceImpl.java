package com.centroinformacion.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.centroinformacion.entity.Opcion;
import com.centroinformacion.entity.Rol;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.entity.UsuarioHasRol;
import com.centroinformacion.entity.UsuarioHasRolPK;
import com.centroinformacion.repository.UsuarioHasRolRepository;
import com.centroinformacion.repository.UsuarioRepository;


@Service
public class UsuarioServiceImpl implements UsuarioService{

	@Autowired
	private UsuarioRepository repository;
	
	@Autowired
	private UsuarioHasRolRepository usuarioHasRolRepository;
	
	@Override
	public Usuario login(Usuario bean) {
		return repository.login(bean);
	}

	@Override
	public List<Opcion> traerEnlacesDeUsuario(int idUsuario) {
		return repository.traerEnlacesDeUsuario(idUsuario);
	}

	@Override
	public List<Rol> traerRolesDeUsuario(int idUsuario) {
		return repository.traerRolesDeUsuario(idUsuario);
	}

	@Override
	public Usuario buscaPorLogin(String login) {
		return repository.findByLogin(login);
	}

	@Override
	public List<Usuario> listaUsuario() {
		return repository.findAll();
	}

	@Override
	public UsuarioHasRol insertaRol(UsuarioHasRol obj) {
		return usuarioHasRolRepository.save(obj);
	}

	@Override
	public void eliminaRol(UsuarioHasRol obj) {
		usuarioHasRolRepository.delete(obj);
	}

	@Override
	public Optional<UsuarioHasRol> buscaRol(UsuarioHasRolPK obj) {
		return usuarioHasRolRepository.findById(obj);
	}

}

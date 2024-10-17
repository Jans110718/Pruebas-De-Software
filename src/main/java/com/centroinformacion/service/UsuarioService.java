package com.centroinformacion.service;

import java.util.List;
import java.util.Optional;

import com.centroinformacion.entity.Opcion;
import com.centroinformacion.entity.Rol;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.entity.UsuarioHasRol;
import com.centroinformacion.entity.UsuarioHasRolPK;

public interface UsuarioService {

	public abstract Usuario login(Usuario bean);
	public abstract List<Opcion> traerEnlacesDeUsuario(int idUsuario);
	public abstract List<Rol> traerRolesDeUsuario(int idUsuario);
	public abstract Usuario buscaPorLogin(String login);
	public abstract List<Usuario> listaUsuario();

	public abstract UsuarioHasRol insertaRol(UsuarioHasRol obj);
	public abstract void eliminaRol(UsuarioHasRol obj);
	public abstract Optional<UsuarioHasRol> buscaRol(UsuarioHasRolPK obj);
}

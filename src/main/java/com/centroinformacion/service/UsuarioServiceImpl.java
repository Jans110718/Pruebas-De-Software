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
import com.centroinformacion.util.PasswordUtil;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UsuarioServiceImpl implements UsuarioService{

	@Autowired
	private UsuarioRepository repository;
	
	@Autowired
	private UsuarioHasRolRepository usuarioHasRolRepository;
	  @Autowired
	    private PasswordEncoder passwordEncoder;
	 @Override
	    public Usuario login(Usuario bean) {
	        // Buscar el usuario por su login
	        Usuario usuario = repository.findByLogin(bean.getLogin());
	        
	        if (usuario != null && passwordEncoder.matches(bean.getPassword(), usuario.getPassword())) {
	            // Si la contraseña coincide con la de la base de datos, devolver el usuario
	            return usuario;
	        } else {
	            // Si las contraseñas no coinciden
	            return null;
	        }
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
	@Override
	public void encriptarContraseñas() {
	    List<Usuario> usuarios = repository.findAll();
	    System.out.println("Cantidad de usuarios a revisar: " + usuarios.size());

	    for (Usuario usuario : usuarios) {
	        String contraseñaActual = usuario.getPassword();
	        System.out.println("Contraseña original de usuario " + usuario.getLogin() + ": " + contraseñaActual);

	        // Encriptar solo contraseñas no encriptadas
	        if (!contraseñaActual.startsWith("$2a$")) { // Verifica si ya es BCrypt
	            String contraseñaEncriptada = PasswordUtil.encode(contraseñaActual);
	            usuario.setPassword(contraseñaEncriptada);
	            repository.save(usuario); // Actualiza el usuario en la BD
	            System.out.println("Contraseña encriptada para usuario " + usuario.getLogin() + ": " + contraseñaEncriptada);
	        }
	    }
	}


}

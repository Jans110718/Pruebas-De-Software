package com.centroinformacion.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.centroinformacion.entity.Opcion;
import com.centroinformacion.entity.Rol;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.UsuarioService;
import com.centroinformacion.util.PasswordUtil;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private UsuarioService servicio;

    @PostMapping("/login")
    public String login(Usuario user, HttpSession session, HttpServletRequest request) {
        // Recuperamos el usuario desde la base de datos
        Usuario usuario = servicio.login(user);
        // Verificamos si el estado del usuario es 0 (no permitido)
        if (usuario.getEstado() == 0) {
            // Si el estado del usuario es 0, mostramos el mensaje correspondiente
            request.setAttribute("mensaje", "El usuario no está activo en este ciclo. No puede iniciar sesión.");
            return "intranetLogin";
        }
        if (usuario == null || !PasswordUtil.matches(user.getPassword(), usuario.getPassword())) {
            // Si las contraseñas no coinciden, mostramos un mensaje de error
            request.setAttribute("mensaje", "Usuario o contraseña incorrectos");
            return "intranetLogin";
        } else {
            // Lógica para manejar el login exitoso
            List<Rol> roles = servicio.traerRolesDeUsuario(usuario.getIdUsuario());
            List<Opcion> menus = servicio.traerEnlacesDeUsuario(usuario.getIdUsuario());
            List<Opcion> menusTipo1 = menus.stream().filter(p -> p.getTipo() == 1).toList(); // Profesor
            List<Opcion> menusTipo2 = menus.stream().filter(p -> p.getTipo() == 2).toList(); // Alumno
            List<Opcion> menusTipo3 = menus.stream().filter(p -> p.getTipo() == 3).toList(); // Seguridad
            List<Opcion> menusTipo4 = menus.stream().filter(p -> p.getTipo() == 4).toList(); // Proveedores
            List<Opcion> menusTipo5 = menus.stream().filter(p -> p.getTipo() == 5).toList(); // Supervisores


            // Guardamos la información del usuario y los menús en la sesión
            session.setAttribute("idUsuario", usuario.getIdUsuario());
            session.setAttribute("objUsuario", usuario);
            session.setAttribute("objMenusTipo1", menusTipo1);
            session.setAttribute("objMenusTipo2", menusTipo2);
            session.setAttribute("objMenusTipo3", menusTipo3);
            session.setAttribute("objMenusTipo4", menusTipo4);
            session.setAttribute("objMenusTipo5", menusTipo5);
            session.setAttribute("objRoles", roles);

            return "intranetHome"; // Redirigimos a la página principal
        }
    }

    
    @GetMapping("/logout")
    public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        // Cerramos la sesión y enviamos un mensaje
        session.invalidate();
        response.setHeader("Cache-control", "no-cache");
        response.setHeader("Expires", "0");
        response.setHeader("Pragma", "no-cache");
        request.setAttribute("mensaje", "El usuario salió de sesión");
        return "intranetLogin";
    }
}

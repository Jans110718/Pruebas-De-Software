package com.centroinformacion.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.centroinformacion.entity.Solicitud;
import com.centroinformacion.entity.Espacio;
import com.centroinformacion.entity.Solicitud; // Aseg&uacute;rate de que tienes la entidad Solicitud
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.EspacioService;
import com.centroinformacion.service.SolicitudService; // Servicio para manejar solicitudes
import com.centroinformacion.util.AppSettings;

import jakarta.servlet.http.HttpSession;

@Controller
public class SolicitudRegistroController {

    @Autowired
    private SolicitudService solicitudService; // Cambia el nombre del servicio para gestionar solicitudes
    @Autowired
    private EspacioService espacioService;

    @PostMapping("/registraSolicitud")
    @ResponseBody
    public Map<String, Object> registraSolicitud(Solicitud obj, HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        
        // Obtener el usuario de la sesi&oacute;n
        Usuario objUsuario = (Usuario) session.getAttribute("objUsuario");
        if (objUsuario == null) {
            map.put("MENSAJE", "Usuario no autenticado");
            return map;
        }

        // Obtener el espacio por ID
        Espacio espacio = espacioService.obtenerEspacioPorId(obj.getEspacio().getIdEspacio()); // Usa el espacio directamente
        if (espacio == null) {
            map.put("MENSAJE", "Espacio no encontrado");
            return map;
        }

        // Cambiar estado_reserva a 1
        espacio.setEstado_reserva(1);
        espacioService.actualizarEspacio(espacio);

        // Configurar la solicitud
        obj.setEstado(AppSettings.ACTIVO);
        obj.setUsuarioRegistro(objUsuario);
        obj.setUsuarioActualiza(objUsuario);
        obj.setFechaRegistro(new Date());
        obj.setFechaActualizacion(new Date());
        obj.setEntrada(0);
        obj.setSalida(0);
        
        // Asignar el espacio a la solicitud
        obj.setEspacio(espacio); // Establecer el espacio en la solicitud
        // Registrar la solicitud
        Solicitud objSalida = solicitudService.insertaActualizaSolicitud(obj);
        if (objSalida == null) {
            map.put("MENSAJE", "Error en el registro de la solicitud");
            return map;
        } 

        map.put("MENSAJE", "Registro de solicitud exitoso");
        return map;
    }
    @PostMapping("/actualizaSolicitud")
    @ResponseBody
    public Map<?, ?> actualiza(Solicitud obj, HttpSession session) {        
        Usuario objUsuario = (Usuario) session.getAttribute("objUsuario");
      
		HashMap<String, Object> map = new HashMap<String, Object>();

        Optional<Solicitud> optSolicitud=solicitudService.buscaSolicitud(obj.getIdSolicitud());
        System.out.println("ID de Solicitud: " + obj.getIdSolicitud());


if (!optSolicitud.isPresent()) {
    map.put("MENSAJE", "Solicitud no encontrada");
    return map;
}
        // Obtener el espacio por ID
        
        Espacio espacio = espacioService.obtenerEspacioPorId(obj.getEspacio().getIdEspacio()); // Usa el espacio directamente
        if (espacio == null) {
            map.put("MENSAJE", "Espacio no encontrado");
            return map;
        }

        // Cambiar estado_reserva a 1
        espacio.setEstado_reserva(1);
        espacioService.actualizarEspacio(espacio);

        // Configurar la solicitud
        obj.setFechaRegistro(optSolicitud.get().getFechaRegistro());
		obj.setFechaActualizacion(new Date());
		obj.setEstado(optSolicitud.get().getEstado());
		obj.setUsuarioRegistro(optSolicitud.get().getUsuarioRegistro());
		obj.setUsuarioActualiza(objUsuario);
        obj.setEntrada(0);
        obj.setSalida(0);
        
        // Asignar el espacio a la solicitud
        obj.setEspacio(espacio); // Establecer el espacio en la solicitud
        // Registrar la solicitud
        Solicitud objSalida = solicitudService.insertaActualizaSolicitud(obj);
        if (objSalida == null) {
            map.put("MENSAJE", "Error en la actualizacion de la solicitud");
            return map;
        } 

        map.put("MENSAJE", "Actualizacion de solicitud exitoso");
        return map;
    }
   
}

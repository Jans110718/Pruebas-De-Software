package com.centroinformacion.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.centroinformacion.entity.Solicitud;
import com.centroinformacion.entity.Espacio;
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

        HashMap<String, Object> map = new HashMap<>();

        Optional<Solicitud> optSolicitud = solicitudService.buscaSolicitud(obj.getIdSolicitud());
        System.out.println("ID de Solicitud: " + obj.getIdSolicitud());

        if (!optSolicitud.isPresent()) {
            map.put("MENSAJE", "Solicitud no encontrada");
            return map;
        }

        // Obtener la solicitud existente
        Solicitud solicitudExistente = optSolicitud.get();

        // Obtener el espacio antiguo por ID
        Espacio espacioAntiguo = solicitudExistente.getEspacio();

        // Obtener el nuevo espacio por ID
        Espacio espacioNuevo = espacioService.obtenerEspacioPorId(obj.getEspacio().getIdEspacio());
        if (espacioNuevo == null) {
            map.put("MENSAJE", "Espacio nuevo no encontrado");
            return map;
        }

        // Cambiar estado_reserva del espacio antiguo a 0
        if (espacioAntiguo != null) {
            espacioAntiguo.setEstado_reserva(0);
            espacioService.actualizarEspacio(espacioAntiguo);
        }

        // Cambiar estado_reserva del nuevo espacio a 1
        espacioNuevo.setEstado_reserva(1);
        espacioService.actualizarEspacio(espacioNuevo);

        // Mantener los valores de entrada y salida actuales, para no sobrescribirlos accidentalmente
        obj.setEntrada(solicitudExistente.getEntrada());  // Conservar valor de entrada
        obj.setSalida(solicitudExistente.getSalida());    // Conservar valor de salida

        // Configurar la solicitud con los valores restantes
        obj.setFechaRegistro(solicitudExistente.getFechaRegistro());
        obj.setFechaActualizacion(new Date());
        obj.setEstado(solicitudExistente.getEstado());  // Mantener el estado actual si no se modifica
        obj.setUsuarioRegistro(solicitudExistente.getUsuarioRegistro());
        obj.setUsuarioActualiza(objUsuario);

        // Asignar el nuevo espacio a la solicitud
        obj.setEspacio(espacioNuevo);

        // Registrar la solicitud
        Solicitud objSalida = solicitudService.insertaActualizaSolicitud(obj);
        if (objSalida == null) {
            map.put("MENSAJE", "Error en la actualización de la solicitud");
            return map;
        }

        map.put("MENSAJE", "Actualización de solicitud exitosa");
        return map;
    }

    @ResponseBody
    @PostMapping("/registrarEntradaSalida")
    public Map<String, Object> registrarEntradaSalida(int idSolicitud, String accion) {
        HashMap<String, Object> map = new HashMap<>();

        // Buscar la solicitud por ID
        Solicitud objSolicitud = solicitudService.buscaSolicitud(idSolicitud).orElse(null);
        if (objSolicitud == null) {
            map.put("mensaje", "Solicitud no encontrada");
            return map;
        }

        // Registrar la entrada o salida según la acción
        if ("entrada".equalsIgnoreCase(accion)) {
        	 objSolicitud.setFechaHoraEntrada(new Date()); // Registrar la fecha y hora de entrada
             objSolicitud.setEntrada(1); // Cambiar el atributo entrada a 1
             map.put("mensaje", "Entrada registrada exitosamente");
        } else if ("salida".equalsIgnoreCase(accion)) {
            objSolicitud.setFechaHoraSalida(new Date());
            objSolicitud.setSalida(1);
            objSolicitud.setEstado(0);  // Cambiar el estado de la solicitud a 0
            // Cambiar el atributo salida a 1
// Registrar la fecha y hora de salida
            // Puedes actualizar otros campos si es necesario
            map.put("mensaje", "Salida registrada exitosamente");
        } else {
            map.put("mensaje", "Acción no válida");
            return map;
        }

        // Guardar los cambios en la solicitud
        solicitudService.insertaActualizaSolicitud(objSolicitud);

        return map;
    }


  
}

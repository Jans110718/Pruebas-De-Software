package com.centroinformacion.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;


import com.centroinformacion.entity.Vehiculo; // Aseg&uacute;rate de que esta entidad exista
import com.centroinformacion.repository.VehiculoRepository;
import com.centroinformacion.entity.Espacio; // Aseg&uacute;rate de que esta entidad exista



import com.centroinformacion.service.VehiculoService; // Aseg&uacute;rate de que este servicio exista
import com.centroinformacion.service.EspacioService; // Aseg&uacute;rate de que este servicio exista


@Controller
public class UtilController {

   

    @Autowired
    private VehiculoService vehiculoService; // Aseg&uacute;rate de que el servicio est&aacute; inyectado

    @Autowired
    private EspacioService espacioService; // Aseg&uacute;rate de que el servicio est&aacute; inyectado

    // M&eacute;todo para listar veh&iacuteculos
    @GetMapping("/listaVehiculo")
    @ResponseBody
    public List<Vehiculo> listaVehiculo() {
        return vehiculoService.listaTodos();// Aseg&uacute;rate de que este m&eacute;todo exista en tu servicio
    }

    // M&eacute;todo para listar espacios
    @GetMapping("/listaEspacio")
    @ResponseBody
    public List<Espacio> listaEspacio() {
        return espacioService.listaEspacioDisponibles(); // Aseg&uacute;rate de que este m&eacute;todo exista en tu servicio
    }
    @GetMapping("/listaEspacios")
    @ResponseBody
    public List<Espacio> listaEspacios() {
        return espacioService.listaTodos(); // Este m&eacute;todo debe devolver todos los espacios
    }
    @GetMapping("/listaVehiculosUsuario/{idUsuarioRegistro}")
    public ResponseEntity<List<Vehiculo>> listaVehiculosUsuario(@PathVariable Integer idUsuarioRegistro) {
        List<Vehiculo> vehiculos = vehiculoService.findByUsuarioRegistroId(idUsuarioRegistro);
        if (vehiculos.isEmpty()) {
            return ResponseEntity.noContent().build(); // Retorna 204 No Content si no hay veh&iacute;culos
        }
        return ResponseEntity.ok(vehiculos); // Retorna 200 OK con la lista de veh&iacute;culos
    }
}

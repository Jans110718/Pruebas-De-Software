package com.centroinformacion.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;


import com.centroinformacion.entity.Vehiculo; // Aseg&ntilde;;rate de que esta entidad exista
import com.centroinformacion.repository.VehiculoRepository;
import com.centroinformacion.entity.Espacio; // Aseg&ntilde;;rate de que esta entidad exista



import com.centroinformacion.service.VehiculoService; // Aseg&ntilde;;rate de que este servicio exista
import com.centroinformacion.service.EspacioService; // Aseg&ntilde;;rate de que este servicio exista


@Controller
public class UtilController {

   

    @Autowired
    private VehiculoService vehiculoService; // Aseg&ntilde;;rate de que el servicio est&ntilde;;; inyectado

    @Autowired
    private EspacioService espacioService; // Aseg&ntilde;;rate de que el servicio est&ntilde;;; inyectado

    // M&ntilde;;todo para listar veh&iacute;culos
    @GetMapping("/listaVehiculo")
    @ResponseBody
    public List<Vehiculo> listaVehiculo() {
        return vehiculoService.listaTodos();// Aseg&ntilde;;rate de que este m&ntilde;;todo exista en tu servicio
    }

    // M&ntilde;;todo para listar espacios
    @GetMapping("/listaEspacio")
    @ResponseBody
    public List<Espacio> listaEspacio() {
        return espacioService.listaEspacioDisponibles(); // Aseg&ntilde;;rate de que este m&ntilde;;todo exista en tu servicio
    }
    @GetMapping("/listaEspacios")
    @ResponseBody
    public List<Espacio> listaEspacios() {
        return espacioService.listaTodos(); // Este m&ntilde;;todo debe devolver todos los espacios
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

package com.centroinformacion.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import com.centroinformacion.entity.Vehiculo; // Asegúrate de que esta entidad exista
import com.centroinformacion.entity.Espacio; // Asegúrate de que esta entidad exista



import com.centroinformacion.service.VehiculoService; // Asegúrate de que este servicio exista
import com.centroinformacion.service.EspacioService; // Asegúrate de que este servicio exista


@Controller
public class UtilController {

   

    @Autowired
    private VehiculoService vehiculoService; // Asegúrate de que el servicio está inyectado

    @Autowired
    private EspacioService espacioService; // Asegúrate de que el servicio está inyectado

    
    // Método para listar veh&iacuteculos
    @GetMapping("/listaVehiculo")
    @ResponseBody
    public List<Vehiculo> listaVehiculo() {
        return vehiculoService.listaTodos();// Asegúrate de que este método exista en tu servicio
    }

    // Método para listar espacios
    @GetMapping("/listaEspacio")
    @ResponseBody
    public List<Espacio> listaEspacio() {
        return espacioService.listaEspacioDisponibles(); // Asegúrate de que este método exista en tu servicio
    }
    @GetMapping("/listaEspacios")
    @ResponseBody
    public List<Espacio> listaEspacios() {
        return espacioService.listaTodos(); // Este método debe devolver todos los espacios
    }
}

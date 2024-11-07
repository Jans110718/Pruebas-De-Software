package com.centroinformacion.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.centroinformacion.entity.Solicitud;
import com.centroinformacion.repository.SolicitudIngresoRepository;
@RestController
@RequestMapping("/api")
public class SolicitudController {
	
	  @Autowired
	    private SolicitudIngresoRepository solicitudIngresoRepository;

		@GetMapping("/solicitudes/porRol/{idRol}")
		public List<Solicitud> getSolicitudesPorRol(@PathVariable int idRol) {
		    return solicitudIngresoRepository.findSolicitudesPorRol(idRol);
		}
}

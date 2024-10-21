package com.centroinformacion.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.centroinformacion.entity.SolicitudIngreso;
import com.centroinformacion.service.SolicitudService;

@Controller

public class SolicitudMarcarController {
	@Autowired
    private SolicitudService solicitudService;
	@GetMapping("/consultaSolicitud")
	@ResponseBody
	public List<SolicitudIngreso> consulta(
	        int idEspacio, 
	        @DateTimeFormat(pattern = "yyyy-MM-dd") Date fecDesde,
	        @DateTimeFormat(pattern = "yyyy-MM-dd") Date fecHasta) {
	    
	    List<SolicitudIngreso> lstSalida = solicitudService.listaConsultaEspacio(idEspacio, fecDesde, fecHasta);
	    
	    return lstSalida;
	}

}

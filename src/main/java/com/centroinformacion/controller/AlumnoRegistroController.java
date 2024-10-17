package com.centroinformacion.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.centroinformacion.entity.Alumno;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.AlumnoService;
import com.centroinformacion.util.AppSettings;

import jakarta.servlet.http.HttpSession;

/**
 * @author PAUL PONCE
 */

@Controller
public class AlumnoRegistroController {

	@Autowired
	private AlumnoService alumnoService;
	
	@PostMapping("/registraAlumno")
	@ResponseBody
	public Map<?, ?> registra(Alumno obj, HttpSession session){
		Usuario objUsuario = (Usuario)session.getAttribute("objUsuario");
		obj.setFechaRegistro(new Date());
		obj.setFechaActualizacion(new Date());
		obj.setEstado(AppSettings.ACTIVO);
		obj.setUsuarioRegistro(objUsuario);
		obj.setUsuarioActualiza(objUsuario);
		
		HashMap<String, String> map = new HashMap<String, String>();
		Alumno objSalida = alumnoService.insertaActualizaAlumno(obj);
		if (objSalida == null) {
			map.put("MENSAJE", "Error en el registro");
		}else {
			map.put("MENSAJE", "Registro exitoso");
		}
		return map;
	}
	
	@GetMapping("/buscaPorDniAlumno" )
	@ResponseBody
	public String validaDni(String dni){
		List<Alumno> lstAlumno = alumnoService.listaPorDniIgual(dni);
		if (CollectionUtils.isEmpty(lstAlumno)) {
			return "{\"valid\" : true }";
		} else {
			return "{\"valid\" : false }";
		}
	}
}

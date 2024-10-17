package com.centroinformacion.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.centroinformacion.entity.Autor;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.AutorService;
import com.centroinformacion.util.AppSettings;

import jakarta.servlet.http.HttpSession;



@Controller
public class AutorRegistroController {
	@Autowired
	private AutorService autorService;

	@PostMapping("/registraAutor")
	@ResponseBody
	public Map<?, ?> registra(Autor obj, HttpSession session){
		Usuario objUsuario = (Usuario)session.getAttribute("objUsuario");
		obj.setFechaRegistro(new Date());
		obj.setFechaActualizacion(new Date());
		obj.setEstado(AppSettings.ACTIVO);
		obj.setUsuarioRegistro(objUsuario);
		obj.setUsuarioActualiza(objUsuario);
		
		HashMap<String, String> map = new HashMap<String, String>();
		Autor objSalida = autorService.insertaActualizaAutor(obj);
		if (objSalida == null) {
			map.put("MENSAJE", "Error en el registro");
		}else {
			map.put("MENSAJE", "Registro exitoso");
		}
		return map;
	}

	
	
	
	
@GetMapping("/buscaPorTelefono")
	@ResponseBody
	public String validaTelefono(String telefono) {
		List<Autor> lstAutor = autorService.listaPorTelefono(telefono);
		if (CollectionUtils.isEmpty(lstAutor)) {
			return "{\"valid\" : true }";
		} else {
			return "{\"valid\" : false }";
		}
	}
	
}
	

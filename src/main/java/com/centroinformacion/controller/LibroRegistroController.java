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

import com.centroinformacion.entity.Libro;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.LibroService;
import com.centroinformacion.util.AppSettings;

import jakarta.servlet.http.HttpSession;

@Controller
public class LibroRegistroController {
	
	
	@Autowired
	private LibroService libroService;
	
	@PostMapping("/registraLibro")
	@ResponseBody
	public Map<?, ?> registra(Libro obj, HttpSession session){
		Usuario objUsuario = (Usuario)session.getAttribute("objUsuario");
		obj.setFechaRegistro(new Date());
		obj.setFechaActualizacion(new Date());
		obj.setEstado(AppSettings.ACTIVO);
		obj.setUsuarioRegistro(objUsuario);
		obj.setUsuarioActualiza(objUsuario);
		
		HashMap<String, String> map = new HashMap<String, String>();
		Libro objSalida = libroService.insertaActualizaLibro(obj);
		if (objSalida == null) {
			map.put("MENSAJE", "Error en el registro");
		}else {
			map.put("MENSAJE", "Registro exitoso");
		}
		return map;
	}
	
	@GetMapping("/buscaPorTituloCrudLibro" )
	@ResponseBody
	public String validaTitulo(String titulo){
		List<Libro> lstLibro = libroService.listaPorTitulo(titulo);
		if (CollectionUtils.isEmpty(lstLibro)) {
			return "{\"valid\" : true }";
		} else {
			return "{\"valid\" : false }";
		}
	}
	
	@GetMapping("/buscaPorTituloCrudLibroAct" )
	@ResponseBody
	public String validaLibroActualiza(String titulo, String id) {
		
		List<Libro> lstSalida = libroService.listaPorTituloActualizar(
				titulo,
				Integer.parseInt(id));
		
		if(lstSalida.isEmpty()) {
			return "{\"valid\":true}";
		}else {
			return "{\"valid\":false}";
		}
	}
	
	@GetMapping("/buscaPorSerieCrudLibroAct" )
	@ResponseBody
	public String validaSerieActualiza(String serie, String id) {
		
		List<Libro> lstSalida = libroService.listaPorSerieActualizar(
				serie,
				Integer.parseInt(id));
		
		if(lstSalida.isEmpty()) {
			return "{\"valid\":true}";
		}else {
			return "{\"valid\":false}";
		}
	}
	
	@GetMapping("/buscaPorSerieCrudLibro" )
	@ResponseBody
	public String validaSerie(String serie){
		List<Libro> lstLibro = libroService.listaPorSerie(serie);
		if (CollectionUtils.isEmpty(lstLibro)) {
			return "{\"valid\" : true }";
		} else {
			return "{\"valid\" : false }";
		}
	}
}

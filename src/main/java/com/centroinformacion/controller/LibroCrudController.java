package com.centroinformacion.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.centroinformacion.entity.DataCatalogo;
import com.centroinformacion.entity.Libro;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.LibroService;

import jakarta.servlet.http.HttpSession;

@Controller
public class LibroCrudController {
	
	@Autowired
	private LibroService libroService;
	
	@ResponseBody
	@GetMapping("/consultaCrudLibro")
	public List<Libro> consulta(String filtro){
		List<Libro> lstSalida = libroService.listaPorTituloLike("%"+filtro+"%");
		return lstSalida;
	}
	
	@PostMapping("/registraCrudLibro")
	@ResponseBody
	public Map<?, ?> registra(Libro obj, HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		Usuario objUsuario = (Usuario)session.getAttribute("objUsuario");
		obj.setEstado(1);
		
		obj.setFechaRegistro(new Date());
		obj.setFechaActualizacion(new Date());
		obj.setUsuarioRegistro(objUsuario);
		obj.setUsuarioActualiza(objUsuario);
		
		DataCatalogo objData = new DataCatalogo();
		objData.setIdDataCatalogo(27);
		obj.setEstadoPrestamo(objData);
		
		List<Libro> lstSalida = libroService.
				listaPorTituloOrSerie(
					obj.getTitulo(), 
					obj.getSerie());
		if (!CollectionUtils.isEmpty(lstSalida)) {
			map.put("mensaje", "El Titulo " + obj.getTitulo() + " de serie: " + obj.getSerie() + " ya existe");
			return map;
		}
		
		Libro objSalida = libroService.insertaActualizaLibro(obj);
		if (objSalida == null) {
			map.put("mensaje", "Error en el registro");
		} else {
			List<Libro> lista = libroService.listaPorTituloLike("%");
			map.put("lista", lista);
			map.put("mensaje", "Registro exitoso");
		}
		return map;
	}
	
	@PostMapping("/actualizaCrudLibro")
	@ResponseBody
		public Map<?, ?> actualiza(Libro obj, HttpSession session) { 

			 Usuario objUsuario = (Usuario)session.getAttribute("objUsuario"); 
			HashMap<String, Object> map = new HashMap<String, Object>(); 

			  
			Optional<Libro> optLibro = libroService.buscaTitulo(obj.getIdLibro()); 
			obj.setUsuarioRegistro(objUsuario); 
			obj.setUsuarioActualiza(objUsuario); 
			 

			obj.setFechaRegistro(optLibro.get().getFechaRegistro()); 
			obj.setEstado(optLibro.get().getEstado()); 
			obj.setFechaActualizacion(new Date()); 
			
			DataCatalogo objData = new DataCatalogo();
			objData.setIdDataCatalogo(27);
			obj.setEstadoPrestamo(objData);

			Libro objSalida = libroService.actualizarLibro(obj); 
			if (objSalida == null) { 
				map.put("mensaje", "Error en actualizar"); 
			} else { 
				map.put("mensaje", "Actualización exitosa"); 
				List<Libro> lista = libroService.listaPorTituloLike("%"); 
				map.put("listaA", lista); 

			} 
			return map; 
		} 
	
	@ResponseBody
	@PostMapping("/eliminaCrudLibro")
	public Map<?, ?> elimina(Libro obj, HttpSession session, int id) { 

		Usuario objUsuario = (Usuario)session.getAttribute("objUsuario"); 
		HashMap<String, Object> map = new HashMap<String, Object>(); 

		Libro objlibro = libroService.buscaTitulo(id).get(); 
		objlibro.setFechaActualizacion(new Date());  
		objlibro.setEstado( objlibro.getEstado() == 1 ? 0 : 1); 

		obj.setUsuarioRegistro(objUsuario); 
		obj.setUsuarioActualiza(objUsuario); 
		obj.setFechaActualizacion(new Date()); 
		 
		Libro objSalida = libroService.actualizarLibro(objlibro); 
		if (objSalida == null) { 

			map.put("mensaje", "Error en actualizar"); 
		} else { 

			List<Libro> lista = libroService.listaPorTituloLike("%"); 
			map.put("lista", lista); 
		} 
		return map; 

	} 
	
	@GetMapping("/buscarLibroPorTituloActualiza")
	@ResponseBody
	public String validaTituloActualiza(String titulo) {
		List<Libro> lst = libroService.listaPorTitulo(titulo);
		if(CollectionUtils.isEmpty(lst)) {
			return "{\"valid\":true}";
		}else {
			return "{\"valid\":false}";
		}
	}
	
	
	
	
}

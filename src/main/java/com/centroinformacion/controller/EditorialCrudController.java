package com.centroinformacion.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.centroinformacion.entity.Editorial;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.EditorialService;
import com.centroinformacion.util.AppSettings;

import jakarta.servlet.http.HttpSession;

@Controller
public class EditorialCrudController {

	@Autowired
	private EditorialService editorialService;
	
	//CONSULTAR CRUD EDITORIAL
	@ResponseBody
	@GetMapping("/consultaCrudEditorial")
	public List<Editorial> consulta(String filtro){
		List<Editorial> lstSalida = editorialService.listaPorRazonSocialLike("%"+filtro+"%");
		return lstSalida;
	}
	
	//REGISTRAR CRUD EDITORIAL	
		@PostMapping("/registraCrudEditorial")
		@ResponseBody

		public Map<?, ?> registra(Editorial obj, HttpSession session){
			HashMap<String, Object> map = new HashMap<String, Object>();

			Usuario objUsuario = (Usuario)session.getAttribute("objUsuario");
			obj.setFechaRegistro(new Date());
			obj.setFechaActualizacion(new Date());
			obj.setEstado(AppSettings.ACTIVO);
			obj.setUsuarioRegistro(objUsuario);
			obj.setUsuarioActualiza(objUsuario);
			
			Editorial objSalida = editorialService.insertaEditorial(obj);
		  if (objSalida == null) {
		        map.put("mensaje", "Error en el registro");
		    } else {
		        List<Editorial> lista = editorialService.listaPorRazonSocialLike("%");
		        map.put("lista", lista);
		        map.put("mensaje", "Registro exitoso");
		    }
		
		    return map;
		}
			
		
		//ACTUALIZAR CRUD EDITORIAL	
		@PostMapping("/actualizaCrudEditorial")
		@ResponseBody
		public Map<?, ?> actualiza(Editorial obj, HttpSession session) {
		    HashMap<String, Object> map = new HashMap<String, Object>();
		    
			Optional<Editorial> optEditorial = editorialService.buscaEditorial(obj.getIdEditorial());
			Usuario objUsuario = (Usuario) session.getAttribute("objUsuario");
			obj.setUsuarioRegistro(objUsuario);
			obj.setUsuarioActualiza(objUsuario);
			obj.setFechaRegistro(optEditorial.get().getFechaRegistro());
			obj.setEstado(optEditorial.get().getEstado());
			obj.setFechaActualizacion(new Date());

			

			Editorial objSalida = editorialService.insertaEditorial(obj);
			if (objSalida == null) {
				map.put("mensaje", "Error en actualizar");
			} else {
				List<Editorial> lista = editorialService.listaPorRazonSocialLike("%");
				map.put("lista", lista);
				map.put("mensaje", "Actualización exitosa");
			}
			return map;
		}
		
		
		//ELIMINAR CRU EDITORIAL
		@PostMapping("/eliminaCrudEditorial")
		@ResponseBody

		public Map<?, ?> elimina(int id) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			Editorial objEditorial= editorialService.buscaEditorial(id).get();
			objEditorial.setFechaActualizacion(new Date());  
			objEditorial.setEstado( objEditorial.getEstado() == 1 ? 0 : 1);
			Editorial objSalida = editorialService.insertaEditorial(objEditorial);
			if (objSalida == null) {
				map.put("mensaje", "Error en actualizar");
			} else {
				List<Editorial> lista = editorialService.listaPorRazonSocialLike("%");
				map.put("lista", lista);
				
			}
			return map;
		}
		
		@GetMapping("/buscaEditorialRucActualiza")
		@ResponseBody
		public String validaEditorialRuc(String ruc, String id) {
			
			List<Editorial> lstEditorial = editorialService.listaPorRucIgual(
					ruc, 
					Integer.parseInt(id));
			
			if(lstEditorial.isEmpty()) {
				return "{\"valid\":true}";
			}else {
				return "{\"valid\":false}";
			}
		}
		
	}


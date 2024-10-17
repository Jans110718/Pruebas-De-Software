package com.centroinformacion.controller;
/**
 * @author Astrid Yovera
 */

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

import com.centroinformacion.entity.Tesis;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.TesisService;
import com.centroinformacion.util.AppSettings;

import jakarta.servlet.http.HttpSession;

@Controller
public class TesisCrudController {

	@Autowired
	private TesisService tesisService;

	@ResponseBody
	@GetMapping("/consultaCrudTesis")
	public List<Tesis> consulta(String filtro) {
		List<Tesis> lstSalida = tesisService.listaPorTituloLike("%" + filtro + "%");
		return lstSalida;
	}

	/* REGISTRAR TESIS */
	@PostMapping("/registraCrudTesis")
	@ResponseBody
	public Map<?, ?> registra(Tesis obj, HttpSession session) {
		Usuario objUsuario = (Usuario) session.getAttribute("objUsuario");
		obj.setFechaRegistro(new Date());
		obj.setEstado(AppSettings.ACTIVO);
		obj.setUsuarioRegistro(objUsuario);
		obj.setUsuarioActualiza(objUsuario);

		HashMap<String, Object> map = new HashMap<String, Object>();
		obj.setFechaRegistro(new Date());
		obj.setFechaActualizacion(new Date());


		Tesis objSalida = tesisService.insertaActualizaTesis(obj);
		if (objSalida == null) {
			map.put("mensaje", "Error en el registro");
		} else {
			List<Tesis> lista = tesisService.listaPorTituloLike("%");
			map.put("lista", lista);
			map.put("mensaje", "Registro exitoso");
		}
		return map;
	}

	/* ACTUALIZAR TESIS */
	@PostMapping("/actualizaCrudTesis")
	@ResponseBody
	public Map<?, ?> actualiza(Tesis obj, HttpSession session) {
		Usuario objUsuario = (Usuario) session.getAttribute("objUsuario");
		
		HashMap<String, Object> map = new HashMap<String, Object>();

		Optional<Tesis> optTesis = tesisService.buscaTesis(obj.getIdTesis());
		obj.setFechaRegistro(optTesis.get().getFechaRegistro());
		obj.setUsuarioRegistro(optTesis.get().getUsuarioRegistro());
		obj.setEstado(optTesis.get().getEstado());
		obj.setFechaActualizacion(new Date());
		obj.setUsuarioActualiza(objUsuario);

		
		Tesis objSalida = tesisService.actualizaTesis(obj);
		if (objSalida == null) {
			map.put("mensaje", "Error en actualizar");
		} else {
			List<Tesis> lista = tesisService.listaPorTituloLike("%");
			map.put("lista", lista);
			map.put("mensaje", "Actualización exitosa");
		}
		return map;
	}

	/*ELIMINAR TESIS*/
	@ResponseBody
	@PostMapping("/eliminaCrudTesis")
	public Map<?, ?> elimina(int id, HttpSession session) {
		Usuario objUsuario = (Usuario)session.getAttribute("objUsuario");
	
		HashMap<String, Object> map = new HashMap<String, Object>();
	    Optional<Tesis> optTesis = tesisService.buscaTesis(id);
	    if (optTesis.isPresent()) {
	        Tesis objT = optTesis.get();
	        objT.setFechaActualizacion(new Date());
	        objT.setUsuarioActualiza(objUsuario);
	        objT.setEstado(objT.getEstado() == AppSettings.ACTIVO ? AppSettings.INACTIVO : AppSettings.ACTIVO);
	        Tesis objSalida = tesisService.actualizaTesis(objT);
	        if (objSalida == null) {
	            map.put("mensaje", "Error en actualizar");
	        } else {
	            List<Tesis> lista = tesisService.listaPorTituloLike("%");
	            map.put("lista", lista);
	        }
	    } else {
	        map.put("mensaje", "La Tesis con ID " + id + " no se encontró.");
	    }
	    return map;
	}

	@GetMapping("/buscarTesisPorTituloRegistra")
	@ResponseBody
	public String validaTituloOrTema(String titulo) {
		List<Tesis> lstTesis = tesisService.listaPorTituloIgualRegistra(titulo.trim());
		if (CollectionUtils.isEmpty(lstTesis)) {
			return "{\"valid\" : true }";
		} else {
			return "{\"valid\" : false }";
		}
	}
	
	@GetMapping("/buscarTesisPorTituloActualiza")
	@ResponseBody
	public String validaTituloActualiza(String titulo, int idTesis) {
		List<Tesis> lst = tesisService.listaPorTituloIgualActualiza(titulo.trim(), idTesis);
		if(CollectionUtils.isEmpty(lst)) {
			return "{\"valid\":true}";
		}else {
			return "{\"valid\":false}";
		}
	}
}

package com.centroinformacion.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

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
import com.centroinformacion.util.FunctionUtil;

import jakarta.servlet.http.HttpSession;

@Controller
public class AutorCrudController {

	@Autowired
	private AutorService autorService;

	@GetMapping("/consultaCrudAutor")
	@ResponseBody

	public List<Autor> consulta(String filtro) {
		List<Autor> listSalida = autorService.listaPorNombresApellidosLike("%" + filtro + "%");

		return listSalida;
	}

	@PostMapping("/registraCrudAutor")
	@ResponseBody

	public Map<?, ?> registraCrud(Autor obj, HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();

		Usuario objUsuario = (Usuario) session.getAttribute("objUsuario");
		obj.setFechaRegistro(new Date());
		obj.setFechaActualizacion(new Date());
		obj.setEstado(AppSettings.ACTIVO);
		obj.setUsuarioRegistro(objUsuario);
		obj.setUsuarioActualiza(objUsuario);

		List<Autor> lstSalida = autorService.listaPorNombreApellidoIgual(obj.getNombres(), obj.getApellidos());
		if (!CollectionUtils.isEmpty(lstSalida)) {
			map.put("mensaje", "El Autor " + obj.getNombres() + " " + obj.getApellidos() + " ya existe");
			return map;
		}

		Autor objSalida = autorService.insertaActualizaAutor(obj);

		if (objSalida == null) {
			map.put("mensaje", "Error en el registro");
		} else {
			map.put("mensaje", "Registro exitoso");
			List<Autor> lista = autorService.listaPorNombresApellidosLike("%");
			map.put("lista", lista);
		}

		return map;

	}

	@PostMapping("/actualizaCrudAutor")
	@ResponseBody

	public Map<?, ?> actualiza(Autor obj) {
		HashMap<String, Object> map = new HashMap<String, Object>();

		Optional<Autor> optAutor = autorService.buscaAutor(obj.getIdAutor());
		if (optAutor.isPresent()) {

			obj.setFechaRegistro(optAutor.get().getFechaRegistro());
			obj.setEstado(optAutor.get().getEstado());
			obj.setFechaActualizacion(new Date());
			obj.setUsuarioRegistro(optAutor.get().getUsuarioRegistro());
			obj.setUsuarioActualiza(optAutor.get().getUsuarioActualiza());

			Autor objSalida = autorService.insertaActualizaAutor(obj);
			if (objSalida == null) {
				map.put("mensaje", "Error en la actualización");
			} else {
				map.put("mensaje", "Actualización exitosa");
				List<Autor> lstSalida = autorService.listaPorNombresApellidosLike("%");
				map.put("lista", lstSalida);

			}
		}
		return map;
	}

	@PostMapping("/eliminaCrudAutor")
	@ResponseBody

	public Map<?, ?> elimina(int id) {
		HashMap<String, Object> map = new HashMap<String, Object>();

		Autor objAutor = autorService.buscaAutor(id).get();
		objAutor.setFechaActualizacion(new Date());
		/* 1= activo : 0=iNACTIVO */
		objAutor.setEstado(objAutor.getEstado() == 1 ? 0 : 1);
		Autor objSalida = autorService.insertaActualizaAutor(objAutor);
		if (objSalida == null) {
			map.put("mensaje", "Error en actualizar");
		} else {
			List<Autor> lista = autorService.listaPorNombresApellidosLike("%");
			map.put("lista", lista);
		}
		return map;
	}

	@GetMapping("/buscaAutorNombreApellidoRegistro")
	@ResponseBody
	public String validaAutorRegistra(String nombres, String apellidos) {
		List<Autor> lstSalida = autorService.listaPorNombreApellidoIgual(nombres, apellidos);
		if (lstSalida.isEmpty()) {
			return "{\"valid\":true}";
		} else {
			return "{\"valid\":false}";
		}
	}

	@GetMapping("/buscaAutorNombreApellidoActualiza")
	@ResponseBody
	public String validaAutorActualiza(String nombres, String apellidos, String id) {

		List<Autor> lstSalida = autorService.listaPorNombreApellidoIgualActualiza(nombres, apellidos,
				Integer.parseInt(id));

		if (lstSalida.isEmpty()) {
			return "{\"valid\":true}";
		} else {
			return "{\"valid\":false}";
		}
	}

	@GetMapping("/buscaAutorTelefonoIgualActualiza")
	@ResponseBody
	public String validaTelefonoActualiza(String telefono, String id) {

		List<Autor> lstSalida = autorService.listaPorTelefonoIgual(telefono, Integer.parseInt(id));

		if (lstSalida.isEmpty()) {
			return "{\"valid\":true}";
		} else {
			return "{\"valid\":false}";
		}
	}

	@GetMapping("/buscaAutorMayorEdad")
	@ResponseBody
	public String validaMayorEdad(String fechaNacimiento) {
		if (FunctionUtil.isMayorEdad(fechaNacimiento)) {
			return "{\"valid\":true}";
		} else {
			return "{\"valid\":false}";
		}
	}

}

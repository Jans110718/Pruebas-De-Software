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

import com.centroinformacion.entity.Alumno;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.AlumnoService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AlumnoCrudController {

	@Autowired
	private AlumnoService alumnoService;
	
	@ResponseBody
	@GetMapping("/consultaCrudAlumno")
	public List<Alumno> consulta(String filtro){
		List<Alumno> lstSalida = alumnoService.listaPorNombresApellidosLike("%"+filtro+"%");
		return lstSalida;
	}
	
	@PostMapping("/registraCrudAlumno")
	@ResponseBody
	public Map<?, ?> registra(Alumno obj, HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		Usuario objUsuario = (Usuario)session.getAttribute("objUsuario");
		obj.setEstado(1);
		obj.setFechaRegistro(new Date());
		obj.setFechaActualizacion(new Date());
		obj.setUsuarioRegistro(objUsuario);
		obj.setUsuarioActualiza(objUsuario);
		
		Alumno objSalida = alumnoService.insertaActualizaAlumno(obj);
		if (objSalida == null) {
			map.put("mensaje", "Error en el registro");
		} else {
			List<Alumno> lista = alumnoService.listaPorNombresApellidosLike("%");
			map.put("lista", lista);
			map.put("mensaje", "Registro exitoso");
		}
		return map;
	}
	
	@PostMapping("/actualizaCrudAlumno")
	@ResponseBody
	public Map<?, ?> actualiza(Alumno obj, HttpSession session) {
		Usuario objUsuario = (Usuario)session.getAttribute("objUsuario");
		HashMap<String, Object> map = new HashMap<String, Object>();
		Optional<Alumno> optAlumno= alumnoService.buscaAlumno(obj.getIdAlumno());
		obj.setFechaRegistro(optAlumno.get().getFechaRegistro());
		obj.setFechaActualizacion(new Date());
		obj.setEstado(optAlumno.get().getEstado());
		obj.setUsuarioRegistro(optAlumno.get().getUsuarioRegistro());
		obj.setUsuarioActualiza(objUsuario);
		
		Alumno objSalida = alumnoService.insertaActualizaAlumno(obj);
		if (objSalida == null) {
			map.put("mensaje", "Error en actualizar");
		} else {
			List<Alumno> lista = alumnoService.listaPorNombresApellidosLike("%");
			map.put("lista", lista);
			map.put("mensaje", "Actualización exitosa");
		}
		return map;
	}
	
	@ResponseBody
	@PostMapping("/eliminaCrudAlumno")
	public Map<?, ?> elimina(int id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		Alumno objAlumno= alumnoService.buscaAlumno(id).get();
		objAlumno.setEstado(objAlumno.getEstado() == 1 ? 0 : 1);
		Alumno objSalida = alumnoService.insertaActualizaAlumno(objAlumno);
		if (objSalida == null) {
			map.put("mensaje", "Error en actualizar");
		} else {
			List<Alumno> lista = alumnoService.listaPorNombresApellidosLike("%");
			map.put("lista", lista);
		}
		return map;
	}
	
	@GetMapping("/buscaAlumnoMayorEdad")
	@ResponseBody
	public String validaFecha(String fechaNacimiento) {
		if(com.centroinformacion.util.FunctionUtil.isMayorEdad(fechaNacimiento)) {
			return "{\"valid\":true}";
		}else {
			return "{\"valid\":false}";
		}
	}
	
	@GetMapping("/buscaAlumnoNombreApellidoRegistra")
	@ResponseBody
	public String validaAlumnoRegistra(String nombres, String apellidos) {
		List<Alumno> lstSalida = alumnoService.listaPorNombreApellidoIgualRegistra(
													nombres, apellidos);
		if(lstSalida.isEmpty()) {
			return "{\"valid\":true}";
		}else {
			return "{\"valid\":false}";
		}
	}
	
	@GetMapping("/buscaAlumnoNombreApellidoActualiza")
	@ResponseBody
	public String validaEmpleadoActualiza(String nombres, String apellidos, String id) {
		
		List<Alumno> lstSalida = alumnoService.listaPorNombreApellidoIgualActualiza(
				nombres, 
				apellidos,
				Integer.parseInt(id));
		if(lstSalida.isEmpty()) {
			return "{\"valid\":true}";
		}else {
			return "{\"valid\":false}";
		}
	}
	
	@GetMapping("/buscaAlumnoDNI")
	@ResponseBody
	public String validaAlumnoDNI(String dni) {
		List<Alumno> lstSalida = alumnoService.listaPorDniIgual(dni);
		if(lstSalida.isEmpty()) {
			return "{\"valid\":true}";
		}else {
			return "{\"valid\":false}";
		}
	}
	
	@GetMapping("/buscaAlumnoDniIgualActualiza")
	@ResponseBody
	public String validaDniActualiza(String dni, String id) {
		
		List<Alumno> lstSalida = alumnoService.listaPorDniIgualActualiza(
				dni, 
				Integer.parseInt(id));
		
		if(lstSalida.isEmpty()) {
			return "{\"valid\":true}";
		}else {
			return "{\"valid\":false}";
		}
	}
	
}

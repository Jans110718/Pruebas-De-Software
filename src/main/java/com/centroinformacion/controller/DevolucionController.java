package com.centroinformacion.controller;

import com.centroinformacion.entity.Alumno;
import com.centroinformacion.entity.Devolucion;
import com.centroinformacion.entity.DevolucionHasLibro;
import com.centroinformacion.entity.DevolucionHasLibroPK;
import com.centroinformacion.entity.Libro;
import com.centroinformacion.entity.Mensaje;
import com.centroinformacion.entity.SeleccionDevolucion;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.AlumnoService;
import com.centroinformacion.service.DevolucionService;
import com.centroinformacion.service.LibroService;
import com.centroinformacion.service.PrestamoService;

import jakarta.servlet.http.HttpSession;
import lombok.Getter;
import lombok.Setter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@Getter
@Setter
@Controller
public class DevolucionController {

	@Autowired
	private DevolucionService devolucionService;
	@Autowired
	private PrestamoService prestamoService;
	@Autowired
	private AlumnoService alumnoService;

	@Autowired
	private LibroService libroService;
	// Los productos seleccionados
	private List<SeleccionDevolucion> devoluciones = new ArrayList<SeleccionDevolucion>();

	@RequestMapping("/listaAlumnoDevolucion")
	@ResponseBody()
	public List<Alumno> listaAlumno(String filtro) {
		int page = 0;
		int size = 5;
		Pageable pageable = PageRequest.of(page, size);
		List<Alumno> lstSalida = alumnoService.listaAlumno("%" + filtro + "%", pageable);
		return lstSalida;
	}

	@RequestMapping("/listaLibroDevolucion")
	@ResponseBody()
	public List<Libro> listaLibro(String filtro) {
		int page = 0;
		int size = 5;
		Pageable pageable = PageRequest.of(page, size);
		List<Libro> lstSalida = libroService.listaLibroNoDisponible("%" + filtro + "%", pageable);
		return lstSalida;
	}

	@RequestMapping("/listaSeleccionDevolucion")
	@ResponseBody()
	public List<SeleccionDevolucion> lista() {
		return devoluciones;
	}

	@RequestMapping("/agregarSeleccionDevolucion")
	@ResponseBody()
	public List<SeleccionDevolucion> agregar(SeleccionDevolucion obj) {
		devoluciones.add(obj);
		return devoluciones;
	}

	@RequestMapping("/eliminaSeleccionDevolucion")
	@ResponseBody()
	public List<SeleccionDevolucion> eliminar(int idLibro) {
		devoluciones.removeIf(x -> x.getIdLibro() == idLibro);
		return devoluciones;

	}

	@RequestMapping("/registraDevolucion")
	@ResponseBody()
	public Mensaje Devolucion(Alumno alumno, HttpSession session,
			@DateTimeFormat(pattern = "yyyy-MM-dd") Date fechaDevolucion) {

		Usuario objUsuario = (Usuario) session.getAttribute("objUsuario");
		Mensaje objMensaje = new Mensaje();
		List<DevolucionHasLibro> detalles = new ArrayList<DevolucionHasLibro>();
		for (SeleccionDevolucion seleccionDevolucion : devoluciones) {

			DevolucionHasLibroPK pk = new DevolucionHasLibroPK();
			pk.setIdLibro(seleccionDevolucion.getIdLibro());

			DevolucionHasLibro phl = new DevolucionHasLibro();
			phl.setDevolucionHasLibroPK(pk);

			detalles.add(phl);
		}

		Devolucion obj = new Devolucion();
		obj.setFechaRegistro(new Date());
		obj.setFechaDevolucion(fechaDevolucion);
		obj.setFechaPrestamo(new Date());
		obj.setAlumno(alumno);
		obj.setUsuario(objUsuario);
		obj.setDetallesDevolucion(detalles);

		Devolucion objDevolucion = devolucionService.insertaDevolucion(obj);

		String salida = "-1";
		// Creas un SimpleDateFormat con el formato de fecha que deseas
		SimpleDateFormat sdf = new SimpleDateFormat("dd 'de' MMMM 'de' yyyy", new Locale("es", "ES"));
		String fechaFormateada = sdf.format(fechaDevolucion);

		if (objDevolucion != null) {

			salida = "Se generó el Devolucion con el código N° : " + objDevolucion.getIdDevolucion() + "<br><br>";
			salida += "Alumno: " + objDevolucion.getAlumno().getNombres() + "<br><br>";

			salida += "Fecha de devolución : " + fechaFormateada + "<br><br>";
			salida += "<table class=\"table\"><tr><td>Codigo</td><td>Titulo</td></tr>";
			for (SeleccionDevolucion x : devoluciones) {
				salida += "<tr><td>" + x.getIdLibro() + "</td><td>" + x.getTitulo();
			}
			salida += "</table>";
			salida += "</pre>";

			devoluciones.clear();
			objMensaje.setTexto(salida);
		}

		return objMensaje;
	}
}
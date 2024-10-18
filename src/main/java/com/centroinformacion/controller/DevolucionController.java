package com.centroinformacion.controller;

import com.centroinformacion.entity.Alumno;
import com.centroinformacion.entity.Devolucion;
import com.centroinformacion.entity.DevolucionHasLibro;
import com.centroinformacion.entity.DevolucionHasLibroPK;
import com.centroinformacion.entity.Libro;
import com.centroinformacion.entity.Mensaje;
import com.centroinformacion.entity.SeleccionDevolucion;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.entity.Vehiculo; // Asegúrate de importar la clase Vehiculo
import com.centroinformacion.entity.Espacio; // Asegúrate de importar la clase Espacio
import com.centroinformacion.service.AlumnoService;
import com.centroinformacion.service.DevolucionService;
import com.centroinformacion.service.LibroService;
import com.centroinformacion.service.PrestamoService;
import com.centroinformacion.service.VehiculoService; // Asegúrate de importar el servicio Vehiculo
import com.centroinformacion.service.EspacioService; // Asegúrate de importar el servicio Espacio

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

    @Autowired
    private VehiculoService vehiculoService; // Inyectar el servicio Vehiculo

    @Autowired
    private EspacioService espacioService; // Inyectar el servicio Espacio

    // Lista de devoluciones seleccionadas
    private List<SeleccionDevolucion> devoluciones = new ArrayList<>();

    // Método para listar alumnos según un filtro
    @RequestMapping("/listaAlumnoDevolucion")
    @ResponseBody()
    public List<Alumno> listaAlumno(String filtro) {
        int page = 0;
        int size = 5;
        Pageable pageable = PageRequest.of(page, size);
        return alumnoService.listaAlumno("%" + filtro + "%", pageable);
    }

    // Método para listar libros no disponibles según un filtro
    @RequestMapping("/listaLibroDevolucion")
    @ResponseBody()
    public List<Libro> listaLibro(String filtro) {
        int page = 0;
        int size = 5;
        Pageable pageable = PageRequest.of(page, size);
        return libroService.listaLibroNoDisponible("%" + filtro + "%", pageable);
    }

    // Método para listar vehículos según un filtro
    @RequestMapping("/listaVehiculoDevolucion")
    @ResponseBody()
    public List<Vehiculo> listaVehiculo(String filtro) {
        int page = 0;
        int size = 5;
        Pageable pageable = PageRequest.of(page, size);
        return vehiculoService.listaVehiculo(filtro, pageable);
    }

    // Método para listar espacios según un filtro (asumiendo que hay un método en el servicio)
    @RequestMapping("/listaEspacioDevolucion")
    @ResponseBody()
    public List<Espacio> listaEspacio(String filtro) {
        int page = 0;
        int size = 5;
        Pageable pageable = PageRequest.of(page, size);
        return espacioService.listaEspacioDisponibles(filtro, pageable);
        }

    // Método para listar devoluciones seleccionadas
    @RequestMapping("/listaSeleccionDevolucion")
    @ResponseBody()
    public List<SeleccionDevolucion> lista() {
        return devoluciones;
    }

    // Método para agregar un libro a la lista de devoluciones seleccionadas
    @RequestMapping("/agregarSeleccionDevolucion")
    @ResponseBody()
    public List<SeleccionDevolucion> agregar(SeleccionDevolucion obj) {
        devoluciones.add(obj);
        return devoluciones;
    }

    // Método para eliminar un libro de la lista de devoluciones seleccionadas
    @RequestMapping("/eliminaSeleccionDevolucion")
    @ResponseBody()
    public List<SeleccionDevolucion> eliminar(int idLibro) {
        devoluciones.removeIf(x -> x.getIdLibro() == idLibro);
        return devoluciones;
    }

    // Método para registrar la devolución de libros
    @RequestMapping("/registraDevolucion")
    @ResponseBody()
    public Mensaje Devolucion(Alumno alumno, HttpSession session,
            @DateTimeFormat(pattern = "yyyy-MM-dd") Date fechaDevolucion) {

        Usuario objUsuario = (Usuario) session.getAttribute("objUsuario");
        Mensaje objMensaje = new Mensaje();
        List<DevolucionHasLibro> detalles = new ArrayList<>();

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

        // Formatear la fecha de devolución
        SimpleDateFormat sdf = new SimpleDateFormat("dd 'de' MMMM 'de' yyyy", new Locale("es", "ES"));
        String fechaFormateada = sdf.format(fechaDevolucion);

        if (objDevolucion != null) {
            salida = "Se generó la devolución con el código N° : " + objDevolucion.getIdDevolucion() + "<br><br>";
            salida += "Alumno: " + objDevolucion.getAlumno().getNombres() + "<br><br>";
            salida += "Fecha de devolución : " + fechaFormateada + "<br><br>";
            salida += "<table class=\"table\"><tr><td>Codigo</td><td>Titulo</td></tr>";

            for (SeleccionDevolucion x : devoluciones) {
                salida += "<tr><td>" + x.getIdLibro() + "</td><td>" + x.getTitulo() + "</td></tr>";
            }
            salida += "</table>";
            devoluciones.clear();
            objMensaje.setTexto(salida);
        }

        return objMensaje;
    }
}

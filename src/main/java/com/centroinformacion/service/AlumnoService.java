package com.centroinformacion.service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Pageable;

import com.centroinformacion.entity.Alumno;

public interface AlumnoService {

	public abstract List<Alumno> listaTodos();
	
	public abstract Alumno insertaActualizaAlumno(Alumno obj);
	public abstract List<Alumno> listaPorDniIgual(String dni);
	public abstract Optional<Alumno> buscaAlumno(int idAlumno);
	public abstract List<Alumno> listaPorNombresOrApellidos(String nombres, String apellidos);
	public abstract List<Alumno> listaPorNombresApellidosLike(String filtro);

	//Validaciones
	public abstract List<Alumno> listaPorNombreApellidoIgualRegistra(String nombre, String apellido); 
	public abstract List<Alumno> listaPorNombreApellidoIgualActualiza(String nombre, String apellido, int idAlumno);
	public abstract List<Alumno> listaPorDniIgualActualiza(String dni, int idAlumno); 
	
	//consultas
	public abstract List<Alumno> listaConsultaAlumno(int estado, int idPais, int idDataCatalogo,  String nomApe, Date fecDesde, Date fecHasta, String correo, String dni, String telefono);


	//Para la consulta PC4


	public abstract List<Alumno> listaAlumno (String filtro, Pageable pageable);
	

}

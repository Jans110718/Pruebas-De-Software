package com.centroinformacion.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.centroinformacion.entity.Alumno;
import com.centroinformacion.entity.Autor;

@Repository

public interface AlumnoRepository extends JpaRepository<Alumno, Integer>{
	
	public abstract List<Alumno> findByOrderByApellidosAsc();
	
	@Query("select a from Alumno a where a.dni = ?1")
	public abstract List<Alumno> listaPorDniIgual(String dni);
	
	public List<Alumno> findByNombresOrApellidosIgnoreCase(String nombres, String apellidos);
	
	@Query("select a from Alumno a where a.nombres like ?1 or a.apellidos like ?1")
	public List<Alumno> listaPorNombresApellidosLike(String filtro);
	
	@Query("select a from Alumno a where a.nombres = ?1 and a.apellidos = ?2")
	public List<Alumno> listaAlumnoNombreApellidoIgualRegistra(String nombre, String apellido);
	
	@Query("select a from Alumno a where a.nombres = ?1 and a.apellidos = ?2 and a.idAlumno != ?3")
	public List<Alumno> listaAlumnoNombreApellidoIgualActualiza(String nombre, String apellido, int idAlumno);
	
	@Query("select a from Alumno a where a.dni = ?1 and a.idAlumno != ?2")
	public List<Alumno> listaAlumnoDniIgualActualiza(String dni, int idAlumno);
	
	//Consulta
	@Query("select a from Alumno a where "
			+ "( a.estado = ?1 ) and "
			+ "( ?2 = -1  or a.pais.idPais = ?2 ) and "
			+ "( ?3 = -1  or a.modalidad.idDataCatalogo = ?3 ) and "
			+ "( a.nombres like ?4 or a.apellidos like ?4 ) and "
			+ "( a.fechaNacimiento >= ?5 ) and "
			+ "( a.fechaNacimiento <= ?6 ) and "
			+ "( a.correo like ?7 ) and "
			+ "( a.dni like ?8 ) and "
			+ "( a.telefono like ?9 )") 
	public abstract List<Alumno> listaConsultaAlumno(int estado, int idPais, int idDataCatalogo, String nomApe, Date fecDesde, Date fecHasta, String correo, String dni, String telefono);
		

	/*Transacción*/
	
	
	/*@Query("select a from Alumno a where "
			+ "(a.nombres like ?1 or a.apellidos like ?1)")
public abstract List<Alumno> listaConsultarAlumno(String nombres,String apellidos);
*/


/*Para hacer la busca tanto por nbombre y apellido en la tabla modal al seleccionr boton buscar alumno*/

	

	@Query("select x from Alumno x where "
	        + "( x.nombres like %?1% or x.apellidos like %?1% )or (CONCAT (x.nombres, ' ', x.apellidos ) like %?1%)")
	public abstract List<Alumno> listaAlumno(String filtro, Pageable pageable);
}
	

	
	


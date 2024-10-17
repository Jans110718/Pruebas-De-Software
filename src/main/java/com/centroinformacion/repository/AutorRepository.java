package com.centroinformacion.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.centroinformacion.entity.Autor;

public interface AutorRepository  extends JpaRepository<Autor, Integer> {

	

	
	public List<Autor> findByTelefono(String telefono);

	public List<Autor> findByNombresOrApellidosIgnoreCase(String nombres, String apellidos);

     /*Crear Query  JSPQL*/
	@Query("Select a from Autor a where a.nombres like?1 or a.apellidos like?1")
	public List<Autor>listaPorNombresApellidosLike(String filtro);
	
	@Query("select a from Autor a where a.nombres = ?1 and a.apellidos = ?2")
	public List<Autor> listaAutorNombreApellidoIgual(String nombres, String apellidos);

	
	@Query("select a from Autor a where a.nombres = ?1 and a.apellidos = ?2 and a.idAutor != ?3")
	public List<Autor> listaAutorNombreApellidoIgualActualiza(String nombres, String apellidos, int idAutor);

	
	
	@Query("select a from Autor a where a.telefono = ?1 and a.idAutor != ?2")
	public List<Autor> listaAutorTelefonoIgualActualiza(String telefono, int idAutor);

	
	@Query("select a from Autor a where "
	        + "(a.estado = ?1)  and "
	        + "( ?2 = -1  or a.pais.idPais = ?2 ) and "
	        + "( ?3 = -1 or a.grado.idDataCatalogo = ?3 )  and "
	        + "( (a.nombres like ?4 or a.apellidos like ?4) or ( CONCAT( a.nombres, ' ', a.apellidos ) like %?4% ) ) and "
	        + "( a.fechaNacimiento >= ?5) and "
	        + "( a.fechaNacimiento <= ?6 ) ")
	public abstract List<Autor> listaConsultaAutor(int estado, int idPais, int idGrado, String nomApe, Date fecDesde, Date fecHasta);
}

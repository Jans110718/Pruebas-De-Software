package com.centroinformacion.repository;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.centroinformacion.entity.Autor;
import com.centroinformacion.entity.Libro;

/**
 * @author Yheremi Ramos
 */
public interface LibroRepository extends JpaRepository<Libro, Integer>  {

	public List<Libro> findBySerieIgnoreCase(String serie);
	
	public List<Libro> findByTituloOrSerieIgnoreCase(String titulo,String serie);
	
	public List<Libro> findByTitulo(String titulo);
	public List<Libro> findBySerie(String serie);
	
	@Query("select p from Libro p where p.titulo like ?1")
	public List<Libro> listPorTituloLike(String filtro);
	
	@Query("select a from Libro a where a.titulo = ?1 and a.idLibro != ?2")
	public List<Libro> listaPorTituloActualizar(String titulo,  int idLibro);

	
	
	@Query("select a from Libro a where a.serie = ?1 and a.idLibro != ?2")
	public List<Libro> listaPorSerieActualizar(String serie, int idLibro);

	
	//Consulta
	@Query("select p from Libro p where "
		    + "( p.estado = ?1)  and "
		    + "( ?2 = -1  or p.categoriaLibro.idDataCatalogo = ?2 ) and "
		    + "( ?3 = -1  or p.tipoLibro.idDataCatalogo = ?3 ) and "
		    + "( p.titulo like ?4 ) and"
		    + "( p.serie like ?5 )and"
		    + "( ?6 = -1 or p.anio = ?6 ) "
		)
	public abstract List<Libro> listaConsultaLibro(int estado, int idCategoria, int idTipo,  String titulo, String serie, int anio);

	




	@Query("select p from Libro p where p.titulo like ?1 and p.estadoPrestamo.idDataCatalogo = 27 ")
	public abstract List<Libro> listaLibroDisponible(String filtro, Pageable pageable);
	@Query("select p from Libro p where p.titulo like ?1 and p.estadoPrestamo.idDataCatalogo = 26 ")
	public abstract List<Libro> listaLibroNoDisponible(String filtro, Pageable pageable);


	/*@Query("select p from Libro p where "
		    + "( p.titulo like ?1 )"
		    )
	*/
	
	
	/*@Query("select p from Libro p where "
		
		    + "( p.titulo like ?1 ) and"
		    + "( p.idEstadoPrestamo = 27 )" )*/

	@Query("SELECT p FROM Libro p WHERE "
	        + "(LOWER(p.titulo) LIKE LOWER(CONCAT('%', ?1, '%'))) AND "
	        + "(p.estadoPrestamo.idDataCatalogo = 27)")
	public abstract List<Libro> listaLibro(String filtro, Pageable pageable);
	@Query("SELECT p FROM Libro p WHERE "
	        + "(LOWER(p.titulo) LIKE LOWER(CONCAT('%', ?1, '%'))) AND "
	        + "(p.estadoPrestamo.idDataCatalogo = 26)")
	public abstract List<Libro> listaLibros(String filtro, Pageable pageable);
	//Vargas
	
	 
	 //SIFUENTES
	 @Query("select a from Autor a , LibroHasAutor lihau where a.idAutor = lihau.autor.idAutor and lihau.libro.idLibro = ?1")
		public abstract List<Autor> traerAutorDeLibro(int idLibro);

}

	
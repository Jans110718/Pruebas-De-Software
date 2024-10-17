package com.centroinformacion.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.centroinformacion.entity.Tesis;

public interface TesisRepository extends JpaRepository<Tesis, Integer> {

	public List<Tesis> findByTituloOrTemaIgnoreCase(String titulo, String tema);

	@Query("select p from Tesis p where p.titulo like ?1")
	public List<Tesis> listaPorTituloLike(String filtro);

	@Query("select e from Tesis e where e.titulo = ?1 ")
	public List<Tesis> listaPorTituloIgualRegistra(String titulo);

	@Query("select x from Tesis x where x.titulo = ?1  and x.idTesis != ?2")
	public List<Tesis> listaPorTituloIgualActualiza(String titulo, int idTesis);
	
	
	//PARA CONSULTA
	@Query("select e from Tesis e where"
			+ "(e.estado = ?1) and"
			+ "(?2 = -1 or e.alumno.idAlumno = ?2) and"
			+ "(e.titulo like ?3) and"
			+ "(e.tema like ?4) and"
			+ "(e.fechaCreacion >= ?5) and"
			+ "(e.fechaCreacion <= ?6) ")
	public abstract List<Tesis> listaConsultaTesis(int estado, int idAlumno, String titulo, String tema, Date fecDesde, Date fecHasta);
}
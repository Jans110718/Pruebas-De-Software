package com.centroinformacion.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.centroinformacion.entity.Editorial;

public interface EditorialRepository extends JpaRepository<Editorial, Integer> {
	
	public List<Editorial> findByRuc(String ruc);
	
	
	
	
	@Query("select p from Editorial p where p.razonSocial like ?1")
	public List<Editorial> listaPorRazonSocialLike(String filtro);

	
	
	
	
	
	@Query("select e from Editorial e where e.ruc = ?1 and e.idEditorial != ?2")
	public List<Editorial> listaEditorialRucIgualActualiza(String ruc, int idEditorial);



	@Query("select e from Editorial e where "
			        + "(e.estado = ?1 ) and "
			        + "(?2 = -1 or e.pais.idPais = ?2 ) and "
			        + "(e.razonSocial like ?3 ) and "
			        + "(e.direccion like ?4 ) and "
			        + "(e.ruc like ?5 ) and "
			        + "(e.fechaCreacion >= ?6 ) and "
			        + "(e.fechaCreacion <= ?7 )")
	public abstract List<Editorial> listaConsultaEditorial(int estado, int idPais, String razonSocial, String direccion, 
	String ruc, Date fecDesde, Date fecHasta);


}

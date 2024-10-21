package com.centroinformacion.repository;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.centroinformacion.entity.SolicitudIngreso;


@Repository
public interface SolicitudIngresoRepository extends JpaRepository<SolicitudIngreso, Integer> {

	@Query("select s from SolicitudIngreso s where "
	        + "(?1 = -1 or s.espacio.idEspacio = ?1) and "
	        + "(s.fechaReserva >= ?2) and "
	        + "(s.fechaReserva <= ?3)")
	public abstract List<SolicitudIngreso> listaConsultaSolicitudAvanzado(int idEspacio, Date fecDesde, Date fecHasta);

}

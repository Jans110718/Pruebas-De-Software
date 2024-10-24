package com.centroinformacion.repository;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.centroinformacion.entity.Solicitud;


@Repository
public interface SolicitudIngresoRepository extends JpaRepository<Solicitud, Integer> {

	@Query("SELECT s FROM Solicitud s WHERE "
		     + "(?1 = -1 OR s.espacio.idEspacio = ?1) AND "
		     + "(?2 = -1 OR s.vehiculo.tipoVehiculo = ?2) AND "
		     + "(s.fechaReserva >= ?3) AND "
		     + "(s.fechaReserva <= ?4)")
		List<Solicitud> listaConsultaSolicitudAvanzado(int idEspacio, int tipoVehiculo, Date fecDesde, Date fecHasta);
    Optional<Solicitud> findById(Integer idSolicitud);

}

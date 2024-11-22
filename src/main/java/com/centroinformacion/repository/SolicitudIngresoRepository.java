package com.centroinformacion.repository;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.centroinformacion.entity.Solicitud;
import com.centroinformacion.entity.Usuario;


@Repository
public interface SolicitudIngresoRepository extends JpaRepository<Solicitud, Integer> {

	@Query("SELECT s FROM Solicitud s WHERE "
	         + "(?1 = -1 OR s.espacio.idEspacio = ?1) AND "
	         + "(?2 = -1 OR s.vehiculo.tipoVehiculo = ?2) AND "
	         + "(?3 = '' OR s.vehiculo.placa = ?3) AND "
	         + "(s.fechaReserva >= ?4) AND "
	         + "(s.fechaReserva <= ?5)"+"ORDER BY s.idSolicitud DESC")
	List<Solicitud> listaConsultaSolicitudAvanzado(int idEspacio, int tipoVehiculo, String placa, Date fecDesde, Date fecHasta);

	
	Optional<Solicitud> findById(Integer idSolicitud);
    
    boolean existsByUsuarioRegistroAndEstado(Usuario usuarioRegistro, int estado);
    // Método personalizado para obtener solicitudes de usuarios con rol 4
    @Query("SELECT s FROM Solicitud s " +
           "JOIN s.usuarioRegistro ur " +  // Asumiendo que tienes la relación con Usuario
           "JOIN ur.usuarioHasRol uhr " +  // Si tienes la relación con roles del usuario
           "WHERE uhr.rol.idRol = :idRol") // Filtramos por el idRol del rol
    List<Solicitud> findSolicitudesPorRol(@Param("idRol") int idRol);

}

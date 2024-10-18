package com.centroinformacion.repository;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.centroinformacion.entity.Espacio;
import java.util.List;

public interface EspacioRepository extends JpaRepository<Espacio, Integer> {
    
    // Consulta para buscar espacios disponibles según un filtro
	@Query("SELECT e FROM Espacio e WHERE e.numero LIKE %:filtro% OR CONCAT(e.pabellon, ' ', e.piso) LIKE %:filtro%")
	List<Espacio> findByFiltro(String filtro, Pageable pageable);
    
    // Obtener todos los espacios ordenados por número ascendente
    List<Espacio> findByOrderByNumeroAsc();

    // Buscar espacios por número
    List<Espacio> findByNumero(String numero);

    // Buscar espacios por número, ignorando mayúsculas y minúsculas
    List<Espacio> findByNumeroIgnoreCase(String numero);

    // Buscar espacios que contengan el número como parte del string
    @Query("SELECT e FROM Espacio e WHERE e.numero LIKE %?1%")
    List<Espacio> listaPorNumeroLike(String filtro);

    // Buscar espacios por número exacto
    @Query("SELECT e FROM Espacio e WHERE e.numero = ?1")
    List<Espacio> listaPorNumeroIgualRegistra(String numero);

    // Buscar espacios por número, excluyendo el espacio actual
    @Query("SELECT e FROM Espacio e WHERE e.numero = ?1 AND e.idEspacio != ?2")
    List<Espacio> listaPorNumeroIgualActualiza(String numero, int id);

    // Consultar espacios con filtros
    @Query("SELECT e FROM Espacio e WHERE " +
           "(e.estado_reserva = ?1) AND " +
           "(e.numero LIKE CONCAT('%', ?2, '%')) AND " +
           "(?3 IS NULL OR e.piso = ?3) AND " +
           "(?4 = -1 OR e.acceso = ?4)")
    List<Espacio> listaConsultaEspacio(int estado_reserva, String numero, String piso, int acceso);

    // Listar espacios disponibles (estado_reserva = 0)
    @Query("SELECT e FROM Espacio e WHERE e.estado_reserva = 0")
    List<Espacio> listaEspacioDisponibles();
}
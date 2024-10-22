package com.centroinformacion.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.centroinformacion.entity.Vehiculo;

@Repository
public interface VehiculoRepository extends JpaRepository<Vehiculo, Integer> {

    // Método para listar veh&iacuteculos ordenados por modelo
    public abstract List<Vehiculo> findByOrderByModeloAsc();
    @Query("SELECT v FROM Vehiculo v WHERE v.usuarioRegistro.idUsuario = ?1")
    List<Vehiculo> findByUsuarioRegistroId(int idUsuarioRegistro);
    // Método para buscar veh&iacuteculos por placa exacta
    @Query("select v from Vehiculo v where v.placa = ?1")
    public abstract List<Vehiculo> listaPorPlacaExacta(String placa);

    // Método para buscar por modelo o marca ignorando mayúsculas
    public List<Vehiculo> findByModeloOrMarcaIgnoreCase(String modelo, String marca);

    // Método para realizar búsquedas de modelo o marca que coincidan parcialmente
    @Query("select v from Vehiculo v where v.modelo like ?1 or v.marca like ?1")
    public List<Vehiculo> listaPorModeloMarcaLike(String filtro);

    // Validación para registro: Verifica si el nombre y la marca ya existen
    @Query("select v from Vehiculo v where v.modelo = ?1 and v.marca = ?2")
    public List<Vehiculo> listaVehiculoModeloMarcaExactosRegistra(String modelo, String marca);

    // Validación para actualización: Excluye el veh&iacuteculo actual por ID
    @Query("select v from Vehiculo v where v.modelo = ?1 and v.marca = ?2 and v.idVehiculo != ?3")
    public List<Vehiculo> listaVehiculoModeloMarcaExactosActualiza(String modelo, String marca, int idVehiculo);

    // Validación para placa exacta al actualizar un veh&iacuteculo
    @Query("select v from Vehiculo v where v.placa = ?1 and v.idVehiculo != ?2")
    public List<Vehiculo> listaVehiculoPlacaExactaActualiza(String placa, int idVehiculo);

    // Consulta avanzada con múltiples filtros para veh&iacuteculos
    @Query("select v from Vehiculo v where "
            + "( v.estado = ?1 ) and "
            + "( ?2 = -1 or v.usuarioRegistro.idUsuario = ?2 ) and "
            + "( v.modelo like ?3 or v.marca like ?3 ) and "
            + "( v.fechaRegistro >= ?4 ) and "
            + "( v.fechaRegistro <= ?5 ) and "
            + "( v.color like ?6 ) and "
            + "( v.placa like ?7 )")
    public abstract List<Vehiculo> listaConsultaVehiculo(int estado, int idUsuarioRegistro, String filtroModeloMarca, Date fechaDesde, Date fechaHasta, String color, String placa);

    // Consulta para búsqueda por modelo, marca o combinación de ambos
    @Query("select v from Vehiculo v where "
            + "( v.modelo like %?1% or v.marca like %?1% ) or "
            + "( CONCAT(v.modelo, ' ', v.marca) like %?1% )")
    public abstract List<Vehiculo> listaVehiculo(String filtro, Pageable pageable);
}

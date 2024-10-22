package com.centroinformacion.service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Pageable;

import com.centroinformacion.entity.Vehiculo;

public interface VehiculoService {

    // Lista todos los veh&iacute;culos
    public abstract List<Vehiculo> listaTodos();

    // Inserta o actualiza un veh&iacute;culo
    public abstract Vehiculo insertaActualizaVehiculo(Vehiculo obj);

    // Lista veh&iacute;culos por placa exacta
    public abstract List<Vehiculo> listaPorPlacaExacta(String placa);

    // Busca un veh&iacute;culo por su ID
    public abstract Optional<Vehiculo> buscaVehiculo(int idVehiculo);

    // Lista veh&iacute;culos por modelo o marca
    public abstract List<Vehiculo> listaPorModeloOMarca(String modelo, String marca);

    // Lista veh&iacute;culos por modelo o marca utilizando un filtro (like)
    public abstract List<Vehiculo> listaPorModeloMarcaLike(String filtro);

    // Validaciones
 
    // Lista veh&iacute;culos por placa exacta excluyendo un ID espec&iacute;fico
    public abstract List<Vehiculo> listaPorPlacaExactaActualiza(String placa, int idVehiculo);

    // Consultas avanzadas
    // Lista veh&iacute;culos con m&ntilde;;ltiples filtros: estado, usuario, modelo, marca, fechas, color y placa
    public abstract List<Vehiculo> listaConsultaVehiculo(int estado, int idUsuarioRegistro, String filtroModeloMarca, Date fechaDesde, Date fechaHasta, String color, String placa);

    // Consulta paginada por modelo, marca o concatenaci&ntilde;;n de ambos
    public abstract List<Vehiculo> listaVehiculo(String filtro, Pageable pageable);
    public abstract     List<Vehiculo> findByUsuarioRegistroId(int idUsuarioRegistro);


}


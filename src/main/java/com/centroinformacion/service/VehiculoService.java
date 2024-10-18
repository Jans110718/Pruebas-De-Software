package com.centroinformacion.service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Pageable;

import com.centroinformacion.entity.Vehiculo;

public interface VehiculoService {

    // Lista todos los vehículos
    public abstract List<Vehiculo> listaTodos();

    // Inserta o actualiza un vehículo
    public abstract Vehiculo insertaActualizaVehiculo(Vehiculo obj);

    // Lista vehículos por placa exacta
    public abstract List<Vehiculo> listaPorPlacaExacta(String placa);

    // Busca un vehículo por su ID
    public abstract Optional<Vehiculo> buscaVehiculo(int idVehiculo);

    // Lista vehículos por modelo o marca
    public abstract List<Vehiculo> listaPorModeloOMarca(String modelo, String marca);

    // Lista vehículos por modelo o marca utilizando un filtro (like)
    public abstract List<Vehiculo> listaPorModeloMarcaLike(String filtro);

    // Validaciones
 
    // Lista vehículos por placa exacta excluyendo un ID específico
    public abstract List<Vehiculo> listaPorPlacaExactaActualiza(String placa, int idVehiculo);

    // Consultas avanzadas
    // Lista vehículos con múltiples filtros: estado, usuario, modelo, marca, fechas, color y placa
    public abstract List<Vehiculo> listaConsultaVehiculo(int estado, int idUsuarioRegistro, String filtroModeloMarca, Date fechaDesde, Date fechaHasta, String color, String placa);

    // Consulta paginada por modelo, marca o concatenación de ambos
    public abstract List<Vehiculo> listaVehiculo(String filtro, Pageable pageable);
}
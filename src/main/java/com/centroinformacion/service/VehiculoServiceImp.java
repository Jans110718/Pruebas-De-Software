package com.centroinformacion.service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.centroinformacion.entity.Vehiculo;
import com.centroinformacion.repository.VehiculoRepository;

@Service
public class VehiculoServiceImp implements VehiculoService {

    @Autowired
    private VehiculoRepository repository;

    @Override
    public List<Vehiculo> listaTodos() {
        return repository.findByOrderByModeloAsc();
    }

    @Override
    public Vehiculo insertaActualizaVehiculo(Vehiculo obj) {
        return repository.save(obj);
    }

    @Override
    public List<Vehiculo> listaPorPlacaExacta(String placa) {
        return repository.listaPorPlacaExacta(placa);
    }

    @Override
    public Optional<Vehiculo> buscaVehiculo(int idVehiculo) {
        return repository.findById(idVehiculo);
    }

    @Override
    public List<Vehiculo> listaPorModeloOMarca(String modelo, String marca) {
        return repository.findByModeloOrMarcaIgnoreCase(modelo, marca);
    }

    @Override
    public List<Vehiculo> listaPorModeloMarcaLike(String filtro) {
        return repository.listaPorModeloMarcaLike(filtro);
    }

    @Override
    public List<Vehiculo> listaPorPlacaExactaActualiza(String placa, int idVehiculo) {
        return repository.listaVehiculoPlacaExactaActualiza(placa, idVehiculo);
    }

    @Override
    public List<Vehiculo> listaConsultaVehiculo(int estado, int idUsuarioRegistro, String filtroModeloMarca, Date fechaDesde,
            Date fechaHasta, String color, String placa) {
        return repository.listaConsultaVehiculo(estado, idUsuarioRegistro, filtroModeloMarca, fechaDesde, fechaHasta, color, placa);
    }

    @Override
    public List<Vehiculo> listaVehiculo(String filtro, Pageable pageable) {
        return repository.listaVehiculo(filtro, pageable);
    }
}

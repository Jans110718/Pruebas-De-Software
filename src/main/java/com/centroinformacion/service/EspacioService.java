package com.centroinformacion.service;

import org.springframework.data.domain.Pageable;
import java.util.List;
import java.util.Optional;

import com.centroinformacion.entity.Espacio;

public interface EspacioService {
	// M&ntilde;todo para listar espacios disponibles
    List<Espacio> listaEspacioDisponibles(String filtro, Pageable pageable);
    // Listar todos los espacios
    List<Espacio> listaTodos();
    
    

    // Insertar o actualizar un espacio
    Espacio insertaActualizaEspacio(Espacio obj);
    
    // Listar espacios por n&ntilde;mero exacto
    List<Espacio> listaPorNumero(String numero);
    
    // Buscar un espacio por ID
    Optional<Espacio> buscaEspacio(int idEspacio);
    
    // Listar espacios por n&ntilde;mero (sin considerar may&ntilde;sculas/min&ntilde;sculas)
    List<Espacio> listaPorNumeros(String numero);
    
    // Buscar espacios por n&ntilde;mero usando un patr&ntilde;n
    List<Espacio> listaPorNumeroLike(String filtro);
    
    // Buscar un espacio por n&ntilde;mero (cuando se registra)
    List<Espacio> listaPorNumeroIgualRegistra(String numero);
    
    // Buscar un espacio por n&ntilde;mero, excluyendo el espacio actual
    List<Espacio> listaPorNumeroIgualActualiza(String numero, int id);
    
    // Consultar espacios con diferentes filtros
    List<Espacio> listaConsultaEspacio(int estado_reserva, String numero, String piso, int acceso);
    
    // Listar espacios disponibles
    List<Espacio> listaEspacioDisponibles();
    
    // Actualizar un espacio
    Espacio actualizarEspacio(Espacio espacio);
    Espacio obtenerEspacioPorId(Integer id); // Cambia Integer al tipo de ID que uses

}

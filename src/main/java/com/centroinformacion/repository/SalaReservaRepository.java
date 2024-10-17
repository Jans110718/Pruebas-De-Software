package com.centroinformacion.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.centroinformacion.entity.ReservaSala;

public interface SalaReservaRepository  extends JpaRepository<ReservaSala, Integer>{

}

package com.centroinformacion.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.centroinformacion.entity.DevolucionHasLibro;
import com.centroinformacion.entity.DevolucionHasLibroPK;

public interface DevolucionHasLibroRepository extends JpaRepository<DevolucionHasLibro, DevolucionHasLibroPK> {

}
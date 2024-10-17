package com.centroinformacion.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.centroinformacion.entity.PrestamoHasLibro;
import com.centroinformacion.entity.PrestamoHasLibroPK;

public interface PrestamoHasLibroRepository  extends JpaRepository<PrestamoHasLibro,PrestamoHasLibroPK>{

}

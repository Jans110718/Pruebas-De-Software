package com.centroinformacion.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.centroinformacion.entity.DataCatalogo;
import com.centroinformacion.entity.Libro;
import com.centroinformacion.entity.Prestamo;

import com.centroinformacion.entity.PrestamoHasLibro;
import com.centroinformacion.repository.LibroRepository;
import com.centroinformacion.repository.PrestamoHasLibroRepository;


import com.centroinformacion.repository.PrestamoRepository;

import jakarta.transaction.Transactional;

@Service

public class PrestamoServiceImpl implements PrestamoService{

	@Autowired
	private PrestamoRepository prestamoRepository;
	
	@Autowired
	private LibroRepository libroRepository;
	
	@Autowired
	private PrestamoHasLibroRepository prestamoHasLibroRepository;
	

	@Override
	@Transactional
	public Prestamo insertaPrestamo(Prestamo obj) {
		Prestamo objCabecera = prestamoRepository.save(obj);

    Libro objLibro = null;
		DataCatalogo objDataCatalogo = new DataCatalogo();
		objDataCatalogo.setIdDataCatalogo(26);
		
		for (PrestamoHasLibro detalle: obj.getDetallesPrestamo()) {
			detalle.getPrestamoHasLibroPK().setIdPrestamo(objCabecera.getIdPrestamo());
			prestamoHasLibroRepository.save(detalle);
			objLibro =libroRepository.findById(detalle.getPrestamoHasLibroPK().getIdLibro()).get();
			objLibro.setEstadoPrestamo(objDataCatalogo);
			libroRepository.save(objLibro);
			
		}
	    return objCabecera;

	}

}
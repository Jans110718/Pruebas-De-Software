package com.centroinformacion.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.centroinformacion.entity.DataCatalogo;
import com.centroinformacion.entity.Devolucion;
import com.centroinformacion.entity.DevolucionHasLibro;
import com.centroinformacion.entity.Libro;
import com.centroinformacion.repository.DevolucionHasLibroRepository;
import com.centroinformacion.repository.DevolucionRepository;
import com.centroinformacion.repository.LibroRepository;

import jakarta.transaction.Transactional;
@Service
public class DevolucionServiceImp implements DevolucionService {

    @Autowired
    private DevolucionRepository devolucionRepository;
    @Autowired
    private LibroRepository libroRepository;
    @Autowired
	private DevolucionHasLibroRepository devolucionHasLibroRepository;
	@Override
	@Transactional
	public Devolucion insertaDevolucion(Devolucion obj) {
		Devolucion objCabecera = devolucionRepository.save(obj);

	    Libro objLibro = null;
			DataCatalogo objDataCatalogo = new DataCatalogo();
			objDataCatalogo.setIdDataCatalogo(27);
			
			for (DevolucionHasLibro detalle: obj.getDetallesDevolucion()) {
				detalle.getDevolucionHasLibroPK().setIdDevolucion(objCabecera.getIdDevolucion());
				devolucionHasLibroRepository.save(detalle);
				objLibro =libroRepository.findById(detalle.getDevolucionHasLibroPK().getIdLibro()).get();
				objLibro.setEstadoPrestamo(objDataCatalogo);
				libroRepository.save(objLibro);
			}
		    return objCabecera;
	}
    
}
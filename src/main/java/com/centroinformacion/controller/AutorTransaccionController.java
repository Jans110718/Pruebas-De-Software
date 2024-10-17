package com.centroinformacion.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.centroinformacion.entity.Autor;
import com.centroinformacion.entity.LibroHasAutor;
import com.centroinformacion.entity.LibroHasAutorPK;
import com.centroinformacion.service.LibroService;


@Controller
public class AutorTransaccionController {
	@Autowired 
	private LibroService libroService;

	@ResponseBody()
	@RequestMapping("/listaAutorPorLibro")
	public List<Autor>listaAutorPorLibro(int idLibro){
	    return libroService.traerAutorDeLibro(idLibro);
	}

	
	
//REGISTRAR AUTOR
	@ResponseBody()
	@PostMapping("/registraAutorTransaccion")
	public HashMap<String, Object> registro(int idLibro, int idAutor){
	    HashMap<String, Object> maps = new HashMap<>();
	    
	    LibroHasAutorPK pk = new LibroHasAutorPK();
	    pk.setIdAutor(idAutor);
	    pk.setIdLibro(idLibro);
	    
	    LibroHasAutor lihau = new LibroHasAutor();
	    lihau.setLibroHasAutorPK(pk);
	    
	    if (libroService.buscaAutor(pk).isPresent()) {
	        maps.put("mensaje", "El autor ya existe");
	    } else {
	        LibroHasAutor objLihau = libroService.insertaAutor(lihau);
	        if (objLihau == null) {
	            maps.put("mensaje", "Error en el registro");
	        } else {
	            maps.put("mensaje", "Registro exitoso");
	        }
	    }
	    
	    List<Autor> lstSalida = libroService.traerAutorDeLibro(idLibro);
	    maps.put("lista", lstSalida);
	    maps.put("libro", idLibro);
	    return maps;
	}
	
//ELIMINAR AUTOR 
@ResponseBody()
@PostMapping("/eliminaAutor")
public HashMap<String, Object> elimina(int idLibro, int idAutor){
    HashMap<String, Object> maps = new HashMap<>();
    
    LibroHasAutorPK pk = new LibroHasAutorPK();
    pk.setIdAutor(idAutor);
    pk.setIdLibro(idLibro);
    LibroHasAutor lihau = new LibroHasAutor();
    lihau.setLibroHasAutorPK(pk);
   
    
    if (libroService.buscaAutor(pk).isPresent()) {
        libroService.eliminaAutor(lihau);
        maps.put("mensaje", "Se eliminó el autor");
    } else {
        maps.put("mensaje", "No existe autor");
    }
    List<Autor> lstSalida = libroService.traerAutorDeLibro(idLibro);
    maps.put("lista", lstSalida);
    maps.put("libro", idLibro);
    return maps;
}
}

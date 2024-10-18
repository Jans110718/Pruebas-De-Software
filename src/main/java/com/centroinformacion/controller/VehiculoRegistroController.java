package com.centroinformacion.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.centroinformacion.entity.Usuario;
import com.centroinformacion.entity.Vehiculo;
import com.centroinformacion.service.VehiculoService;
import com.centroinformacion.util.AppSettings;

import jakarta.servlet.http.HttpSession;

@Controller
public class VehiculoRegistroController {

    @Autowired
    private VehiculoService vehiculoService;

    @PostMapping("/registraVehiculo")
    @ResponseBody
    public Map<?, ?> registra(Vehiculo obj, HttpSession session) {
        Usuario objUsuario = (Usuario) session.getAttribute("objUsuario");
        obj.setFechaRegistro(new Date());
        obj.setFechaActualizacion(new Date());
        obj.setEstado(AppSettings.ACTIVO);
        obj.setUsuarioRegistro(objUsuario);
        obj.setUsuarioActualiza(objUsuario);

        HashMap<String, String> map = new HashMap<>();
        Vehiculo objSalida = vehiculoService.insertaActualizaVehiculo(obj);
        if (objSalida == null) {
            map.put("MENSAJE", "Error en el registro");
        } else {
            map.put("MENSAJE", "Vehiculo registrado exitosamente");
        }
        return map;
    }

    @GetMapping("/buscaPorPlacaVehiculo")
    @ResponseBody
    public String validaPlaca(String placa) {
        List<Vehiculo> lstVehiculo = vehiculoService.listaPorPlacaExacta(placa);
        if (CollectionUtils.isEmpty(lstVehiculo)) {
            return "{\"valid\" : true }";
        } else {
            return "{\"valid\" : false }";
        }
    }
}

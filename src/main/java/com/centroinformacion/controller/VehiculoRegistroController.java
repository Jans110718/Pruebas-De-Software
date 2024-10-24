package com.centroinformacion.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.centroinformacion.entity.Solicitud;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.entity.Vehiculo;
import com.centroinformacion.service.IUploadFileService;
import com.centroinformacion.service.SolicitudService;
import com.centroinformacion.service.VehiculoService;
import com.centroinformacion.util.AppSettings;

import jakarta.servlet.http.HttpSession;

@Controller
public class VehiculoRegistroController {
    @Autowired
    private VehiculoService vehiculoService;
 
    @Autowired
        private IUploadFileService uploadFileService;
    @PostMapping("/registraVehiculo")
    @ResponseBody
    public Map<?, ?> registra(@ModelAttribute("vehiculo") Vehiculo vehiculo, 
                                   @RequestParam("file") MultipartFile image, 
                                   RedirectAttributes flash, SessionStatus status, 
                                   HttpSession session) throws Exception {

        Usuario objUsuario = (Usuario) session.getAttribute("objUsuario");
        vehiculo.setFechaRegistro(new Date());
        vehiculo.setFechaActualizacion(new Date());
        vehiculo.setEstado(AppSettings.ACTIVO);
        vehiculo.setUsuarioRegistro(objUsuario);
        vehiculo.setUsuarioActualiza(objUsuario);

        // Manejo de la imagen (si es que se sube una imagen)
        if (!image.isEmpty()) {
            if (vehiculo.getIdVehiculo() > 0 && vehiculo.getImagen() != null && vehiculo.getImagen().length() > 0) {
                uploadFileService.delete(vehiculo.getImagen()); // Elimina la imagen existente si la hay
            }
            String uniqueFileName = uploadFileService.copy(image); // Guarda la nueva imagen
            vehiculo.setImagen(uniqueFileName); // Asocia el nombre del archivo a la entidad Vehiculo
        }
        // Guarda o actualiza el objeto Vehiculo
        vehiculoService.insertaActualizaVehiculo(vehiculo);
        status.setComplete();

        // Mensaje de &eacute;xito con SweetAlert o Flash
        flash.addFlashAttribute("success", "Veh&iacuteculo registrado exitosamente");
        HashMap<String, String> map = new HashMap<>();
        Vehiculo objSalida = vehiculoService.insertaActualizaVehiculo(vehiculo);
        if (objSalida == null) {
            map.put("MENSAJE", "Error en el registro");
        } else {
            map.put("MENSAJE", "Veh&iacuteculo registrado exitosamente");
            
          
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

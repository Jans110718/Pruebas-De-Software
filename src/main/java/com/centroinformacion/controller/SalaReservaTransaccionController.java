package com.centroinformacion.controller;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.centroinformacion.entity.ReservaSala;
import com.centroinformacion.entity.Sala;
import com.centroinformacion.entity.Usuario;
import com.centroinformacion.service.SalaReservarService;
import com.centroinformacion.service.SalaService;
import com.centroinformacion.util.AppSettings;
import jakarta.servlet.http.HttpSession;


@Controller
public class SalaReservaTransaccionController {
@Autowired
public SalaReservarService salaReservaService;
@Autowired
public SalaService salaService;
@PostMapping("/registraReservaSala")
    @ResponseBody
    public Map<String, Object> registraSalaResevado(ReservaSala obj, HttpSession session) {
Map<String, Object> map = new HashMap<>();
        Usuario objUsuario = (Usuario) session.getAttribute("objUsuario");
        obj.setEstado(AppSettings.ACTIVO);

        obj.setUsuarioRegistro(objUsuario);

        obj.setFechaRegistro(new Date());
        ReservaSala objSalida = salaReservaService.registraSalaReservado(obj);
        if (objSalida == null) {
            map.put("MENSAJE", "Error en el registro");
        } else {
        Sala salaRelacionada = objSalida.getSala();
            salaRelacionada.setEstado(AppSettings.INACTIVO);
            // Actualiza el estado de la sala
            salaService.actualizarSala(salaRelacionada);
            map.put("MENSAJE", "Registro exitoso");
        }
        return map;
    }
}
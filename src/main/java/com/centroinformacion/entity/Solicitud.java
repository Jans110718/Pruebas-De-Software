package com.centroinformacion.entity;

import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "solicitud") // Nombre de la tabla
public class Solicitud {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idSolicitud; // ID de la solicitud

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm") // Formato de hora
    @Temporal(TemporalType.TIME)
    @DateTimeFormat(pattern = "HH:mm") // Formato de hora para binding
    private LocalTime hora; // Hora de la solicitud

    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd") // Formato de fecha para binding
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd") // Formato de fecha
    private Date fechaReserva; // Fecha de reserva

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss") // Formato de fecha y hora
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") // Formato de fecha y hora para binding
    private Date fechaRegistro; // Fecha de registro

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss") // Formato de fecha y hora
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") // Formato de fecha y hora para binding
    private Date fechaActualizacion; // Fecha de actualizaci&ntilde;n

    private int estado; // Estado de la solicitud

    @JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" }) // Ignorar propiedades de Hibernate
    @ManyToOne(fetch = FetchType.LAZY) // Relaci&ntilde;n con la entidad Vehiculo
    @JoinColumn(name = "idVehiculo", nullable = false) // Clave for&ntilde;nea con la tabla Vehiculo
    private Vehiculo vehiculo;

    @JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idUsuarioRegistro")
    private Usuario usuarioRegistro;

    @JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idUsuarioActualiza")
    private Usuario usuarioActualiza;

    @JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" }) // Ignorar propiedades de Hibernate
    @ManyToOne(fetch = FetchType.LAZY) // Relaci&ntilde;n con la entidad Espacio
    @JoinColumn(name = "idEspacio", nullable = false) // Clave for&ntilde;nea con la tabla Espacio
    private Espacio espacio; // Nuevo campo para la relaci&ntilde;n con Espacio

    private int entrada; // Campo para marcar entrada (0= no marcado, 1= marcado)
    private int salida; // Campo para marcar salida (0= no marcado, 1= marcado)
    
    
    public String getreporteVehiculo() {
		return vehiculo.getMarca().concat(" ").concat(vehiculo.getModelo());
	}
    public String getreporteEstado() {
		return estado == 1 ? "Activo" : "Inactivo";

	}
    
    public String getreporteNumero() {
    	return espacio.getNumero();
    }
    public String getreportefechaReserva() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(fechaReserva); 
	}
    public String getreporteHora() {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("HH:mm");
        return hora.format(dtf);

}
  
}

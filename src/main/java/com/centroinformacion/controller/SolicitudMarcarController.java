package com.centroinformacion.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.apachecommons.CommonsLog;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.util.JRLoader;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.centroinformacion.entity.Solicitud;
import com.centroinformacion.service.SolicitudService;

@CommonsLog
@Controller

public class SolicitudMarcarController {
	@Autowired
    private SolicitudService solicitudService;
	@GetMapping("/consultaSolicitud")
	@ResponseBody
	public List<Solicitud> consulta(
	        int idEspacio,
	        int tipoVehiculo,
	        @DateTimeFormat(pattern = "yyyy-MM-dd") Date fecDesde,
	        @DateTimeFormat(pattern = "yyyy-MM-dd") Date fecHasta) {
	    
	    List<Solicitud> lstSalida = solicitudService.listaConsultaEspacio(idEspacio,tipoVehiculo,fecDesde, fecHasta);
	    
	    return lstSalida;
	}
	@GetMapping("/reporteSolicitudPdf")
	public void reportes(HttpServletRequest request, 
			             HttpServletResponse response,
	                     int paramEspacio,
	                     int paramtipoVehiculo,
	                     @DateTimeFormat(pattern = "yyyy-MM-dd") Date paramFechaDesde,
	                     @DateTimeFormat(pattern = "yyyy-MM-dd") Date paramFechaHasta) {
	    try {
	        // PASO 1: OBTENER EL DATASOURCE QUE VA A GENERAR EL REPORTE 
	        List<Solicitud> lstSalida = solicitudService.listaConsultaEspacio(paramEspacio, paramtipoVehiculo, paramFechaDesde, paramFechaHasta);
	        JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(lstSalida);

	        // PASO 2: OBTENER EL ARCHIVO QUE CONTIENE EL DISE&ntilde;O DEL REPORTE 
	        String fileDirectory = request.getServletContext().getRealPath("/WEB-INF/reportes/reportesSolicitud.jasper");
	        log.info(">>> File Reporte >> " + fileDirectory);
	        FileInputStream stream = new FileInputStream(new File(fileDirectory));
	    	
	        // PASO 4: ENVIAMOS DATASOURCE, DISE&ntilde;O Y PAR&ntilde;METROS PARA GENERAR EL PDF 
	        JasperReport jasperReport = (JasperReport) JRLoader.loadObject(stream);
	        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, null, dataSource);

	        // PASO 5: ENVIAR EL PDF GENERADO 
	        response.setContentType("application/x-pdf");
	        response.addHeader("Content-disposition", "attachment; filename=reporteSolicitud.pdf");

	        OutputStream outStream = response.getOutputStream();
	        JasperExportManager.exportReportToPdfStream(jasperPrint, outStream);
	    } catch (Exception e) {
                    e.printStackTrace();	        // Aqu&iacute; puedes manejar la excepci&ntilde;n seg&ntilde;n sea necesario
	    }
	}


}

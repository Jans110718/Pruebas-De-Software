package com.centroinformacion.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.centroinformacion.entity.Tesis;
import com.centroinformacion.service.TesisService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.apachecommons.CommonsLog;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.util.JRLoader;

@Controller
@CommonsLog
public class TesisConsultarController {
	@Autowired
	private TesisService tesisService;
	
	@ResponseBody
	@GetMapping("/consultaTesis")
	public List<Tesis> consulta(int estado,
								int idAlumno,
								String titulo,
								String tema,
								@DateTimeFormat(pattern = "yyyy-MM-dd") Date desde,
								@DateTimeFormat(pattern = "yyyy-MM-dd") Date hasta) {
		List<Tesis> lstSalida = tesisService.listaConsultaTesis(estado, idAlumno, "%"+titulo+"%", "%"+tema+"%", desde, hasta);
		
		return lstSalida;
	}
	
	@GetMapping("/reporteTesisPdf")
	public void reportes(HttpServletRequest request, 
						 HttpServletResponse response,
						 boolean paramEstado,
							int paramIdAlumno,
							String paramTitulo,
							String paramTema,
							@DateTimeFormat(pattern = "yyyy-MM-dd") Date paramDesde,
							@DateTimeFormat(pattern = "yyyy-MM-dd") Date paramHasta) {
		
		try{
		//PASO 1: OBTENER EL DATASOURCE QUE VA A GENERAR EL REPORTE
		List<Tesis> lstSalida = tesisService.listaConsultaTesis(
						paramEstado ?1:0, 
						paramIdAlumno, 
						"%"+paramTitulo+"%", 
						"%"+paramTema+"%", 
						paramDesde, 
						paramHasta);
		
		JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(lstSalida);
		
		//PASO 2: OBTENER EL ARCHIVO QUE CONTIENE EL DISEÑO DEL REPORTE
		String fileDirectory = request.getServletContext().getRealPath("/WEB-INF/reportes/reportesTesis.jasper"); 
		log.info(">>> File Reporte >> " + fileDirectory);
		FileInputStream stream   = new FileInputStream(new File(fileDirectory));
		
		//PASO 3: PARAMETROS ADICIONALES
		String fileLogo = request.getServletContext().getRealPath("/WEB-INF/img/logo.jpg");
		log.info(">>> File Logo >> " + fileLogo);
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("RUTA_LOGO", fileLogo);
		
		//PASO 4: ENVIAMOS DATASOURCE, DISEÑO Y PARÁMETROS PARA GENERAR EL PDF
		JasperReport jasperReport = (JasperReport) JRLoader.loadObject(stream);
		JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport,params, dataSource);
		
		//PASO 5: ENVIAR EL PDF GENERADO
		response.setContentType("application/x-pdf");
	    response.addHeader("Content-disposition", "attachment; filename=ReporteTesis.pdf");

		OutputStream outStream = response.getOutputStream();
		JasperExportManager.exportReportToPdfStream(jasperPrint, outStream);
		
		}catch(Exception e) {
			e.printStackTrace();
		}

	}
}

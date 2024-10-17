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

import com.centroinformacion.entity.Editorial;
import com.centroinformacion.service.EditorialService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.apachecommons.CommonsLog;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.util.JRLoader;

@CommonsLog
@Controller
public class EditorialConsultaController {
	
	@Autowired
	private EditorialService editorialService;
	
	@GetMapping("/consultaEditorial")
	@ResponseBody
	public List<Editorial> consulta(int estado, 
			                        int idPais, 
			                        String razonSocial, 
			                        String direccion, 
			                        String ruc,
			                        @DateTimeFormat(pattern = "yyyy-MM-dd") Date desde, 
			                        @DateTimeFormat(pattern = "yyyy-MM-dd") Date hasta) {
		
		List<Editorial> lstSalida = editorialService.listaConsultaEditorial(estado, idPais, "%"+razonSocial+"%" ,
		"%"+direccion+"%","%"+ruc +"%", desde, hasta);		
		return lstSalida;
	}
	
	@GetMapping("/reporteEditorialPdf")
	public void reportes(HttpServletRequest request, HttpServletResponse response, 
			boolean paramEstado,
			int paramPais,
			String paramRazonSocial,
			String paramDireccion,
            String paramRuc,
            @DateTimeFormat(pattern = "yyyy-MM-dd") Date paramDesde,
			@DateTimeFormat(pattern = "yyyy-MM-dd") Date paramHasta) {

		try {

			List<Editorial> lstSalida = editorialService.listaConsultaEditorial(
					paramEstado ?1:0,
					paramPais,
					"%"+paramRazonSocial+"%",
					"%"+paramDireccion+"%",
					"%"+paramRuc+"%" ,
					paramDesde, 
					paramHasta);

			JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(lstSalida);

			String fileDirectory = request.getServletContext().getRealPath("/WEB-INF/reportes/reporteEditorial.jasper"); 
			log.info(">> FILE REPORTE >> " + fileDirectory);
			
			FileInputStream stream = new  FileInputStream(new File(fileDirectory));
			
			String fileLogo = request.getServletContext().getRealPath("/WEB-INF/img/editorial.jpeg");
			log.info(">> FILE LOGO  >> " + fileLogo);
			
			HashMap<String, Object> params = new HashMap<String, Object>();
			params.put("RUTA_LOGO", fileLogo);
			
			JasperReport jasperReport = (JasperReport) JRLoader.loadObject(stream);
			JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, params, dataSource);

			response.setContentType("application/x-pdf");
			response.addHeader("Content-disposition", "attachment; filename=ReporteEditorial.pdf");

			OutputStream outStream = response.getOutputStream();
			JasperExportManager.exportReportToPdfStream(jasperPrint, outStream);
		} catch (Exception e) {
			e.printStackTrace();
		}
}
}

package com.dc.Credinner.Controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.dc.Credinner.Data.ResultSet;


@Controller
public class OpenController extends CommonController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	//가게검색 결과 진입점
	@RequestMapping(value = "/open/search_result", method = RequestMethod.GET)
	public ModelAndView search_result(HttpServletRequest request) throws Exception {		
		ControllerInit(request, "/WEB-INF/views/open/search_result.jsp");
		return view;		
	}
	
	//가게상세 진입점
	@RequestMapping(value = "/open/search_detail", method = RequestMethod.GET)
	public ModelAndView search_detail(HttpServletRequest request) throws Exception {		
		ControllerInit(request, "/WEB-INF/views/open/search_detail.jsp");
		return view;		
	}
	
	//리뷰조회 진입점
	@RequestMapping(value = "/open/review_detail", method = RequestMethod.GET)
	public ModelAndView review_detail(HttpServletRequest request) throws Exception {		
		ControllerInit(request, "/WEB-INF/views/open/review_detail.jsp");
		return view;		
	}
	
	//리뷰상세 데이터 조회
	@RequestMapping(value = "/open/review_detail_data", method = RequestMethod.POST)	
	public @ResponseBody ResultSet review_detail_data(HttpServletRequest request) {
		ResultSet data = new ResultSet();
		HashMap param = GetParamData(request);		

		try {
			HashMap searchData = mainService.getReivewForRvNum(Integer.parseInt(param.get("seq").toString()));
			data.Data = searchData;
			data.Value = true;
		}
		catch (Exception e) {
			data.Value = false;
			e.printStackTrace();
			logger.error(e.toString());
		}
		return data;
	}
	
	//가게 리뷰 리스트 조회
	@RequestMapping(value = "/open/search_result_review_data", method = RequestMethod.POST)	
	public @ResponseBody ResultSet search_result_review_data(HttpServletRequest request) {
		ResultSet data = new ResultSet();
		HashMap param = GetParamData(request);		

		try {
			List<HashMap> searchData = mainService.getListReivewForResNum(Integer.parseInt(param.get("seq").toString()));
			data.Data = searchData;
			data.Value = true;
		}
		catch (Exception e) {
			data.Value = false;
			e.printStackTrace();
			logger.error(e.toString());
		}
		return data;
	}
	
	//가게 검색 결과
	@RequestMapping(value = "/open/search_result_data", method = RequestMethod.POST)	
	public @ResponseBody ResultSet check_random_number(HttpServletRequest request) {
		ResultSet data = new ResultSet();
		HashMap param = GetParamData(request);		

		try {
			
			String type = "";
			String search_text = "";		
			String search_text_encode = "";
			String seq = "";
			int page = 1;
			
			if(param.get("page") != null ) {
				page = Integer.parseInt(param.get("page").toString());
			}
			
			if(param.get("type") != null) {
				type = param.get("type").toString();
				search_text = param.get("search_text").toString();
				search_text_encode = URLEncoder.encode(search_text, "UTF-8");
			}
			else {
				seq = param.get("seq").toString();
			}
			
			
			
			String url = "";			
			if(type.equals("0")) {
				if(param.get("search_keyword") != null && !param.get("search_keyword").toString().equals("")) {
					//가게명 + 지역구명 조회
					url = "http://openapi.seoul.go.kr:8088/57767549776a6f793137516c544b53/xml/CrtfcUpsoInfo/" + String.valueOf(((page -1) * 10) + 1) + "/" + String.valueOf(page * 10) + "/%20/%20/" + search_text_encode + "/%20/" + URLEncoder.encode(param.get("search_keyword").toString(), "UTF-8");
				}
				else {
					//가게명 조회
					url = "http://openapi.seoul.go.kr:8088/57767549776a6f793137516c544b53/xml/CrtfcUpsoInfo/" + String.valueOf(((page -1) * 10) + 1) + "/" + String.valueOf(page * 10) + "/%20/%20/" + search_text_encode;
				}
			}
			else if(type.equals("1")) {
				//지역구명 조회
				url = "http://openapi.seoul.go.kr:8088/57767549776a6f793137516c544b53/xml/CrtfcUpsoInfo/" + String.valueOf(((page -1) * 10) +1) + "/"+String.valueOf(page * 10)+"/%20/%20/%20/%20/" + search_text_encode;
			}
			else {				
				//가게 번호로 조회
				url = "http://openapi.seoul.go.kr:8088/57767549776a6f793137516c544b53/xml/CrtfcUpsoInfo/1/1/" + seq;
			}
			logger.debug(url);
			
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder documentBuilder = factory.newDocumentBuilder();
			Document document = documentBuilder.parse(url);
			
			Element root = document.getDocumentElement();
			
			int list_total_count = 0;
			List<HashMap> rawResult = new ArrayList<HashMap>();
			
			NodeList childeren = root.getChildNodes();
			for(int i = 0; i < childeren.getLength(); i++){
				Node node = childeren.item(i);
				if(node.getNodeName().equals("list_total_count")) {
					list_total_count = Integer.parseInt(node.getTextContent());
				}
				if(node.getNodeName().equals("row")) {
					NodeList rowNode = node.getChildNodes();
					String address1 = "";
					String address2 = "";
					String UPSO_NM = "";
					HashMap row = new HashMap();
					for(int j =0; j < rowNode.getLength(); j++) {
						Node t = rowNode.item(j);
						//api xml데이터를 hashmap 데이터로 변환
						row.put(t.getNodeName(), t.getTextContent());
						//중요 데이터만 변수로 따로 처리
						if(t.getNodeName().equals("RDN_CODE_NM")) {
							address1 = t.getTextContent();
						}
						if(t.getNodeName().equals("RDN_DETAIL_ADDR")) {
							address2 = t.getTextContent();
						}
						if(t.getNodeName().equals("UPSO_NM")) {
							UPSO_NM = t.getTextContent();
						}
					}
					
					row.put("imageSrc", get_google_image(UPSO_NM, "200"));
					//row.put("imageSrc", get_google_image(address1 + " " + address2, "200"));
					
					rawResult.add(row);
				}
			}
			
			data.Value = true;
			data.Data = rawResult;
						
		} catch (Exception e) {
			data.Value = false;
			e.printStackTrace();
			logger.error(e.toString());
		}
		

		return data;
		
	}
	
	//리뷰 이미지 리스트 조회
	@RequestMapping(value = "/open/review_image_list", method = RequestMethod.POST)	
	public @ResponseBody ResultSet review_image_list(HttpServletRequest request) {
		ResultSet data = new ResultSet();
		HashMap param = GetParamData(request);		

		try {
			List<HashMap> imageData = mainService.getListReivewPhoto(Integer.parseInt(param.get("seq").toString()));
			data.Data = imageData;
			data.Value = true;
		}
		catch (Exception e) {
			data.Value = false;
			e.printStackTrace();
			logger.error(e.toString());
		}
		return data;
	}
	
	//리뷰 이미지 리소스 접근(pk로 접근)
	@RequestMapping(value = "/open/viewImage")
	public void DownloadImg(HttpServletRequest request, HttpServletResponse response) throws Exception {
		FileInputStream fis= null;
		BufferedInputStream bis=null;
		ServletOutputStream so=null;
		BufferedOutputStream bos=null;
		try 
		{
			HashMap param = GetParamData(request);
			
			HashMap fileData = mainService.getReivewPhoto(Integer.parseInt(param.get("seq").toString()));;
			String RV_PHOTO_ORIGIN = fileData.get("RV_PHOTO_ORIGIN").toString();
			String exp = FilenameUtils.getExtension(RV_PHOTO_ORIGIN);
			String dFile = fileData.get("RV_PHOTO_NUM").toString() + "." + exp;						
			String path = request.getSession().getServletContext().getRealPath("/WEB-INF/classes/uploadFile/") + "/" + fileData.get("RV_PHOTO_NUM").toString();
			logger.debug(path);
			
			  
			File file = new File(path);
			String userAgent = request.getHeader("User-Agent");
			boolean ie = userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("rv:11") > -1;
			String fileName = null;
			   
			if (ie) {
			   fileName = URLEncoder.encode(dFile, "utf-8");
			} else {
			   fileName = new String(dFile.getBytes("utf-8"),"iso-8859-1");
			}
			  
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Disposition","attachment;filename=\"" +fileName+"\";");
			  
			fis=new FileInputStream(file);
			bis=new BufferedInputStream(fis);
			so=response.getOutputStream();
			bos=new BufferedOutputStream(so);
			  
			byte[] data=new byte[2048];
			int input=0;
			while((input=bis.read(data))!=-1){
			   bos.write(data,0,input);
			   bos.flush();
			}
			  
			if(bos!=null) bos.close();
			if(bis!=null) bis.close();
			if(so!=null) so.close();
			if(fis!=null) fis.close();	
		}
		catch(Exception ee) {
			ee.printStackTrace();
			logger.error(ee.toString());
			if(bos!=null) bos.close();
			if(bis!=null) bis.close();
			if(so!=null) so.close();
			if(fis!=null) fis.close();
		}
	}
	
}

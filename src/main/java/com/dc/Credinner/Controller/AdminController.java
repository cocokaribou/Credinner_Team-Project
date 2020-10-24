package com.dc.Credinner.Controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.Inet4Address;
import java.net.URLEncoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import org.apache.commons.codec.binary.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.activation.MimetypesFileTypeMap;
import javax.rmi.CORBA.Stub;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.*;

import com.dc.Credinner.Data.ResultSet;
import com.lowagie.text.pdf.PdfContentByte;


@Controller
public class AdminController extends CommonController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	//관리자 리뷰 리스트 진입점
	@RequestMapping(value = "/admin/review", method = RequestMethod.GET)
	public ModelAndView review(HttpServletRequest request) throws Exception {		
		ControllerInit(request, "/WEB-INF/views/admin/review.jsp");		
		return view;		
	}
	
	//관리자 리뷰 상세 진입점
	@RequestMapping(value = "/admin/review_detail", method = RequestMethod.GET)
	public ModelAndView review_detail(HttpServletRequest request) throws Exception {		
		HashMap param = GetParamData(request);
		view.addObject("star", param.get("star").toString());		
		ControllerInit(request, "/WEB-INF/views/admin/review_detail.jsp");		
		return view;		
	}
	
	//관리자 리뷰 상세 조회
	@RequestMapping(value = "/admin/review_data_detail", method = RequestMethod.POST)	
	public @ResponseBody ResultSet review_data_detail(HttpServletRequest request) {
		ResultSet data = new ResultSet();
		HashMap param = GetParamData(request);		

		try {
			int RV_NUM = Integer.parseInt(param.get("seq").toString());
			
			HashMap dbData = mainService.getReivewForRvNum(RV_NUM);
			data.Data = dbData;
			data.Value = true;
		}
		catch (Exception e) {
			data.Value = false;
			e.printStackTrace();
			logger.error(e.toString());
		}
		return data;
	}
	
	//관리자 리뷰 리스트 조회
	@RequestMapping(value = "/admin/review_data", method = RequestMethod.POST)	
	public @ResponseBody ResultSet review_data(HttpServletRequest request) {
		ResultSet data = new ResultSet();
		HashMap param = GetParamData(request);		

		try {
			int page = Integer.parseInt(param.get("page").toString());	
			
			
			List<HashMap> dbData = mainService.admin_review_data((page-1) * 15, page * 15, param.get("search_string").toString());
			data.Data = dbData;
			data.Value = true;
		}
		catch (Exception e) {
			data.Value = false;
			e.printStackTrace();
			logger.error(e.toString());
		}
		return data;
	}
	
	//관리자 회원 리스트 조회
	@RequestMapping(value = "/admin/member_data", method = RequestMethod.POST)	
	public @ResponseBody ResultSet member_data(HttpServletRequest request) {
		ResultSet data = new ResultSet();
		HashMap param = GetParamData(request);		

		try {
			int page = Integer.parseInt(param.get("page").toString());	
			
			
			List<HashMap> dbData = mainService.admin_member_data((page-1) * 15, page * 15, param.get("search_string").toString());
			data.Data = dbData;
			data.Value = true;
		}
		catch (Exception e) {
			data.Value = false;
			e.printStackTrace();
			logger.error(e.toString());
		}
		return data;
	}
	
	//관리자 회원리스트 진입점
	@RequestMapping(value = "/admin/member", method = RequestMethod.GET)
	public ModelAndView member(HttpServletRequest request) throws Exception {		
		ControllerInit(request, "/WEB-INF/views/admin/member.jsp");		
		return view;		
	}
	
	//관리자 회원 상세 진입점
	@RequestMapping(value = "/admin/member_detail", method = RequestMethod.GET)
	public ModelAndView member_detail(HttpServletRequest request) throws Exception {		
		ControllerInit(request, "/WEB-INF/views/admin/member_detail.jsp");		
		return view;		
	}
	
	//관리자 리뷰 이미지 리스트 조회
	@RequestMapping(value = "/admin/review_image_list", method = RequestMethod.POST)
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
	
	//관리자 회원 삭제
	@RequestMapping(value = "/admin/remove_member", method = RequestMethod.POST)
	public @ResponseBody ResultSet remove_member(HttpServletRequest request) {
		ResultSet data = new ResultSet();
		HashMap param = GetParamData(request);		

		try {
			mainService.remove_member(Integer.parseInt(param.get("seq").toString()));			
			data.Value = true;
		}
		catch (Exception e) {
			data.Value = false;
			e.printStackTrace();
			logger.error(e.toString());
		}
		return data;
	}
	
	//관리자 리뷰 삭제
	@RequestMapping(value = "/admin/remove_reivew", method = RequestMethod.POST)
	public @ResponseBody ResultSet remove_reivew(HttpServletRequest request) {
		ResultSet data = new ResultSet();
		HashMap param = GetParamData(request);		

		try {
			mainService.remove_reivew(Integer.parseInt(param.get("seq").toString()));			
			data.Value = true;
		}
		catch (Exception e) {
			data.Value = false;
			e.printStackTrace();
			logger.error(e.toString());
		}
		return data;
	}
	
	//관리자 리뷰 이미지 삭제
	@RequestMapping(value = "/admin/remove_reivew_image", method = RequestMethod.POST)
	public @ResponseBody ResultSet remove_reivew_image(HttpServletRequest request) {
		ResultSet data = new ResultSet();
		HashMap param = GetParamData(request);		

		try {
			mainService.remove_reivew_image(Integer.parseInt(param.get("RV_PHOTO_NUM").toString()));			
			data.Value = true;
		}
		catch (Exception e) {
			data.Value = false;
			e.printStackTrace();
			logger.error(e.toString());
		}
		return data;
	}
	
	//관리자 리뷰 수정
	@RequestMapping(value = "/admin/review_update_action", method = RequestMethod.POST)
	public @ResponseBody ResultSet review_create_action(HttpServletRequest request)
    {
		ResultSet data = new ResultSet();		
		HashMap param = GetParamData(request);
		
		try
		{
			String param_seq = param.get("param_seq").toString();
			String param_rating = param.get("param_rating").toString();
			String param_memo_long = param.get("param_memo_long").toString();
			String param_radio_q_1 = param.get("param_radio_q_1").toString();
			String param_radio_q_2 = param.get("param_radio_q_2").toString();
			String param_radio_q_3 = param.get("param_radio_q_3").toString();
			String param_radio_q_4 = param.get("param_radio_q_4").toString();
			String param_memo = param.get("param_memo").toString();
			
			String param_res_nm = param.get("param_res_nm").toString();
			String param_res_distric = param.get("param_res_distric").toString();
			String param_res_menu = param.get("param_res_menu").toString();
			String param_res_addrs = param.get("param_res_addrs").toString();
			String param_res_photo_url = param.get("param_res_photo_url").toString();
			
			if(param_seq.equals("")) {
				data.Value = false;
	        	data.Message = "리뷰 번호가 잘못되었습니다.";
	        	return data;
			}
			HashMap userData = GetUserData();
			mainService.UpdateReview(Integer.parseInt(userData.get("MB_NUM").toString())
					,Integer.parseInt(param_seq)
					,Integer.parseInt(param_rating)
					,param_memo_long
					,param_memo
					,Integer.parseInt(param_radio_q_1)
					,Integer.parseInt(param_radio_q_2)
					,Integer.parseInt(param_radio_q_3)
					,Integer.parseInt(param_radio_q_4)
					,param_res_nm, param_res_distric, param_res_menu, param_res_addrs, param_res_photo_url
					);		
			
			MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		    Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
		    
		    List<MultipartFile> fileList = multipartHttpServletRequest.getFiles("param_file");
		    String path = request.getSession().getServletContext().getRealPath("/WEB-INF/classes/uploadFile/");	        	        
	        
	        File Folder = new File(path);
	        if(!Folder.exists()) {
	        	Folder.mkdir();
	        }
	        
	        
	        for(int i=0; i < fileList.size(); i++)
	        {
	        	MultipartFile multipartFile = fileList.get(i);
	        	if(multipartFile.isEmpty() == true) {
	        		continue;
	        	}       
	        	
	        	String originalFileName = multipartFile.getOriginalFilename();	
	        	int RV_PHOTO_NUM = mainService.InsertReviewPhoto(Integer.parseInt(param_seq), originalFileName);
	        	multipartFile.transferTo(new File(path + String.valueOf(RV_PHOTO_NUM)));
	        }
	        
		    
		   
		    data.Value = true;
		}
		catch (Exception ex) { 
			logger.error(ex.toString());
			ex.printStackTrace();
			data.Value = false;
		}    
		return data;
	}
	
	//관리자 회원 상세 조회
	@RequestMapping(value = "/admin/member_info_data", method = RequestMethod.POST)	
	public @ResponseBody ResultSet member_info_data(HttpServletRequest request) {
		ResultSet data = new ResultSet();
		HashMap param = GetParamData(request);		

		try {
			HashMap dbData = mainService.getMemberInfoFor_MB_NUM(Integer.parseInt(param.get("seq").toString()));
			data.Data = dbData;
			data.Value = true;
		}
		catch (Exception e) {
			data.Value = false;
			e.printStackTrace();
			logger.error(e.toString());
		}
		return data;
	}
	
	//관리자 회원정보 수정
	@RequestMapping(value = "/admin/member_info_update", method = RequestMethod.POST)
	public @ResponseBody ResultSet signup_action(HttpServletRequest request) {
		ResultSet data = new ResultSet();
		HashMap param = GetParamData(request);		

		try {
			String param_name = param.get("param_name").toString();			
			String param_nick_name = param.get("param_nick_name").toString();
			String param_email = param.get("param_email").toString();
			String param_password = param.get("param_password").toString();			
			String param_check = param.get("param_check").toString();
			
			if(param_name.equals("")) {
				data.Value = false;
	        	data.Message = "이름을 입력해 주세요";
	        	return data;
			}
			
			if(param_nick_name.equals("")) {
				data.Value = false;
	        	data.Message = "닉네임을 입력해 주세요";
	        	return data;
			}
			
			if(param_password.equals("")) {
				data.Value = false;
	        	data.Message = "패스워드를 입력해 주세요";
	        	return data;
			}
			
			
			byte[] encodedBytes = Base64.encodeBase64(param_password.getBytes());

			String pw_encode = new String(encodedBytes);			
			int MB_NUM = Integer.parseInt(param.get("seq").toString());
			
			mainService.UpdateMemberAdmin(MB_NUM, param_nick_name, param_name, param_email, pw_encode);
			
			String[] split_param_check = param_check.split(";");
			mainService.ResetMemberKeyWord(MB_NUM);
			for(int i=0; i < split_param_check.length; i++) {
				mainService.InsertMemberKeyWord(MB_NUM, split_param_check[i]);
			}
			
			data.Data = 0;
			data.Value = true;			
		} catch (Exception e) {
			data.Value = false;		
			e.printStackTrace();
			logger.error(e.toString());
		}
		return data;		
	}
}

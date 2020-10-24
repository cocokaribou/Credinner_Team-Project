package com.dc.Credinner.Controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.concurrent.ThreadLocalRandom;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dc.Credinner.Data.ResultSet;

@Controller
public class MemberController extends CommonController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	//로그인 화면 진입점
	@RequestMapping(value = "/member/login")
	public ModelAndView login(HttpServletRequest request) throws Exception {
		ControllerLoginInit(request, "/WEB-INF/views/member/login.jsp");
		return view;
	}
	
	//패스워드 찾기 화면 진입점
	@RequestMapping(value = "/member/password_forget")
	public ModelAndView password_forget(HttpServletRequest request) throws Exception {
		ControllerLoginInit(request, "/WEB-INF/views/member/password_forget.jsp");
		return view;
	}
	
	//아이디 찾기 화면 진입점
	@RequestMapping(value = "/member/id_forget")
	public ModelAndView id_forget(HttpServletRequest request) throws Exception {
		ControllerLoginInit(request, "/WEB-INF/views/member/id_forget.jsp");
		return view;
	}
	
	//회원가입 진입점
	@RequestMapping(value = "/member/signup")
	public ModelAndView signup(HttpServletRequest request) throws Exception {
		ControllerNoneInit(request, "/WEB-INF/views/member/signup.jsp");
		return view;
	}
	
	//아이디 중복 검사
	@RequestMapping(value = "/member/id_check", method = RequestMethod.POST)
	public @ResponseBody ResultSet id_check(HttpServletRequest request) {
		ResultSet data = new ResultSet();
		HashMap param = GetParamData(request);		

		try {
			String id = param.get("id").toString();
			if(id.equals("")) {
				data.Value = false;
				data.Message = "아이디를 입력해 주세요";
				return data;
			}
			data.Value = mainService.getUserData(id) == null;
			if(!data.Value) {
				data.Message = "중복아이디 입니다";				
			}
						
		} catch (Exception e) {
			data.Value = false;
			data.Message = "아이디 중복검사에 실패했습니다.";
			logger.error(e.toString());
		}
		

		return data;
		
	}
	
	//인증번호 발송
	@RequestMapping(value = "/member/send_check_mail", method = RequestMethod.POST)
	public @ResponseBody ResultSet send_check_mail(HttpServletRequest request) {
		ResultSet data = new ResultSet();
		HashMap param = GetParamData(request);		

		try {
			String email = param.get("email").toString();
			if(email.equals("")) {
				data.Value = false;
				data.Message = "이메일 주소를 입력해주세요";
				return data;
			}
			
			SendMailSessionNumber(email);
			data.Value = true;			
		} catch (Exception e) {
			e.printStackTrace();
			data.Value = false;		
			logger.error(e.toString());
		}
		return data;		
	}
	
	//회원 가입
	@RequestMapping(value = "/member/signup_action", method = RequestMethod.POST)
	public @ResponseBody ResultSet signup_action(HttpServletRequest request) {
		ResultSet data = new ResultSet();
		HashMap param = GetParamData(request);		

		try {
			String param_name = param.get("param_name").toString();
			String param_id = param.get("param_id").toString();
			String param_nick_name = param.get("param_nick_name").toString();
			String param_password = param.get("param_password").toString();
			String param_email = param.get("param_email").toString();
			String param_email_check = param.get("param_email_check").toString();
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
			
			String randomNumber = GetRandomNumber();			
			
			if(randomNumber.equals("")) {
				data.Value = true;
				data.Data = 2;
				data.Message = "인증번호를 먼저 발급받아 주세요";
				return data;
			}			
			else if(!param_email_check.equals(randomNumber)) {
				data.Value = true;
				data.Data = 1;
				data.Message = "인증번호가 다릅니다";
				return data;
			}		
			
			
			if(mainService.getUserDataForEmail(param_email) != null) {
				data.Value = true;
				data.Data = 3;
				data.Message = "이메일 주소가 중복입니다";
				ReSetRandomNumber();
				return data;
			}
			
			//인증번호 초기화
			ReSetRandomNumber();
			
			//base64로 패스워드로 숨김
			byte[] encodedBytes = Base64.encodeBase64(param_password.getBytes());

			String pw_encode = new String(encodedBytes);
			
			int MB_NUM = mainService.InsertMember(param_id, param_nick_name, param_name, param_email, pw_encode, "0");
			
			String[] split_param_check = param_check.split(";");
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
	
	//아이디 찾기
	@RequestMapping(value = "/member/search_id_action", method = RequestMethod.POST)
	public @ResponseBody ResultSet search_id_action(HttpServletRequest request) {
		ResultSet data = new ResultSet();
		HashMap param = GetParamData(request);		

		try {
			String number = param.get("number").toString();
			String email = param.get("email").toString();	
			
			String randomNumber = GetRandomNumber();
			
			if(randomNumber.equals("")) {
				data.Value = true;
				data.Data = 2;
				data.Message = "인증번호를 먼저 발급받아 주세요";
			}
			
			if(number.equals(randomNumber)) {				
				ReSetRandomNumber();
				HashMap userData = mainService.getUserDataForEmail(email);
				data.Value = true;	
				data.Data = 0;
				data.Message = "인증번호가 메일로 발송되었습니다.";
				String MB_ID = userData.get("MB_ID").toString();
				String MB_EMAIL = userData.get("MB_EMAIL").toString();
				SendMail(MB_EMAIL, "Credinner 아이디 찾기", "안녕하세요, 크레디너입니다.\r\n회원님의 아이디입니다:  " +MB_ID);
			}
			else {
				data.Value = true;
				data.Data = 1;
				data.Message = "인증번호가 다릅니다";
			}
						
		} catch (Exception e) {
			e.printStackTrace();
			data.Value = false;
			logger.error(e.toString());
		}
		

		return data;
		
	}
	
	//패스워드 초기화
	@RequestMapping(value = "/member/reset_password", method = RequestMethod.POST)
	public @ResponseBody ResultSet check_random_number(HttpServletRequest request) {
		ResultSet data = new ResultSet();
		HashMap param = GetParamData(request);		

		try {
			String number = param.get("number").toString();		
			String email = param.get("email").toString();	
			
			String randomNumber = GetRandomNumber();
			
			if(randomNumber.equals("")) {
				data.Value = true;
				data.Data = 2;
				data.Message = "인증번호를 먼저 발급받아 주세요";
			}
			
			if(number.equals(randomNumber)) {
				data.Value = true;	
				data.Data = 0;
				data.Message = "초기화된 패스워드가 메일로 발송되었습니다";
				ReSetRandomNumber();
				HashMap userData = mainService.getUserDataForEmail(email);
				String MB_ID = userData.get("MB_ID").toString();
				String MB_EMAIL = userData.get("MB_EMAIL").toString();				
				String newPW = String.valueOf(ThreadLocalRandom.current().nextInt(10000000, 100000000));
				
				byte[] encodedBytes = Base64.encodeBase64(newPW.getBytes());

				String pw_encode = new String(encodedBytes);
				mainService.UpdateMemberPW(MB_ID,pw_encode);
				SendMail(MB_EMAIL, "Credinner 패스워드 초기화", "안녕하세요, 크레디너입니다.\r\n초기화된 패스워드 입니다: " +newPW);
				
			}
			else {
				data.Value = true;
				data.Data = 1;
				data.Message = "인증번호가 다릅니다";
			}
						
		} catch (Exception e) {
			e.printStackTrace();
			data.Value = false;
			logger.error(e.toString());
		}
		

		return data;
		
	}
	
	//로그아웃
	@RequestMapping(value = "/member/logout")
    public String  logout(HttpSession session) {
		session.invalidate();
        return "redirect:/";
    }
	
	//로그인 실패
	@RequestMapping(value = "/member/login_fail")
    public ModelAndView login_fail(HttpServletRequest request) throws Exception {
		ControllerSingleInit(request, "/WEB-INF/views/member/login_fail.jsp");
		return view;
	}
	
	//로그인 성공
	@RequestMapping(value = "/member/login_success")
    public String login_success(HttpSession session) {
        UserDetails userDetails = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getDetails();
         
        logger.info("Welcome login_success! {}, {}", session.getId(), userDetails.getUsername() + "/" + userDetails.getPassword());
        session.setAttribute("userLoginInfo", userDetails);
        
        return "redirect:/";
    }
	
}

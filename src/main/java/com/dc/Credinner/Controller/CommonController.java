package com.dc.Credinner.Controller;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Properties;
import java.util.concurrent.ThreadLocalRandom;

import javax.annotation.Resource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.dc.Credinner.Data.ResultSet;
import com.dc.Credinner.Service.MainService;


public class CommonController {
	
	//오라클 연결 서비스(spring에서 주입)
	@Resource(name = "MainService")
	protected MainService mainService;

	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);

	public String _userID = "";

	protected JSONParser parser = new JSONParser();
	
	//json to java class 변환기
	public ResultSet GetJsonResultSet(String json) {
		logger.debug("json string : " + json);

		ResultSet resultSet = new ResultSet();
		JSONObject data = GetJsonObject(json);

		if (data.equals(null)) {
			return null;
		}

		resultSet.Value = (Boolean) data.get("Value");
		resultSet.Message = (String) data.get("Message");
		resultSet.Data = data.get("Data");

		return resultSet;
	}
	
	//json to java object 변환기
	public JSONObject GetJsonObject(String json) {
		JSONObject jsonObject = null;
		try {
			Object obj = parser.parse(json);
			jsonObject = (JSONObject) obj;
		} catch (Exception e) {
			logger.error(e.toString());
			return null;
		}

		return jsonObject;
	}	
	
	
	protected ModelAndView view = new ModelAndView();
	HttpSession session;

	//공통 화면 호출
	public void ControllerInit(HttpServletRequest request) throws Exception {
		this.ControllerInit(request, "/common/layout", "");
	}

	//공통화면 호출(컨텐츠 포함)
	public void ControllerInit(HttpServletRequest request, String contentPage) throws Exception {
		this.ControllerInit(request, "/common/layout", contentPage);
	}

	//공통화면(헤더 없음) 호출
	public void ControllerSingleInit(HttpServletRequest request, String contentPage) throws Exception {
		this.ControllerInit(request, "/common/layoutSingle", contentPage);
	}

	//공통 로그인 화면 호출(헤더 없음)
	public void ControllerLoginInit(HttpServletRequest request, String contentPage) throws Exception {
		this.ControllerInit(request, "/common/layoutLogin", contentPage);
	}
	
	public void ControllerNoneInit(HttpServletRequest request, String contentPage) throws Exception {
		this.ControllerInit(request, "/common/layoutNone", contentPage);
	}
	
	//유저 키 획득
	public String GetUserName() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

		if (authentication.equals(null)) {
			return "";
		}

		return authentication.getName();
	}

	//현재 세선명 획득(로그인 안해도 나옴)
	public String GetSessionName() {
		return RequestContextHolder.currentRequestAttributes().getSessionId();
	}

	//request 파라메터 검사
	public Boolean CheckParam(HashMap target) {
		for (int k = 0; k < target.size(); k++) {
			String t = target.values().toArray()[k].toString();
			if (t.equals(null) || t == "") {
				return false;
			}
		}

		return true;
	}

	//회원 정보 조회
	public HashMap GetUserData() {
		return mainService.getUserData(GetUserName());
	}
	
	//공통 화면 기초 데이터 생성
	public void ControllerInit(HttpServletRequest request, String masterPage, String contentPage) throws Exception {

		session = request.getSession();
		view.addObject("UserName", GetUserName());		
		view.addObject("sessionID", session.getId());
		
		//로그인 여부 확인
		if(!GetUserName().equals("anonymousUser")) {
			//회원 등급 부여
			view.addObject("UserType",GetUserData().get("TYPE").toString());
			view.addObject("UserNick", GetUserData().get("MB_NICK").toString());
		}
		else{
			view.addObject("UserType","-1");	
			view.addObject("UserNick", "");
		}
		
		view.setViewName(masterPage);
		view.addObject("contentPage", contentPage);
	}
	
	//공통 페이지 교체(필요시만 사용)
	public void ChagneViewPage(String contentPage) {
		view.addObject("contentPage", contentPage);
	}

	//로깅 매서드
	public void SysLog(String message) {
		Calendar calendar = Calendar.getInstance();		
		java.util.Date date = calendar.getTime();
		String today = (new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date));
		System.out.println(today + " : " + message);
	}

	//request parameter to HashMap 변환기
	public HashMap GetParamData(HttpServletRequest request) {
		HashMap hasMap = new HashMap();
		Enumeration enums = request.getParameterNames();

		SysLog("request params start");
		while (enums.hasMoreElements()) {
			String paramName = (String) enums.nextElement();
			String parameters = request.getParameter(paramName);
			hasMap.put(paramName, parameters);
			SysLog(paramName + ":" + parameters);
		}
		SysLog("request params end");
		return hasMap;
	}
	
	//인증 메일 발송
	public void SendMailSessionNumber(String email) {
		int randomNumber = ThreadLocalRandom.current().nextInt(100000, 1000000);
		session.setAttribute("randomNumber", randomNumber);
		
		SendMail(email, "Credinner 이메일 인증번호", "안녕하세요, 크레디너입니다.\r\n본인 확인을 위해 아래의 인증코드를 화면에 입력해주세요.\r\n\r\n인증번호 : " + String.valueOf(randomNumber));
	}
	
	//난수 생성기
	public String GetRandomNumber() {				
		return session.getAttribute("randomNumber").toString();
	}
	
	//인증번호 초기화
	public void ReSetRandomNumber() {
		session.setAttribute("randomNumber", "");		
	}
	
	//메일 발송
	public void SendMail(String email, String title, String content) {
		Properties p = System.getProperties();
        p.put("mail.smtp.starttls.enable", "true");    
        p.put("mail.smtp.host", "smtp.gmail.com");     
        p.put("mail.smtp.auth","true");                
        p.put("mail.smtp.port", "587");                
           
        Authenticator auth = new MailAuth();

        Session session = Session.getDefaultInstance(p, auth);        
        MimeMessage msg = new MimeMessage(session);
         
        try{            
            msg.setSentDate(new Date());
             
            InternetAddress from = new InternetAddress() ;
             
             
            from = new InternetAddress("Credinner<scit39b2@gmail.com>");
            msg.setFrom(from);
            InternetAddress to = new InternetAddress(email);
            msg.setRecipient(Message.RecipientType.TO, to);
            msg.setSubject(title, "UTF-8");
            msg.setText(content, "UTF-8");
            javax.mail.Transport.send(msg);
             
        }catch (Exception e) {
            e.printStackTrace();
        }
		
	}
	
	//메일 계정 인증(gmail)
	public class MailAuth extends Authenticator{
	    PasswordAuthentication pa;	    

	    public MailAuth() {
	        String mail_id = "scit39b2@gmail.com";
	        String mail_pw = "ict201612";
	        pa = new PasswordAuthentication(mail_id, mail_pw);
	    }
	    

	    public PasswordAuthentication getPasswordAuthentication() {
	        return pa;
	    }
	}
	
	//구글 플레이스 api호출(이미지 얻기)
	public String get_google_image(String query, String width) {		
		try 
		{
			String query_encode = URLEncoder.encode(query, "UTF-8");
			String googleUrl = "https://maps.googleapis.com/maps/api/place/textsearch/xml?key=AIzaSyCTORNB8J2LgbD-eZ1dXsr2Sw3p6uuKzNM&query=" + query_encode;
			logger.debug("google api : " + googleUrl);
			
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder documentBuilder = factory.newDocumentBuilder();
			Document document = documentBuilder.parse(googleUrl);
			
			Element root = document.getDocumentElement();
			//XML 에서 photo 태그를 찾는다.
			NodeList childeren = root.getChildNodes();
			for(int i = 0; i < childeren.getLength(); i++){
				Node node = childeren.item(i);
				if(node.getNodeName().equals("result")) {
					try 
					{
						NodeList childeren2 = node.getChildNodes();
						for(int j=0; j < childeren2.getLength(); j++) {
							Node node2 = childeren2.item(j);
							if(node2.getNodeName().equals("photo")) 
							{
								NodeList childeren3 = node2.getChildNodes();
								for(int k=0; k < childeren3.getLength(); k++) {
									Node node3 = childeren3.item(k);
									if(node3.getNodeName().equals("photo_reference")) 
									{										
										return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=" + width + "&key=AIzaSyCTORNB8J2LgbD-eZ1dXsr2Sw3p6uuKzNM&photoreference=" + node3.getTextContent();
									}
								}							
							}
						}
					}
					catch(Exception eee)
					{
						//만약 실패하더라도 에러 발생시키지 않음(이미지 없을수도 있음)
						logger.debug(eee.toString());											
					}
				}
			}
			
			//이미지를 못가져 온다면 서버의 없음 이미지로 매핑
			return "/resources/img/no_img.gif";	 
		}
		catch(Exception ee)
		{
			logger.error(ee.toString());
			return "/resources/img/no_img.gif";			
		}
	}
    
}

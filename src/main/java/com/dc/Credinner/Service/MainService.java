package com.dc.Credinner.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dc.Credinner.Data.ResultSet;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;  
import org.springframework.security.crypto.password.PasswordEncoder;

@Service(value = "MainService")
public class MainService extends CommonService implements UserDetailsService  {
	
	protected Log log = LogFactory.getLog(MainService.class);
	
	static final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	
	String GetNowDateString()
	{
		long time = System.currentTimeMillis(); 

		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String str = dayTime.format(new Date(time));
		
		return str;
	}
	
	String GetNowDateYYYYString()
	{
		long time = System.currentTimeMillis(); 

		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy");

		String str = dayTime.format(new Date(time));
		
		return str;
	}

	//spring security 사용자 인증
	@Override
    public UserDetails loadUserByUsername(String username)
            throws UsernameNotFoundException {			
		HashMap param = new HashMap();		
		param.put("id", username);
		HashMap data= this.selectOne("MainQuery.GetUser", param);
		String type = data.get("TYPE").toString();
		String pw = data.get("MB_PW").toString();
		Decoder decoder = Base64.getDecoder();		
		byte[] decodedBytes = decoder.decode(pw);
		String password = "";
		try {
			password = new String(decodedBytes, "UTF-8");
		}
		catch(Exception ee) {
			
		}
		System.out.println("username : " + username);
        //System.out.println("password : " + password);
        password = passwordEncoder.encode(password);        
        
        List<SimpleGrantedAuthority> authorities = new ArrayList<SimpleGrantedAuthority>();
        if(type.equals("0"))
        {
        	authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
        }
        else {
        	authorities.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
        }
        
        UserDetails user=new User(username, password, true, true, true, true, authorities);
        
        return user;
    }
	
	//사용자 정보조회
	public HashMap getUserData(String id) {
		HashMap param = new HashMap();
		param.put("id", id);
		HashMap data= this.selectOne("MainQuery.GetUser", param);
		return data;
	}
	
	//사용자 정보 이메일로 조회
	public HashMap getUserDataForEmail(String email) {
		HashMap param = new HashMap();
		param.put("email", email);
		HashMap data= this.selectOne("MainQuery.getUserDataForEmail", param);
		return data;
	}
	
	//리뷰 리스트 점포번호로 조회
	public List<HashMap> getListReivewForResNum(int RES_NUM) {
		HashMap param = new HashMap();
		param.put("RES_NUM", RES_NUM);
		List<HashMap> data= this.selectList("MainQuery.getListReivewForResNum", param);
		return data;
	}
	
	//리뷰 번호로 리뷰 조회
	public HashMap getReivewForRvNum(int RV_NUM) {
		HashMap param = new HashMap();
		param.put("RV_NUM", RV_NUM);
		HashMap data= this.selectOne("MainQuery.getReivewForRvNum", param);
		return data;
	}
	
	//리뷰 번호로 리뷰 이미지 조회
	public List<HashMap> getListReivewPhoto(int RV_NUM) {
		HashMap param = new HashMap();
		param.put("RV_NUM", RV_NUM);
		List<HashMap> data= this.selectList("MainQuery.getListReivewPhoto", param);
		return data;
	}
	
	//이미지 번호로 리뷰 이미지 조회
	public HashMap getReivewPhoto(int RV_PHOTO_NUM) {
		HashMap param = new HashMap();
		param.put("RV_PHOTO_NUM", RV_PHOTO_NUM);
		HashMap data= this.selectOne("MainQuery.getReivewPhoto", param);
		return data;
	}
	
	//회원번호로 리뷰 조회
	public List<HashMap> getReivewForMbID(String MB_ID) {
		HashMap param = new HashMap();
		param.put("MB_ID", MB_ID);
		List<HashMap> data= this.selectList("MainQuery.getReivewForMbID", param);
		return data;
	}
	
	//회원 아이디로 회원정보 조회
	public HashMap getMemberInfo(String MB_ID) {
		HashMap param = new HashMap();
		param.put("MB_ID", MB_ID);
		HashMap data= this.selectOne("MainQuery.getMemberInfo", param);
		return data;
	}
	
	//회원번호로 회원정보 조회
	public HashMap getMemberInfoFor_MB_NUM(int MB_NUM) {
		HashMap param = new HashMap();
		param.put("MB_NUM", MB_NUM);
		HashMap data= this.selectOne("MainQuery.getMemberInfoFor_MB_NUM", param);
		return data;
	}
	
	//리뷰 작성
	public int InsertReview(int MB_NUM,int RES_NUM, int RV_STAR, String RV_CONTENT, String RV_COMMENT, int RV_DETAIL1, int RV_DETAIL2, int RV_DETAIL3, int RV_DETAIL4, String RES_NM, String RES_DISTRIC, String RES_MENU, String RES_ADDRS, String RES_PHOTO_URL) {
		HashMap param = new HashMap();
		param.put("MB_NUM", MB_NUM);
		param.put("RES_NUM", RES_NUM);
		param.put("RV_STAR", RV_STAR);
		param.put("RV_CONTENT", RV_CONTENT);
		param.put("RV_COMMENT", RV_COMMENT);
		param.put("RV_DETAIL1", RV_DETAIL1);		
		param.put("RV_DETAIL2", RV_DETAIL2);		
		param.put("RV_DETAIL3", RV_DETAIL3);
		param.put("RV_DETAIL4", RV_DETAIL4);
		param.put("RES_NM", RES_NM);
		param.put("RES_DISTRIC", RES_DISTRIC);
		param.put("RES_MENU", RES_MENU);
		param.put("RES_ADDRS", RES_ADDRS);
		param.put("RES_PHOTO_URL", RES_PHOTO_URL);
		int key = this.insert("MainQuery.InsertReview", param);		
		
		return Integer.parseInt(param.get("RV_NUM").toString());
	}
	
	//리뷰 수정
	public void UpdateReview(int MB_NUM,int RV_NUM, int RV_STAR, String RV_CONTENT, String RV_COMMENT, int RV_DETAIL1, int RV_DETAIL2, int RV_DETAIL3, int RV_DETAIL4, String RES_NM, String RES_DISTRIC, String RES_MENU, String RES_ADDRS, String RES_PHOTO_URL) {
		HashMap param = new HashMap();
		param.put("MB_NUM", MB_NUM);
		param.put("RV_NUM", RV_NUM);
		param.put("RV_STAR", RV_STAR);
		param.put("RV_CONTENT", RV_CONTENT);
		param.put("RV_COMMENT", RV_COMMENT);
		param.put("RV_DETAIL1", RV_DETAIL1);		
		param.put("RV_DETAIL2", RV_DETAIL2);		
		param.put("RV_DETAIL3", RV_DETAIL3);
		param.put("RV_DETAIL4", RV_DETAIL4);
		param.put("RES_NM", RES_NM);
		param.put("RES_DISTRIC", RES_DISTRIC);
		param.put("RES_MENU", RES_MENU);
		param.put("RES_ADDRS", RES_ADDRS);
		param.put("RES_PHOTO_URL", RES_PHOTO_URL);
		this.insert("MainQuery.UpdateReview", param);
	}
	
	//리뷰 수정(사용자)
	public void UpdateReview_user(int MB_NUM,int RV_NUM, int RV_STAR, String RV_CONTENT, String RV_COMMENT, int RV_DETAIL1, int RV_DETAIL2, int RV_DETAIL3, int RV_DETAIL4, String RES_NM, String RES_DISTRIC, String RES_MENU, String RES_ADDRS, String RES_PHOTO_URL) {
		HashMap param = new HashMap();
		param.put("MB_NUM", MB_NUM);
		param.put("RV_NUM", RV_NUM);
		param.put("RV_STAR", RV_STAR);
		param.put("RV_CONTENT", RV_CONTENT);
		param.put("RV_COMMENT", RV_COMMENT);
		param.put("RV_DETAIL1", RV_DETAIL1);		
		param.put("RV_DETAIL2", RV_DETAIL2);		
		param.put("RV_DETAIL3", RV_DETAIL3);
		param.put("RV_DETAIL4", RV_DETAIL4);
		param.put("RES_NM", RES_NM);
		param.put("RES_DISTRIC", RES_DISTRIC);
		param.put("RES_MENU", RES_MENU);
		param.put("RES_ADDRS", RES_ADDRS);
		param.put("RES_PHOTO_URL", RES_PHOTO_URL);
		this.insert("MainQuery.UpdateReview_user", param);
	}
	
	//리뷰 이미지 저장
	public int InsertReviewPhoto(int RV_NUM,String RV_PHOTO_ORIGIN) {
		HashMap param = new HashMap();
		param.put("RV_NUM", RV_NUM);
		param.put("RV_PHOTO_ORIGIN", RV_PHOTO_ORIGIN);						
		int key = this.insert("MainQuery.InsertReviewPhoto", param);		
		
		return Integer.parseInt(param.get("RV_PHOTO_NUM").toString());
	}
	
	//회원 가입
	public int InsertMember(String MB_ID,String MB_NICK, String MB_NAME, String MB_EMAIL, String MB_PW, String TYPE) {
		HashMap param = new HashMap();
		param.put("MB_ID", MB_ID);
		param.put("MB_NICK", MB_NICK);
		param.put("MB_NAME", MB_NAME);				
		param.put("MB_EMAIL", MB_EMAIL);				
		param.put("MB_PW", MB_PW);				
		param.put("TYPE", TYPE);				
		int key = this.insert("MainQuery.InsertMember", param);		
		
		return Integer.parseInt(param.get("MB_NUM").toString());
	}
	
	//회원정보 패스워드 수정
	public void UpdateMemberPW(String MB_ID,String MB_PW) {
		HashMap param = new HashMap();
		param.put("MB_ID", MB_ID);						
		param.put("MB_PW", MB_PW);
		this.update("MainQuery.UpdateMemberPW", param);
	}
	
	//회원정보 키워드 수정
	public int InsertMemberKeyWord(int MB_NUM,String MB_KW_NAME) {
		HashMap param = new HashMap();
		param.put("MB_NUM", MB_NUM);
		param.put("MB_KW_NAME", MB_KW_NAME);				
		int key = this.insert("MainQuery.InsertMemberKeyWord", param);		
		
		return Integer.parseInt(param.get("MB_KW_NUM").toString());
	}
	
	//회원정보 수정
	public void UpdateMember(int MB_NUM, String param_nick_name,String  param_name,String  pw_encode) {
		HashMap param = new HashMap();
		param.put("MB_NUM", MB_NUM);						
		param.put("param_nick_name", param_nick_name);
		param.put("param_name", param_name);
		param.put("pw_encode", pw_encode);
		
		this.update("MainQuery.UpdateMember", param);
	}
	
	//회원정보 수정(관리자용)
	public void UpdateMemberAdmin(int MB_NUM, String param_nick_name,String  param_name,String  param_email,String  pw_encode) {
		HashMap param = new HashMap();
		param.put("MB_NUM", MB_NUM);						
		param.put("param_nick_name", param_nick_name);
		param.put("param_name", param_name);
		param.put("param_email", param_email);
		param.put("pw_encode", pw_encode);
		
		this.update("MainQuery.UpdateMemberAdmin", param);
	}
	
	//회원정보 키워드 리셋
	public void ResetMemberKeyWord(int MB_NUM) {
		HashMap param = new HashMap();
		param.put("MB_NUM", MB_NUM);
		
		this.update("MainQuery.ResetMemberKeyWord", param);
	}
	
	//관리자 리뷰 데이터 조회
	public List<HashMap> admin_review_data(int startpage, int endpage, String search_string) {
		HashMap param = new HashMap();
		param.put("startpage", startpage);
		param.put("endpage", endpage);
		param.put("search_string", search_string);
		List<HashMap> data= this.selectList("MainQuery.admin_review_data", param);
		return data;
	}
	
	//관리자 회원정보 조회
	public List<HashMap> admin_member_data(int startpage, int endpage, String search_string) {
		HashMap param = new HashMap();
		param.put("startpage", startpage);
		param.put("endpage", endpage);
		param.put("search_string", search_string);
		List<HashMap> data= this.selectList("MainQuery.admin_member_data", param);
		return data;
	}
	
	//회원 삭제
	public void remove_member(int MB_NUM) {
		HashMap param = new HashMap();
		param.put("MB_NUM", MB_NUM);
		
		this.delete("MainQuery.remove_member", param);
	}
	
	//리뷰 삭제
	public void remove_reivew(int RV_NUM) {
		HashMap param = new HashMap();
		param.put("RV_NUM", RV_NUM);
		
		this.delete("MainQuery.remove_reivew", param);
	}
	
	//리뷰 삭제(사용자)
	public void remove_reivew_user(int RV_NUM, int MB_NUM) {
		HashMap param = new HashMap();
		param.put("RV_NUM", RV_NUM);
		param.put("MB_NUM", MB_NUM);
		
		this.delete("MainQuery.remove_reivew_user", param);
	}
	
	//리뷰 이미지 삭제
	public void remove_reivew_image(int RV_PHOTO_NUM) {
		HashMap param = new HashMap();
		param.put("RV_PHOTO_NUM", RV_PHOTO_NUM);
		
		this.delete("MainQuery.remove_reivew_image", param);
	}
	
	//리뷰 이미지 삭제(사용자)
	public void remove_reivew_image_user(int RV_PHOTO_NUM, int MB_NUM) {
		HashMap param = new HashMap();
		param.put("RV_PHOTO_NUM", RV_PHOTO_NUM);
		param.put("MB_NUM", MB_NUM);
		
		this.delete("MainQuery.remove_reivew_image_user", param);
	}
	
	
}

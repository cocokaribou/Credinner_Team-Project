<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko" class="h-100">
  <head>
    <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
  </head>  
  <body style='overflow-x:hidden'>    
  <header class="blog-header py-3">
    <div class="row flex-nowrap justify-content-between align-items-center">
      <div class="col-4 d-flex align-items-center" style='margin-left:10px' id='divAdmin'>
      </div>
      <div class="col-4 text-center">
        <a class="blog-header-logo text-dark" href="/">Credinner</a>
      </div>
      <div class="col-4 d-flex justify-content-end align-items-center" id='divUser'>        
        <a class="btn btn-sm btn-outline-secondary" href="/member/login" style='margin-right:10px'>로그인</a>        
        <a class="btn btn-sm btn-outline-secondary" href="/member/signup" style='margin-right:20px'>회원가입</a>
      </div>
    </div>
  </header> 
  
  
  <main role="main" class="container">
  	<jsp:include page="${contentPage}"></jsp:include>	
  </main>  
  
  <jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>   
  </body>
  
  <script>
  	var userName = '${UserName}';
  	var userType = '${UserType}';
  	var userNick = '${UserNick}';
  		
  </script>
  
  <script>
  	$(document).ready(function() {
  		if(userName != "anonymousUser") {  			 
  	  		$("#divUser").html("<a href='/user/member_info'><span style='margin-right:20px'>" + userNick + "님 환영합니다.</span></a>");
  	  	$("#divUser").html('<a class="btn btn-sm btn-outline-secondary" href="/member/logout" style="margin-right:10px">로그아웃</a>' +  $("#divUser").html())
  	  		if(userType == "1") {
  	  			$("#divAdmin").html('<a class="btn btn-sm btn-outline-secondary" href="/admin/review" style="margin-right:10px">리뷰 관리</a><a class="btn btn-sm btn-outline-secondary" href="/admin/member" style="margin-right:10px">회원 관리</a>')
  	  		}
  	  	}
  	});
  	
  	
  </script>
</html>
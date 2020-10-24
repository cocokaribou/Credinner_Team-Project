<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form class="form-signin" method="post" name="form"  id="loginform" action="/login_process">
  <!-- <img class="mb-4" src="/resources/assets/brand/bootstrap-solid.svg" alt="" width="72" height="72"> -->
  <img class="mb-4" src="/resources/img/baseline_perm_identity_black_48dp.png" alt="" width="72" height="72">
  <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
  <label for="inputEmail" class="sr-only">Email address</label>
  <input type="email" id="id" name='id' class="form-control" placeholder="Email address" required autofocus>
  <label for="inputPassword" class="sr-only">Password</label>
  <input type="pw" id="pw" name="pw" class="form-control" placeholder="Password" required>  
  <button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
  <div style='margin-top:10px'>
  	<div style='width:50%; text-align:left; float:left; font-size:8px;text-decoration:underline'>아이디 찾기</div>
  	<div style='width:50%; text-align:right; float:right; font-size:8px;text-decoration:underline'>비밀번호 찾기</div>  	
  </div>
  <div style='margin-top:10px'>
  	<div style='width:100%; text-align:center; ; font-size:8px;text-decoration:underline'>회원가입</div>  	  	
  </div>
  <p class="mt-5 mb-3 text-muted">&copy; 2020</p>
  <input type="hidden"
	name="${_csrf.parameterName}"
	value="${_csrf.token}"/>
</form>
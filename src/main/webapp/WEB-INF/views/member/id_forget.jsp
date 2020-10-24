<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form class="form-signin" method="post" name="form" >
  <!-- <img class="mb-4" src="/resources/assets/brand/bootstrap-solid.svg" alt="" width="72" height="72"> -->
  <img class="mb-4" src="/resources/img/baseline_perm_identity_black_48dp.png" alt="" width="72" height="72">
  <h1 class="h3 mb-3 font-weight-normal">아이디 찾기</h1>
  <label for="inputEmail" class="sr-only">Email address</label>
  <input type="email" id="email" name='"email"' class="form-control" placeholder="Email address" required autofocus>  
  <button class="btn btn-lg btn-primary btn-block" type="button" id="btnSendMail">인증번호 발송</button>
  <br />
  <label for="inputPassword" class="sr-only">인증번호</label>
  <input type="number" id="checkNum" name="checkNum" class="form-control" placeholder="인증번호" required>  
  <button class="btn btn-lg btn-primary btn-block" type="button" id="btnSearchID">아이디 찾기</button>  
  <div style='margin-top:10px'>
  	<div style='width:100%; text-align:center; ; font-size:8px;text-decoration:underline'>
  		<a href='/'>홈으로</a>
  	</div>  	  	
  </div>
  <p class="mt-5 mb-3 text-muted">&copy; 2020</p>  
</form>

<script>
	$(document).ready(function() {
		$("#btnSendMail").click(SendMail);
		$("#btnSearchID").click(SearchID);
	});
	
	function SendMail() {
		Ajax.AsyncPostService("/member/send_check_mail", {
			email : $("#email").val()
			}	
			,function(rtn) {
				Log(rtn);
				if(rtn.Value) {
					alert("인증번호 발송에 성공했습니다");
				}
				else {
					alert(rtn.Message);
				}
				
			}
			,function(e) {
				alert("인증번호 발송에 실패했습니다");
			}
		);	
	}
	
	function SearchID() {
		Ajax.AsyncPostService("/member/search_id_action", {
				number : $("#checkNum").val()
				,email : $("#email").val()
			}	
			,function(rtn) {
				Log(rtn);
				if(rtn.Value) {
					if(rtn.Data == 0) {
						alert("아이디가 메일로 발송되었습니다.");	
					}
					else {
						alert(rtn.Message);	
					}
				}
				else {
					alert("아이디 찾기에 실패했습니다");
				}	
				
			}
			,function(e) {
				alert("아이디 찾기에 실패했습니다");
			}
		);	
	}

</script>
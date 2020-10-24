<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="ko">
<head>
	<link href="/resources/assets/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Playfair+Display:700,900" rel="stylesheet">
	<script src="https://use.fontawesome.com/5ac93d4ca8.js"></script>
	<link href="/resources/css/jquery.loadingModal.css" rel="stylesheet">
	<style>
	  .container {
  		max-width: 960px;
		}

		.lh-condensed { line-height: 1.25; }
	  
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>
    <script src="/resources/js/jquery-3.5.1.js"></script>
	<script src="/resources/assets/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/js/jquery.form.js"></script>
	<script src="/resources/js/jquery.loadingModal.js"></script>
	<script src="/resources/js/util.js"></script>
	<script src="/resources/js/common.js"></script>
  </head>
  <body class="text-center">    
<div class="container">  
  <div class="py-5 text-center">
    <img class="mb-4" src="/resources/img/baseline_perm_identity_black_48dp.png" alt="" width="72" height="72">
    <h2>회원가입</h2>    
  </div>
  <div class="row">    
    <div class="col-md-12" style='margin-top:10px'>
        <div class="row">
          <div class="col-2"><h5>이름</h5></div>	
          <div class="col-10"><input type="text" class="form-control" id="param_name" /></div>         
        </div>        
        <br />
        <div class="row">
          <div class="col-2"><h5>닉네임</h5></div>	
          <div class="col-10"><input type="text" class="form-control" id="param_nick_name" /></div>         
        </div>          
        <br />
        <div class="row">
          <div class="col-2"><h5>아이디</h5></div>	
          <div class="col-8"><input type="text" class="form-control" id="param_id" /></div>
          <div class="col-2"><button class="btn btn-primary btn-block" type="button" id="btnIDCheck" >중복</button></div>         
        </div> 
        <br />
        <div class="row">
          <div class="col-2"><h5>PW</h5></div>	
          <div class="col-10"><input type="password" class="form-control" id="param_password" /></div>         
        </div>         
        <br />
        <div class="row">
          <div class="col-2"><h5>PW 확인</h5></div>	
          <div class="col-10"><input type="password" class="form-control" id="param_password_check" /></div>         
        </div>
        <br />
        <div class="row">
          <div class="col-2"><h5>이메일</h5></div>	
          <div class="col-3"><input type="text" class="form-control" id="param_email1" /></div>
          <div class="col-1"><i class="fa fa-at fa-2x"></i></div>
          <div class="col-3"><input type="text" class="form-control" id="param_email2" /></div>
          <div class="col-2"><button class="btn btn-primary btn-block" type="button" id="btnEmailCheck" >인증</button></div>         
        </div>
        <br />
        <div class="row">
          <div class="col-2"><h5>인증번호</h5></div>	
          <div class="col-10"><input type="password" class="form-control" id="param_email_check" /></div>         
        </div>         
        <br />
        <div class="row">
          <div class="col-3"><h5>내가 선호하는 식당은?</br/>(3개 선택)</h5></div>	
          <div class="col-9">
          	<div>
	          	<div class="form-check form-check-inline">
				  <input class="form-check-input" type="checkbox" id="param_check1" value="회식하기 좋은">
				  <label class="form-check-label" for="param_check1">회식하기 좋은</label>
				</div>
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="checkbox" id="param_check2" value="가족외식하기 좋은">
				  <label class="form-check-label" for="param_check2">가족외식하기 좋은</label>
				</div>
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="checkbox" id="param_check3" value="커플이 함께하기 좋은">
				  <label class="form-check-label" for="param_check3">커플이 함께하기 좋은</label>
				</div>
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="checkbox" id="param_check4" value="혼밥이 편한">
				  <label class="form-check-label" for="param_check4">혼밥이 편한</label>
				</div>
	          </div>
	          <div>
	          	<div class="form-check form-check-inline">
				  <input class="form-check-input" type="checkbox" id="param_check5" value="격식을 갖춘">
				  <label class="form-check-label" for="param_check5">격식을 갖춘</label>
				</div>
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="checkbox" id="param_check6" value="깔끔한">
				  <label class="form-check-label" for="param_check6">깔끔한</label>
				</div>
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="checkbox" id="param_check7" value="직원이 친절한">
				  <label class="form-check-label" for="param_check7">직원이 친절한</label>
				</div>
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="checkbox" id="param_check8" value="오래 앉아있기 좋은">
				  <label class="form-check-label" for="param_check8">오래 앉아있기 좋은</label>
				</div>
	          </div>  
	          <div>
	          	<div class="form-check form-check-inline">
				  <input class="form-check-input" type="checkbox" id="param_check9" value="가성비 맛집">
				  <label class="form-check-label" for="param_check9">가성비 맛집</label>
				</div>
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="checkbox" id="param_check10" value="오래된(전통적) 맛집">
				  <label class="form-check-label" for="param_check10">오래된(전통적) 맛집</label>
				</div>
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="checkbox" id="param_check11" value="캐쥬얼 다이닝">
				  <label class="form-check-label" for="param_check11">캐쥬얼 다이닝</label>
				</div>
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="checkbox" id="param_check12" value="모던 레스토랑">
				  <label class="form-check-label" for="param_check12">모던 레스토랑</label>
				</div>
	          </div>
          </div>        
        </div>
        <br />
        <div class="row">
        	<div class="col-12">
        		<button class="btn btn-primary btn-lg btn-block" type="button" id="btn_signup" >회원가입</button>
        	</div>
        </div>
        <div style='margin-top:10px'>
		  	<div style='width:100%; text-align:center; ; font-size:8px;text-decoration:underline'>
		  		<a href='/'>홈으로</a>
		  	</div>  	  	
		  </div>  
        
      
    </div>
  </div>
 </div>

<script>
	var is_id_check = false;
	var is_email_check = false;
	$(document).ready(function() {
		$("#btnIDCheck").click(id_check);
		$("#btnEmailCheck").click(email_check);
		$("#btn_signup").click(signup);	
	});
	
	function id_check () {
		var rtn = Ajax.SyncPostService("/member/id_check", {
			id : $("#param_id").val()
		});
		
		Log(rtn);
		if(rtn.Value) {
			alert("사용 가능한 아이디 입니다.");
			is_id_check = true;
		}
		else {
			alert(rtn.Message);
		}
	}
	
	function email_check() {
		Ajax.AsyncPostService("/member/send_check_mail", {
			email : $("#param_email1").val() + "@" + $("#param_email2").val()
			}	
			,function(rtn) {
				Log(rtn);
				if(rtn.Value) {
					alert("인증번호 발송에 성공했습니다");
					is_email_check = true;
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
	
	function signup() {
		if(!is_id_check) {
			alert("아이디 중복 검사를 해주세요.");
			return;
		}
		
		if(!is_email_check) {
			alert("이메일 인증을 해주세요.");
			return;
		}
		
		if($("#param_password").val() != $("#param_password_check").val()) {
			alert("패스워드가 틀립니다");
			return;
		}
		
		var param_check = "";
		
		var param_check_count = 0;
		for(var i=1;i <= 12; i++) {
			if($("#param_check" + i)[0].checked) {
				if(param_check != "") {
					param_check += ";";
				}
				param_check += $("#param_check" + i)[0].value;
				param_check_count++;
			}
		}
		
		if(param_check_count != 3) {
			alert("선호하는 식당 3개를 선택해 주세요");
			return;
		}
		
		
		var rtn = Ajax.SyncPostService("/member/signup_action", {
			param_name : $("#param_name").val()
			,param_nick_name : $("#param_nick_name").val()
			,param_id : $("#param_id").val()
			,param_password : $("#param_password").val()
			,param_email : $("#param_email1").val() + "@" + $("#param_email2").val()
			,param_email_check : $("#param_email_check").val()
			,param_check : param_check
		});
		
		Log(rtn);
		if(rtn.Value) {
			if(rtn.Data == 0) {
				alert("회원가입에 성공했습니다.");	
				document.location = "/member/login";
			}
			else {
				alert(rtn.Message);	
			}
		}
		else {
			alert("회원가입에 실패했습니다.");
		}		
	}

</script>
</body>
</html>
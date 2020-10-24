<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8"%> 
 <br />
 <div class="row"> 	 
    <div class="col-md-12" style='margin-top:10px'>
        <div class="row">
          <div class="col-3"><h5>이름</h5></div>	
          <div class="col-9"><input type="text" class="form-control" id="param_name" /></div>         
        </div>        
        <br />
        <div class="row">
          <div class="col-3"><h5>닉네임</h5></div>	
          <div class="col-9"><input type="text" class="form-control" id="param_nick_name" /></div>         
        </div>          
        <br />		     
        <div class="row">
          <div class="col-3"><h5>Email</h5></div>	
          <div class="col-9"><input type="text" class="form-control" id="param_email" /></div>         
        </div>
        <br />	            
        <div class="row">
          <div class="col-3"><h5>PW</h5></div>	
          <div class="col-9"><input type="password" class="form-control" id="param_password" /></div>         
        </div>         
        <br />
        <div class="row">
          <div class="col-3"><h5>PW 확인</h5></div>	
          <div class="col-9"><input type="password" class="form-control" id="param_password_check" /></div>         
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
        	<div class="col-12" style='text-align:center'>
        		<button class="btn btn-primary " type="button" id="btn_member_update" >수정</button>
        		<button class="btn btn-primary " type="button" id="btn_member_delete" >삭제</button>
        		<button class="btn btn-primary " type="button" id="btnBack" >목록으로</button>
        	</div>
        </div>
    </div>
 </div>
 
 <script> 	
var seq = null;
 $(document).ready(function() {
	var param = getUrlParams();
	seq = param.seq;
	$("#param_seq").val(seq);
	
	BindData();	
		
	$("#btn_member_update").click(Member_info_update);
	
	$("#btn_member_delete").click(function() {
		if(confirm("정말 삭제하시겠습니까?")) {
	 			var rtnReview = Ajax.SyncPostService("/admin/remove_member", {
	 				seq : seq			
	 			});
	 			
	 			if(rtnReview.Value) {
	 				document.location = '/admin/member';
	 			}
	 			else {
	 				alert("회원 삭제 실패");
	 			}
	 		}
	});
	 	
	$("#btnBack").click(function() {
 			window.history.back();
 	});
});
 
 function Member_info_update() {
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
		
		
		var rtn = Ajax.SyncPostService("/admin/member_info_update", {
			seq : seq
			,param_name : $("#param_name").val()
			,param_nick_name : $("#param_nick_name").val()			
			,param_password : $("#param_password").val()
			,param_email : $("#param_email").val()
			,param_check : param_check
		});
		
		Log(rtn);
		if(rtn.Value) {
			if(rtn.Data == 0) {
				alert("수정에 성공했습니다.");
			}
			else {
				alert(rtn.Message);	
			}
		}
		else {
			alert("수정에 실패했습니다.");
		}		
 }
	
 function BindData() { 		
		
		Ajax.AsyncPostService("/admin/member_info_data", {
			seq : seq
			 			
			}	
			,function(rtn) {
				Log(rtn);
				var t = rtn.Data;				
				$("#param_name").val(t.MB_NAME);
				$("#param_nick_name").val(t.MB_NICK);
				$("#param_email").val(t.MB_EMAIL);	
				var arr_kw = t.KW_NAME.split(",");
				
				for(var i = 1; i <= 12; i++) {
					for(var j =0 ; j < arr_kw.length ; j++) {
						if($("#param_check" + i)[0].value == arr_kw[j]) {
							$("#param_check" + i)[0].checked = true;
						}
					}
					 
				}
				
				View_Review();
			}
			,function(e) {
				alert("회원정보 조회에 실패했습니다.") 				
			}
		); 		
	}
 	
 </script>
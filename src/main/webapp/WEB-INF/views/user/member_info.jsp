<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8"%> 
 <br />
 <div class="row">
 	<div class="col-1"></div>
 	<div class="col-3"><h3 style='float:left; padding-top:30px'>${UserName}님</h3>
 		<div style='padding-top:10px' ><img class="mb-4" src="/resources/img/baseline_perm_identity_black_48dp.png" alt="" width="72" height="72"></div> 		
 	</div> 	
 	<div class="col-6">
 		<div class="row">
		  <div class="col-sm-6">
		    <div class="card">
		      <div class="card-body" style='height:100px; padding-top:30px; padding-left:20px; text-align:center'>
		        <h3 class="card-title" id="card-review" >리뷰수</h3>		        
		      </div>
		    </div>
		  </div>
		  <div class="col-sm-6">
		    <div class="card">
		      <div class="card-body" style='height:100px; padding-top:30px; padding-left:20px; text-align:center'>
		        <h3 class="card-title" id="card_rank">등급</h3>		        
		      </div>
		    </div>
		  </div>
		</div>
	</div> 	
 	<div class="col-2"></div>
 </div>
 <br />
 <div class="container-fluid">
  <div class="row">
    <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
      <div class="sidebar-sticky pt-3">
        <ul class="nav flex-column">
          <li class="nav-item">
            <a class="nav-link active" href="javascript:View_Review()">
              	리뷰 리스트
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="javascript:View_Member()">
              	회원정보수정
            </a>
          </li>          
        </ul>
      </div>
    </nav>

    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2" id="subTitle">리뷰리스트</h1>        
      </div>      
      <div id="div_reivewList">
      	<table class="table">
		  <thead>
		    <tr>
		      <th scope="col">가게이름</th>
		      <th scope="col">한줄평</th>
		      <th scope="col">일시</th>
		      <th scope="col">별점</th>
		    </tr>
		  </thead>
		  <tbody id='tbody_review'>		    
		  </tbody>
		</table>
      </div>
      <div id="div_memberInfo">
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
		          <div class="col-3"><h5>내가 선호하는</br/>식당은? (3개 선택)</h5></div>	
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
		        		<button class="btn btn-primary btn-lg btn-block" type="button" id="btn_member_update" >수정</button>
		        	</div>
		        </div>
		    </div>
		  </div>
      </div>
    </main>
  </div>
</div> 
 
 <script> 	
 $(document).ready(function() {
	 	BindData();	
	 	$("#btn_member_update").click(Member_info_update);
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
		
		
		var rtn = Ajax.SyncPostService("/user/member_info_update", {
			param_name : $("#param_name").val()
			,param_nick_name : $("#param_nick_name").val()			
			,param_password : $("#param_password").val()
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
 
 function View_Review() {
	 $("#subTitle").html("리뷰리스트");
	 $("#div_memberInfo").css("display" , "none");
	 $("#div_reivewList").css("display" , "block");
	 Ajax.AsyncPostService("/user/member_review_data", {
			
		}	
		,function(rtn) {			
			var data = rtn.Data;
			var html = "";
			for(i=0; i < data.length; i++) {
				var t = data[i];
				html += "<tr>";
				html += "<td><a href='/user/review_detail?seq=" + t.RV_NUM + "&star=" + t.RV_STAR + "' >" + t.RES_NM + "</a></td>";
				html += "<td>" + t.RV_COMMENT + "</td>";
				html += "<td>" + t.RV_DATE_STRING + "</td>";
				html += "<td>";
				for(j =0; j < t.RV_STAR; j++) {
					html += '<span class="fa fa-star star-checked"></span>'
				}
				for(j =0; j < 5 - t.RV_STAR; j++) {
					html += '<span class="fa fa-star"></span>'
				}
				html += "</td>";
				html += "</tr>"
				$("#tbody_review").html(html);
			}
			
		}
		,function(e) {
			alert("리뷰정보 조회에 실패했습니다.") 				
		}
	); 	
 }
 
 function View_Member() {
	 $("#subTitle").html("회원정보");
	 $("#div_reivewList").css("display" , "none");
	 $("#div_memberInfo").css("display" , "block");
 }
	
 function BindData(seq) { 		
		
		Ajax.AsyncPostService("/user/member_info_data", {
			 			
			}	
			,function(rtn) {
				Log(rtn);
				var t = rtn.Data;
				$("#card-review").html("리뷰수 : " + t.REVIEW_COUNT);				
				$("#card_rank").html("등급 : <img src='" + Get_Rank_Img(t.REVIEW_COUNT) + "' style='width:50px;' />");
				$("#param_name").val(t.MB_NAME);
				$("#param_nick_name").val(t.MB_NICK);				
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
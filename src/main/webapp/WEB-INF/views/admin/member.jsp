<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8"%> 
 <br />
 <div class="container-fluid">
  <div class="row">
    <main role="main" class="col-md-12 ml-sm-auto col-lg-12 px-md-4">
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2" id="subTitle">会員リスト</h1>        
      </div>      
      <div class="row" style="display:none">
      	<div class="col-1">검색어</div>
      	<div class="col-5"><input type="text" class="form-control" id="param_search_string" /></div>
      	<div class="col-2"><button class="btn btn-primary btn-block" type="button" id="btn_search" >검색</button></div>
      </div>
      <br />
      <div>
      	<table class="table">
		  <thead>
		    <tr>
		      <th scope="col">회원번호</th>
		      <th scope="col">아이디</th>
		      <th scope="col">닉네임</th>
		      <th scope="col">이메일</th>
		    </tr>
		  </thead>
		  <tbody id='tbody_member'>		    
		  </tbody>
		</table>
      </div>      
    </main>
  </div>
</div> 
 
 <script> 	
 var page = 1;
 $(document).ready(function() {
	 	BindData();
	 	
	 	$("#btn_search").click(Search);
	});
 
 function Search() {
	 page = 1;
	 BindData()
 }
 
 function BindData() {	 
	 Ajax.AsyncPostService("/admin/member_data", {
			search_string : $("#param_search_string").val()
			,page : page
		}	
		,function(rtn) {	
			Log(rtn);
			var data = rtn.Data;
			var html = "";
			for(i=0; i < data.length; i++) {
				var t = data[i];
				html += "<tr>";
				html += "<td><a href='/admin/member_detail?seq=" + t.MB_NUM +"' >" + t.MB_NUM + "</a></td>";
				html += "<td>" + t.MB_ID + "</td>";
 	 			html += "<td>" + t.MB_NICK + "</td>";
 	 			html += "<td>" + t.MB_EMAIL + "</td>";				
				html += "</tr>"
				if(page >1) {
					$("#tbody_member").html($("#tbody_member").html() +html);	
				}
				else {
					$("#tbody_member").html(html);
				}
				
				
			}
			
		}
		,function(e) {
			alert("회원정보 조회에 실패했습니다.") 				
		}
	); 	
 }
 
 function scrollAutoFnc(){ 	   
	   var scrollHeight = Math.max(document.documentElement.scrollHeight, document.body.scrollHeight); 	  
	  var scrollTop = Math.max(document.documentElement.scrollTop, document.body.scrollTop);
	  var clientHeight = document.documentElement.clientHeight;
	  if((scrollTop+clientHeight) == scrollHeight){
		 page++;
		 BindData();
	  }
	 }
	 window.onscroll=function(){
		scrollAutoFnc();
	 }
 
 	
 </script>
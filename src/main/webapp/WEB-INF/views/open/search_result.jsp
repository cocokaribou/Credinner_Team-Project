<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8"%>
<div class="row">
  	<div class='col-1'></div>
  	<div class='col-2'>
  		<img src='/resources/img/LOGO.png' style='width:220px;height:180px' />
  	</div>
  	<div class='col-7' style='padding-left:30p; padding-top:70px'>
  	<div class="row">
  		<div class="col-3">
  			<select id="selSearchType" class="form-control">
        	<option value="0">식당이름</option>
        	<option value="1">구 이름</option>
        </select>
  		</div>
  		<div class="col-7">
  			<input id="ipSearchString" type="text" class="form-control" placeholder="검색어를 입력해 주세요.">
  		</div>
  		<div class="col-2">
  			<button id="btnSearch" type="button" class="btn btn-block btn-primary">검색</button>
  		</div>
  	</div>	
  	<br />
  	<div class="row" id="div_address_keyword" style='display:none'>
  		<div class="col-2">
  		</div>
  		<div class="col-9" id="div_address_keyword_detail" style='margin-left:100px'>	  		
		</div>
  	</div>
	<div class='col-1'></div>	  	
  </div>
 </div> 
 <br />
 <div id="div_search_result"> 	
 </div>
 
 <script>
 	var page = 1;
 	$(document).ready(function() {
 		$("#btnSearch").click(Search_Reload)	
 		var param = getUrlParams();
 		
 		if(param.type == "0") {
 			$("#div_address_keyword").css("display", "block");
 			var address_list = '종로구,중구,용산구,성동구,광진구,동대문구,중랑구,성북구,강북구,도봉구,노원구,은평구,서대문구,마포구,양천구,강서구,구로구,금천구,영등포구,동작구,관악구,서초구,강남구,송파구,강동구';
 			var arr_address_list = address_list.split(',');
 			var html = '<div class="btn-group flex-wrap btn-group-toggle" data-toggle="buttons">'
 			for(i=0; i < arr_address_list.length; i++) {
 				var t = arr_address_list[i]; 				
 				if((i == 0 || i % 5 == 0) && i < 24) {
 					
 				}
 				if(!CheckNull(param.search_keyword) && decodeURIComponent(param.search_keyword) == t) { 					
 					html += '<label class="btn btn-light active"><input type="radio" name="radio_address" value="' + t + '" checked >' + t + '</label>' 					
 				}
 				else {
 					html += '<label class="btn btn-light"><input type="radio" name="radio_address" value="' + t + '" >' + t + '</label>'	
 				}
 				
 			} 			
 			html += "</div>";
 			$("#div_address_keyword_detail").html(html);
 		}
 		
 		
 		if(!CheckNull(param.type) && !CheckNull(param.search_string)) {
 			$("#selSearchType").val(param.type); 			
 			$("#ipSearchString").val(decodeURIComponent(param.search_string));
 			
 			Search() 		
 		} 		
 		
 		enterInput("#ipSearchString", Search_Reload);		
 		
 		
 		
	});
 	
 	function Get_Address_Keyword() {
 		var data = $("input[name=radio_address]:checked").val();
 		if(CheckNull(data)) {
 			return ""
 		}
 		else {
 			return data;	
 		}
 	}
 	
 	function Search_Reload() {
 		document.location = '/open/search_result?type=' + $("#selSearchType").val() + '&search_string=' + $("#ipSearchString").val()+ '&search_keyword=' + Get_Address_Keyword();
 	}
 	
 	function Search() {
 		var searchString = $("#ipSearchString").val();
 		var searchType = $("#selSearchType").val();
 		var search_keyword = Get_Address_Keyword();
 		
 		Ajax.AsyncPostService("/open/search_result_data", {
 			search_text : searchString
 			,type : searchType
 			,search_keyword : search_keyword
 			,page : page
 			}	
 			,function(rtn) {
 				Log(rtn);
 		 		
 		 		var html = "";
 		 		if(!rtn.Value) {
 		 			alert("검색에 실패했습니다.");
 		 			return;
 		 		}
 		 		if(page == 1 && rtn.Data.length == 0) { 		 			
 		 			$("#div_search_result").html('<div class="col-md-12" style="text-align:center"><h3>검색 결과가 없습니다.</h3></div>');
 		 		} 		 		
 		 		for(i=0; i < rtn.Data.length; i++) {
 		 			var t = rtn.Data[i]; 			
 		 			html += '<div class="col-md-12">';
 		 			html += '<div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">';
 		 			html += '<div class="col-auto d-none d-lg-block">';
 		 			html += '<img style="width:200px;height:250px" src="' + t.imageSrc + '" />'
 		 			//html += '<svg class="bd-placeholder-img" width="200" height="250" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder: Thumbnail"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>';
 		 			html += '</div>';
 		 		    html += '<div class="col p-4 d-flex flex-column position-static">'; 		 		    
 		 		    html += '<h3 class="mb-0"><a href="javascript:goReview(' + t.CRTFC_UPSO_MGT_SNO + ')" >' + t.UPSO_NM + '</a></h3>';
 		 		    if(!CheckNull(t.TEL_NO)) {
 		 		    	html += '<div class="mb-1 text-muted">' + t.TEL_NO + '</div>';	
 		 		    }
 		 		    if(!CheckNull(t.FOOD_MENU)) {
 				    	html += '<p class="card-text mb-auto">' + t.FOOD_MENU + '</p>';	
 				    }
 		 		    if(!CheckNull(t.CRTFC_GBN_NM)) {
 				    	html += '<p class="card-text mb-auto">' + t.CRTFC_GBN_NM + '</p>';	
 				    }
 		 		    if(!CheckNull(t.RDN_CODE_NM)) {
 				    	html += '<p class="card-text mb-auto">' + t.RDN_CODE_NM + '</p>';	
 				    }
 		 		    if(!CheckNull(t.RDN_DETAIL_ADDR)) {
 				    	html += '<p class="card-text mb-auto">' + t.RDN_DETAIL_ADDR + '</p>';	
 				    } 		 		    
 		 		    html += '</div>';
 		 		    html += '</div>';   
 		 		    html += '</div>';
 		 			
 		 		} 		 		
 		 		$('#div_search_result').html($('#div_search_result').html() + html);
 				
 			}
 			,function(e) {
 				alert("검색에 실패했습니다.") 				
 			}
 		); 		
 	}
 	
 	function goReview(seq) { 		
 		document.location = "/open/search_detail?seq=" + seq;
 	}
 	
 	function scrollAutoFnc(){ 	   
 	   var scrollHeight = Math.max(document.documentElement.scrollHeight, document.body.scrollHeight); 	  
 	  var scrollTop = Math.max(document.documentElement.scrollTop, document.body.scrollTop);
 	  var clientHeight = document.documentElement.clientHeight;
 	  if((scrollTop+clientHeight) == scrollHeight){
 		 page++;
 		 Search();
 	  }
 	 }
 	 window.onscroll=function(){
 		scrollAutoFnc();
 	 }
 	
 </script>
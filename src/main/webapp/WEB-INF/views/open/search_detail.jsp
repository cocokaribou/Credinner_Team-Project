<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8"%> 
 
 <div id="div_search_result" style='margin-top:10px'> 	
 </div>
 
 <div class="row"> 	
 	<div class="col-2" style="padding-left:20px"><button type="button" class="btn btn-warning" id="btnReviewCount" disabled>리뷰목록</button></div>
 </div>
 <br />
 <div id="div_reivew_list">
 	
 </div>
 
 <script> 	
 	var seq = null;
 	$(document).ready(function() {
 		var param = getUrlParams();
 		seq = param.seq;
 		BindData(param.seq); 		
	});
 	
 	function reviewCreate() { 		
 		document.location = "/user/review_create?seq=" + seq
 	}
 	
	function BindReviwData(seq) {
 		
 		Ajax.AsyncPostService("/open/search_result_review_data", {
 			seq : seq 			
 			}	
 			,function(rtn) {
 				Log(rtn);
 				if(rtn.Data == null) {
 					return;
 				}
 				
 				$("#btnReviewCount").html("리뷰목록 " + rtn.Data.length + "개");
 				var html = "";
 				for(i =0; i < rtn.Data.length; i++) {
 					var t = rtn.Data[i];
 					html += '<div class="row"><div class="col-3">'; 
 					html += "<img src='" + Get_Rank_Img(t.REVIEW_COUNT) + "' style='width:50px; float:left; margin-right:10px' />" 					
 					html += '<h3 style="margin-top:5px">' + t.MB_NICK + '</h3></div>';
 					html += '<div class="col-8">';
 					
 					var split_kw_name = t.KW_NAME.split(',');
 					for(j =0; j < split_kw_name.length; j++) {
 						html += '<button type="button" class="btn btn-outline-warning" style="margin-right:5px"disabled>' + split_kw_name[j] + '</button>'; 						
 					}
 					html += '</div>';
 					html += '</div>';
 					
 					html += '<div class="row">';
 					html += '<div class="col-12"><a href="/open/review_detail?seq=' + t.RV_NUM + '"><div class="alert alert-info" role="alert" style="height:50px"><div style="float:left">' + t.RV_COMMENT + '</div></a>'
 					html += '<div style="float:right">'
 					for(j =0; j < t.RV_STAR; j++) {
 						html += '<span class="fa fa-star star-checked"></span>'
 					}
 					for(j =0; j < 5 - t.RV_STAR; j++) {
 						html += '<span class="fa fa-star"></span>'
 					}
 					html += '</div>'
 					html += '</div>';
 				
 				}
 				
 				$("#div_reivew_list").html(html);
 				
 			}
 			,function(e) {
 				alert("리뷰 검색에 실패했습니다.") 				
 			}
 		); 		
 		
	}
 	
 	function BindData(seq) { 		
 		
 		Ajax.AsyncPostService("/open/search_result_data", {
 			seq : seq 			
 			}	
 			,function(rtn) {
 				Log(rtn);
 		 		
 		 		var html = "";
 		 		for(i=0; i < rtn.Data.length; i++) {
 		 			var t = rtn.Data[i]; 			
 		 			html += '<div class="col-md-12">';
 		 			html += '<div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">';
 		 			html += '<div class="col-auto d-none d-lg-block">';
 		 			html += '<img style="width:200px;height:250px" src="' + t.imageSrc + '" />'
 		 			//html += '<svg class="bd-placeholder-img" width="200" height="250" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder: Thumbnail"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>';
 		 			html += '</div>';
 		 		    html += '<div class="col p-4 d-flex flex-column position-static">'; 		 		    
 		 		    html += '<h3 class="mb-0">' + t.UPSO_NM + ' <button id="btnReviewCreate" type="button" class="btn btn-warning" style="width:100px">리뷰적기!</button></h3>';
 		 		    //html += '';
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
 		 		
 		 		$("#btnReviewCreate").click(reviewCreate);
 		 		
 		 		BindReviwData(seq);
 				
 			}
 			,function(e) {
 				alert("검색에 실패했습니다.") 				
 			}
 		); 		
 	}
 	
 </script>
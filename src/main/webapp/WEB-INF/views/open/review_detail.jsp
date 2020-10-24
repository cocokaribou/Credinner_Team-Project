<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8"%>
 
 <br />
 <div id="div_reivew_list">
 	
 </div>
 <br />
 <div class="row">
 	<div class="col-5"></div>
 	<div class="col-2"><button type="button" class="btn btn-secondary" id='btnBack'>목록으로</button></div>
 	<div class="col-5"></div>
 </div>
 <br />
 
 <script> 	
 	var seq = null;
 	$(document).ready(function() {
 		var param = getUrlParams();
 		seq = param.seq;
 		BindData(param.seq); 	
 		$("#btnBack").click(back)
	});
 	
 	function back() {
 		window.history.back()
 	}
 	
	function BindData(seq) {
 		
 		Ajax.AsyncPostService("/open/review_detail_data", {
 			seq : seq 			
 			}	
 			,function(rtn) {
 				Log(rtn); 				
 				var t = rtn.Data;
 				var html = '<div class="row"><h2>' + t.RES_NM + '</h2></div>';
 				
				html += '<br /><div class="row"><div class="col-3">';
				html += "<img src='" + Get_Rank_Img(t.REVIEW_COUNT) + "' style='width:50px; float:left; margin-right:10px' />"
				html += '<h3 style="margin-top:5px">' + t.MB_NICK + '</h3></div>';
				html += '<div class="col-12">';
				
				var split_kw_name = t.KW_NAME.split(',');
				for(j =0; j < split_kw_name.length; j++) {
					html += '<button type="button" class="btn btn-outline-warning" style="margin-right:5px"disabled>' + split_kw_name[j] + '</button>'; 						
				}
				html += '</div>';
				html += '</div>';
				
				html += '<br /><div class="row">';
				html += '<div class="col-5"><h4>' + t.RV_COMMENT + '<h4></div>'
				html += '<div class="col-5">'
				for(j =0; j < t.RV_STAR; j++) {
					html += '<span class="fa fa-star fa-3x star-checked"></span>'
				}
				for(j =0; j < 5 - t.RV_STAR; j++) {
					html += '<span class="fa fa-star fa-3x"></span>'
				}
				html += '</div>'
				html += '</div>';
				
				try
				{
					var rtn = Ajax.SyncPostService("/open/review_image_list", {
						seq : t.RV_NUM
					});
					
					html += '<br /><div class="row">';
					
					for(j =0; j < rtn.Data.length; j++) {
						var g = rtn.Data[j];
						html+="<div class='col-2' ><img src='/open/viewImage?seq=" + g.RV_PHOTO_NUM  +"' style='width:200px' class='img-responsive img-thumbnail' /></div>"
					}			
					
					html += '</div>';
				}
				catch(eee) {
					html += '<br /><div class="row">';
					html+="<div class='col-2' ><img src='/resources/img/no_img.gif' style='width:200px' class='img-responsive img-thumbnail' /></div>"					
					html += '</div>';
				}
				
				
				html += '<br /><div class="row" ><div class="col-12">';
				html += '<div class="card"><div class="card-body">';
				html += t.RV_CONTENT
				html += '</div></div></div></div>';
				
				html += '<br /><div class="row" >';
				
				html += '<div class="col-6"><h5>Q. 직원들은 친절했나요?</h5>';
				if(t.RV_DETAIL1 == 0) {					
					html += "<h5>A. 너무 너무 친절했어요"
				}				
				else if(t.RV_DETAIL1 == 1) {
					html += "<h5>A. 보통이에요"
				}				
				else if(t.RV_DETAIL1 == 2) {
					html += "<h5>A. 불친절했어요"
				}				
				html += '</div>';
				
				html += '<div class="col-6"><h5>Q. 가게위생은 청결했나요?</h5>';
				if(t.RV_DETAIL2 == 0) {					
					html += "<h5>A. 아주 깔끔해요"
				}				
				else if(t.RV_DETAIL2 == 1) {
					html += "<h5>A. 보통이에요"
				}				
				else if(t.RV_DETAIL2 == 2) {
					html += "<h5>A. 비위생적이에요"
				}				
				html += '</div>';
				
				html += '</div>';
				
				html += '<br /><div class="row" >';
				
				html += '<div class="col-6"><h5>Q. 가격은 적당했나요?</h5>';
				if(t.RV_DETAIL3 == 0) {					
					html += "<h5>A. 가성비 최고"
				}				
				else if(t.RV_DETAIL3 == 1) {
					html += "<h5>A. 보통이에요"
				}				
				else if(t.RV_DETAIL3 == 2) {
					html += "<h5>A. 살짝 비쌌어요"
				}				
				html += '</div>';
				
				html += '<div class="col-6"><h5>Q. 전체적으로 만족했나요?</h5>';
				if(t.RV_DETAIL4 == 0) {					
					html += "<h5>A. 만족! 또방문하고싶어요"
				}				
				else if(t.RV_DETAIL4 == 1) {
					html += "<h5>A. 보통이에요"
				}				
				else if(t.RV_DETAIL4 == 2) {
					html += "<h5>A. 재방문 의사 없어요"
				}				
				html += '</div>';
				
				html += '</div>';
 				
 				$("#div_reivew_list").html(html);
 				
 			}
 			,function(e) {
 				alert("리뷰 검색에 실패했습니다.") 				
 			}
 		); 		
 		
	} 	
 	
 </script>
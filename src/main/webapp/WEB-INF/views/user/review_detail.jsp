<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8"%> 
 
 <div id="div_search_result" style='margin-top:10px'> 	
 </div>
 
 <form id="review_form" action="/user/review_update_action" method="POST" enctype="multipart/form-data" > 
 <input type="hidden" id="param_seq" name="param_seq" />
 <input type="hidden" id="param_res_nm" name="param_res_nm" />
 <input type="hidden" id="param_res_distric" name="param_res_distric" />
 <input type="hidden" id="param_res_menu" name="param_res_menu" />
 <input type="hidden" id="param_res_addrs" name="param_res_addrs" />
 <input type="hidden" id="param_res_photo_url" name="param_res_photo_url" />
 <div class="row">
  	<div class="col-1"></div>
 	<div class="col-2" style='text-align:center'><br/><h4>평점</h4></div>
 	<div class="col-8" id="div_star">
 		<input type="number" name="param_rating" id="param_rating" value="${star}" class="rating text-warning" />
 	</div>
 </div>
 <br />
 <div class="row">
 	<div class="col-1"></div>
 	<div class="col-2" style='text-align:center'><br/><br/><br/><br/><h4>리뷰</br/>(자유기입란)</h4></div>
 	<div class="col-8">
 		<textarea class="form-control" name="param_memo_long" id="param_memo_long" rows="10"></textarea>
 	</div>
 </div>
 <br />
 <div class="row">
 	<div class="col-1"></div>
 	<div class="col-2" style='text-align:center'><br/><br/><br/><br/><h4>리뷰상세 평가</h4></div>
 	<div class="col-8">
 		<div class="row">
 			<div class="col-6">
 				<h5>Q. 직원들은 친절했나요?</h5>
 				<div class="form-check">
				  <input class="form-check-input" type="radio" name="param_radio_q_1" value="0">
				  <label class="form-check-label" for="param_radio_q_1">
				    너무 너무 친절했어요
				  </label>
				</div>
				<div class="form-check">
				  <input class="form-check-input" type="radio" name="param_radio_q_1" value="1">
				  <label class="form-check-label" for="param_radio_q_1">
				    보통이에요
				  </label>
				</div>
				<div class="form-check">
				  <input class="form-check-input" type="radio" name="param_radio_q_1" value="2">
				  <label class="form-check-label" for="param_radio_q_1">
				   불친절했어요
				  </label>
				</div>
 			</div>
 			<div class="col-6">
 				<h5>Q. 가게위생은 청결했나요?</h5>
 				<div class="form-check">
				  <input class="form-check-input" type="radio" name="param_radio_q_2" value="0">
				  <label class="form-check-label" for="param_radio_q_2">
				    아주 깔끔해요
				  </label>
				</div>
				<div class="form-check">
				  <input class="form-check-input" type="radio" name="param_radio_q_2" value="1">
				  <label class="form-check-label" for="param_radio_q_2">
				    보통이에요
				  </label>
				</div>
				<div class="form-check">
				  <input class="form-check-input" type="radio" name="param_radio_q_2" value="2">
				  <label class="form-check-label" for="param_radio_q_2">
				    비위생적이에요
				  </label>
				</div>
 			</div>
 		</div>
 		<br />
 		<div class="row">
 			<div class="col-6">
 				<h5>Q. 가격은 적당했나요?</h5>
 				<div class="form-check">
				  <input class="form-check-input" type="radio" name="param_radio_q_3" value="0">
				  <label class="form-check-label" for="param_radio_q_3">
				    가성비 최고
				  </label>
				</div>
				<div class="form-check">
				  <input class="form-check-input" type="radio" name="param_radio_q_3" value="1">
				  <label class="form-check-label" for="param_radio_q_3">
				    보통이에요
				  </label>
				</div>
				<div class="form-check">
				  <input class="form-check-input" type="radio" name="param_radio_q_3" value="2">
				  <label class="form-check-label" for="param_radio_q_3">
				    살짝 비쌌어요
				  </label>
				</div>
 			</div> 			
 			<div class="col-6">
 				<h5>Q. 전체적으로 만족했나요?</h5>
 				<div class="form-check">
				  <input class="form-check-input" type="radio" name="param_radio_q_4" value="0">
				  <label class="form-check-label" for="param_radio_q_4">
				    만족! 또방문하고싶어요
				  </label>
				</div>
				<div class="form-check">
				  <input class="form-check-input" type="radio" name="param_radio_q_4" value="1">
				  <label class="form-check-label" for="param_radio_q_4">
				    보통이에요
				  </label>
				</div>
				<div class="form-check">
				  <input class="form-check-input" type="radio" name="param_radio_q_4" value="2">
				  <label class="form-check-label" for="param_radio_q_4">
				    재방문 의사 없어요
				  </label>
				</div>
 			</div>
 		</div>
 	</div>
 </div>
 <br />
 <div class="row">
 	<div class="col-1"></div>
 	<div class="col-2" style='text-align:center'><h4>기존사진 삭제</h4></div>
 	<div class="col-8" id="div_image">	
    	
 	</div>
 </div>
 <br />
 <div class="row">
 	<div class="col-1"></div>
 	<div class="col-2" style='text-align:center'><h4>사진첨부</h4></div>
 	<div class="col-8">		
    	<input type="file" class="form-control-file" name="param_file" id="param_file" multiple>
 	</div>
 </div>
 <br />
 <div class="row">
 	<div class="col-1"></div>
 	<div class="col-2" style='text-align:center'><h4>한줄평</h4></div>
 	<div class="col-8">
    	<input type="text" class="form-control-file" name="param_memo" id="param_memo" multiple>
 	</div>
 </div>
 </form>
 <br /> 
 <div class="row">
 	<div class="col-12" style='text-align:center'>
 		<button type="button" id="btnSave" class="btn btn-primary">저장</button>
 		<button type="button" id="btnDelete" class="btn btn-primary">삭제</button>
 		<button type="button" id="btnBack" class="btn btn-primary">목록으로</button>
 	</div> 	
 </div>
 <br />
 
 <script> 	
 	var seq = null;
 	$(document).ready(function() {
 		var param = getUrlParams();
 		seq = param.seq;
 		$("#param_seq").val(seq);
 		BindData(param.seq);
 		
 		$("#btnBack").click(function() {
 			window.history.back();
 		});
 		
 		$("#btnSave").click(function() {
 			 $('#review_form').submit();
 		 });
 		
 		$("#btnDelete").click(function() {
 			if(confirm("정말 삭제하시겠습니까?")) {
 	 			var rtnReview = Ajax.SyncPostService("/user/remove_reivew", {
 	 				seq : seq			
 	 			});
 	 			
 	 			if(rtnReview.Value) {
 	 				document.location = '/user/member_info';
 	 			}
 	 			else {
 	 				alert("리뷰 삭제 실패");
 	 			}
 	 		}
		 });
 		
 		$('#review_form').ajaxForm({	     
 		   cache: false,
 		   dataType:"json",	       
 	       beforeSubmit: function (data, frm, opt) {
 	    	   if($("#param_rating").val() == "" || $("#param_rating").val() == "0")
 	    	   {
 	    		   alert("평점을 입력해 주세요.");
 	    		   return false;
 	    	   }	 
 	    	   
 	    	   if($("#param_radio_q_1").val() == "" || $("#param_radio_q_2").val() == "" || $("#param_radio_q_3").val() == "" || $("#param_radio_q_4").val() == "")
	    	   {
	    		   alert("리뷰상세 평가를 입력해 주세요.");
	    		   return false;
	    	   }	 
 	    	   
 	    	  if($("#param_memo").val() == "")
	    	   {
	    		   alert("한줄평을 입력해 주세요.");
	    		   return false;
	    	   }	 
 	           
 	    	   Loding_Start();
 	           return true;
 	       },
 	       //success
 	       success: function(data, statusText){
 	    	   Loding_Stop();
 	           Log(data);
 	           if(data.Value)
 	           {
 	        	   alert("리뷰 저장완료");	   
 	        	  BindImageData(seq);
 	        	 $("#param_file").val("")
 	           }
 	           else {
 	        	   if(data.Message == null) {
 	        		   alert("리뷰 저장에 실패했습니다.")
 	        	   } 
 	        	   else {
 	        		   alert(data.Message);   
 	        	   }
 	        		 
 	        	   
 	           }
 	       },
 	       //ajax error
 	       error: function(e){
 	    	   Loding_Stop();
 	    	   alert("리뷰 저장에 실패했습니다.");
 	           Log(e);
 	       }                               
 	    });
 		 		
	});
 	
 	function reviewCreate() {
 		
 	}
 	
 	function check_radio(name, data) {
 		for(var i = 0; i < 3; i++) {
 			if($("input[name=" + name + "]")[i].value == data) {
 				$("input[name=" + name + "]")[i].checked = true;
			}
			 
		}
 	}
 	
 	function BindImageData(seq) {
 		try
		{
			var rtn = Ajax.SyncPostService("/user/review_image_list", {
				seq : seq
			});
			Log(rtn);
			$("#div_image").html("");
			var html = "";
			html += '<div class="row">';
			
			for(j =0; j < rtn.Data.length; j++) {
				var g = rtn.Data[j];
				html+="<div class='col-2' ><a href='javascript:remove_image(" + g.RV_PHOTO_NUM  + ")'><img src='/open/viewImage?seq=" + g.RV_PHOTO_NUM  +"' style='width:200px' class='img-responsive img-thumbnail' /></a></div>"
			}			
			
			html += '</div>';
			
			$("#div_image").html(html);
		}
 		catch(eee)
 		{
 			Log(eee);
 		}
 		
 		
 	}
 	
 	function remove_image(RV_PHOTO_NUM) {
 		if(confirm("정말 삭제하시겠습니까?")) {
 			var rtnReview = Ajax.SyncPostService("/user/remove_reivew_image", {
 				RV_PHOTO_NUM : RV_PHOTO_NUM			
 			});
 			
 			if(rtnReview.Value) {
 				BindImageData(seq);
 			}
 			else {
 				alert("리뷰 이미지 삭제 실패");
 			}
 		}
 	}
 	
 	function BindData(seq) { 	
 		var rtnReview = Ajax.SyncPostService("/user/review_data_detail", {
			seq : seq			
		});
 		Log(rtnReview)
 		var review_data = rtnReview.Data;
 		
 		$("#param_rating").val(review_data.RV_STAR);
 		$("#param_rating").click();
 		
 		$("#param_memo_long").val(review_data.RV_CONTENT);
 		$("#param_memo").val(review_data.RV_COMMENT);
 		
 		check_radio("param_radio_q_1", review_data.RV_DETAIL1);
 		check_radio("param_radio_q_2", review_data.RV_DETAIL2);
 		check_radio("param_radio_q_3", review_data.RV_DETAIL3);
 		check_radio("param_radio_q_4", review_data.RV_DETAIL4);
 		
 		BindImageData(seq);
 		
 		Ajax.AsyncPostService("/open/search_result_data", {
 			seq : review_data.RES_NUM 			
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
 		 			$("#param_res_photo_url").val(t.imageSrc);
 		 			//html += '<svg class="bd-placeholder-img" width="200" height="250" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder: Thumbnail"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text></svg>';
 		 			html += '</div>';
 		 		    html += '<div class="col p-4 d-flex flex-column position-static">'; 		 		    
 		 		    html += '<h3 class="mb-0">' + t.UPSO_NM + '</h3>';
 		 		  	$("#param_res_nm").val(t.UPSO_NM);
 		 		    //html += '';
 		 		    if(!CheckNull(t.TEL_NO)) {
 		 		    	html += '<div class="mb-1 text-muted">' + t.TEL_NO + '</div>';	
 		 		    }
 		 		    if(!CheckNull(t.FOOD_MENU)) {
 				    	html += '<p class="card-text mb-auto">' + t.FOOD_MENU + '</p>';
 				    	$("#param_res_menu").val(t.FOOD_MENU);
 				    }
 		 		    if(!CheckNull(t.CRTFC_GBN_NM)) {
 				    	html += '<p class="card-text mb-auto">' + t.CRTFC_GBN_NM + '</p>';	
 				    }
 		 		    if(!CheckNull(t.RDN_CODE_NM)) {
 				    	html += '<p class="card-text mb-auto">' + t.RDN_CODE_NM + '</p>';
 				    	$("#param_res_distric").val(t.RDN_CODE_NM);
 				    }
 		 		    if(!CheckNull(t.RDN_DETAIL_ADDR)) {
 				    	html += '<p class="card-text mb-auto">' + t.RDN_DETAIL_ADDR + '</p>';
 				    	$("#param_res_addrs").val(t.RDN_DETAIL_ADDR);
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
 	
 </script>
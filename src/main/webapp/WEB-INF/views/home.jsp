<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" pageEncoding="UTF-8"%>

<style>
.tooltiptext {
	  visibility: hidden;
	  width: 180px;
	  background-color: #ffffff;
	  font-color: #323232;
	  font-size: 17pt;
	  text-align: center;
	  border-radius: 6px;
	  padding: 5px 0;
	  
	  position: absolute;
	  z-index: 1;
	}

	.col-3:hover .tooltiptext {
	  visibility: visible;
	}
	
	.col-4:hover .tooltiptext{
	  visibility: visible;
	}
</style>

<div class="row">  	
  	<div class='col-2'>
  		<img src='/resources/img/LOGO.png' style='width:220px;height:180px' />
  	</div>
  	<div class='col-9' style='padding-left:50px'>
  		<br />
  		<br />
  		<h4 style='text-align:center'>信頼できるグルメサイト、クレディナ―</h4> 
  		<div class="md-form active-cyan active-cyan-2 mb-3">
  		<div class="col-xs-10 col-xs-offset-1">
	    <form onsubmit="return false;" role="search">
	    <div class="input-group">
	    	<input class="form-control_layoutTop form-control" placeholder="お店の名前を入力してください." name="srch-term" id="ed-srch-term" type="text">
	    	<div class="input-group-btn">
	    	<button type="button" id="searchLayoutBtn">
	       	検索</button>
	    	</div>
	    </div>
	    </form>
	    </div>
	  	</div>
	</div>
	  	
  </div>
<div class="row" id="div_home_search_back" style='margin-left:20px; margin-right:60px'>
  
  <div class="col-xl-9 mx-auto" style="padding-top:100px">
    <h1 class="mb-5" style='text-align:center;color:#323232; font-family: "BIZ UDMincho Medium"; font-weight:bold;'>信頼できるレストランを探すなら<br>クレディナ―</h1>
  </div>
  <div class="col-md-10 col-lg-8 col-xl-7 mx-auto" style='padding-bottom:100px'>
    <form onsubmit="return false;">
      <div class="form-row">
        <div class="col-12 col-md-3">
          <select id="home_search_type" class="form-control form-control-lg">
          	<option value="0">お店の名前</option>
          	<option value="1">区名</option>
          </select>
        </div>
        <div class="col-12 col-md-7 mb-2 mb-md-0">
          <input id="home_search_text" type="text" class="form-control form-control-lg" placeholder="お店の名前、区名で検索">
        </div>
        <div class="col-12 col-md-2">
          <button type="button" id='btnMainBottom' class="btn btn-block btn-lg btn-primary">検索</button>
        </div>
      </div>
    </form>
  </div>
</div>
<br /> 
<div class="row">
	<div class="col-1"></div>
	<div class="col-5"><img src='/resources/img/main_sub1.png' /></div>
	<div class="col-5"><img src='/resources/img/main_sub2.png' /></div>
	<div class="col-1"></div>
</div>
<br />

<h4 style='text-align:left'>ソウル特別市の食堂衛生認証とは？</h4> 
<div class="row">
	<div class="col-1"></div>
	<div class="col-3" style='text-align:center'><img src='/resources/img/main_1.png' style='width:200px' /><span class="tooltiptext">衛生管理認証</span></div>
	<div class="col-4" style='text-align:center; margin-top:70px'><img src='/resources/img/main_2.jpg' style='width:300px' /><span class="tooltiptext">減塩飲食堂</span></div>
	<div class="col-3" style='text-align:center; margin-top:30px'><img src='/resources/img/main_3.jpg' style='width:200px' /><span class="tooltiptext">ソウル市安心飲食店</span></div>
	<div class="col-1"></div>
</div>

<script>
$(document).ready(function() {
	$("#searchLayoutBtn").click(searchLayout);
	$("#btnMainBottom").click(searchBottomBtn);
	
	enterInput("#ed-srch-term", searchLayout);
	enterInput("#home_search_text", searchBottomBtn);

});

function searchLayout() {
	GoSearchResult(0, $("#ed-srch-term").val());
}

function searchBottomBtn() {
	GoSearchResult($("#home_search_type").val(), $("#home_search_text").val());
}

function GoSearchResult(type, string) {
	document.location = '/open/search_result?type=' + type + '&search_string=' + string;
}

</script>
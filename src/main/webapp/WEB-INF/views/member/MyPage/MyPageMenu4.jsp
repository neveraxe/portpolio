<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.80.0">
    <meta name="theme-color" content="#563d7c">
    <title>Klipsch Homepage</title>
	<style>
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
    
<%@include file="/WEB-INF/views/common/config.jsp" %>
<script type="text/javascript" src="/js/member/edit.js"></script>   
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

  </head>
  <body>
    
<!-- nav.jsp -->
<%@include file="/WEB-INF/views/common/nav.jsp" %>

	<div class="row">
	<div class="col-2">
		
		<%@ include file="/WEB-INF/views/common/category_list.jsp" %>

	</div>	
		

	<div class="col-10">
    	<%-- Main content --%>
			
				<div class="container" style="width: 100%; min-width: 900px; background-color: white; font-size: 14px;" >
					<!-- Nav tabs -->
					  <ul class="nav nav-tabs">
					    <li class="nav-item">
					      <a class="nav-link" data-toggle="tab" href="#home" id="homea">회원정보</a>
					    </li>
					    <li class="nav-item">
					      <a class="nav-link" data-toggle="tab" href="#menu1" id="menu1a">주문내역/배송조회</a>
					    </li>
					    <li class="nav-item">
					      <a class="nav-link" data-toggle="tab" href="#menu2" id="menu2a">1:1문의게시판</a>
					    </li>
					    <li class="nav-item">
					      <a class="nav-link" data-toggle="tab" href="#menu3" id="menu3a">나의 상품후기</a>
					    </li>
					    <li class="nav-item">
					      <a class="nav-link active" data-toggle="tab" href="#menu4" id="menu4a">나의 상품문의</a>
					    </li>
					    <li class="nav-item">
					      <a class="nav-link" data-toggle="tab" href="#menu5" id="menu5a">최근 본 상품목록</a>
					    </li>
					  </ul>
					
					  <!-- Tab panes -->
					  <div class="tab-content">
					    <div id="home" class="container tab-pane"><br>
					     
						</div>    
					
					    
					    <div id="menu1" class="container tab-pane"><br>
					     
					    </div>
					    
					    <div id="menu2" class="container tab-pane"><br>
					     
						</div>

					     <div id="menu3" class="container tab-pane"><br>
					     
					    </div>
					     <div id="menu4" class="container tab-pane active"><br>
					      <h3>나의 상품문의</h3>
					      <p>해당 내용이 없습니다.</p>
					    </div>
					     <div id="menu5" class="container tab-pane"><br>
					     
					    </div>
				</div>
				

			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
 </div>

<!-- /.container -->

<script>
	$(document).ready(function(){
		

		$("#homea").on("click", function(e){
			e.preventDefault();
			location.href = "/member/MyPage/MyPageHome";
		});
		
		$("#menu1a").on("click", function(e){
			e.preventDefault();
			location.href = "/member/MyPage/MyPageMenu1";
		});
		
		$("#menu2a").on("click", function(e){
			e.preventDefault();
			location.href = "/member/MyPage/MyPageMenu2";
		});
		
		$("#menu3a").on("click", function(e){
			e.preventDefault();
			location.href = "/member/MyPage/MyPageMenu3";
		});
		
		$("#menu4a").on("click", function(e){
			e.preventDefault();
			location.href = "/member/MyPage/MyPageMenu4";
		});
		
		$("#menu5a").on("click", function(e){
			e.preventDefault();
			location.href = "/member/MyPage/MyPageMenu5";
		});
	
	});
		
</script>
  </body>
</html>
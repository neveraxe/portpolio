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

  </head>
  <body>
    
<!-- nav.jsp -->
<%@include file="/WEB-INF/views/common/nav.jsp" %>

<main role="main" class="container">

  <div class="wrapper">
    <%-- Main content --%>
			<section class="content container-fluid">
			<div class="row">
  	<div class="col-lg-12">
  		<h1 class="page-header">상품문의</h1>
  	</div>
  </div>
        
    <div class="row">
  	<div class="col-lg-12">
  		<div class="panel panel-default">
  			<div class="panel-heading">
  			</div>
  			
  			<div class="panel-body">
  			<!-- 글수정 -->
  			<form role="form" id="myForm" method="post" action="/board/modify">
  			  <div class="form-group">
			    <label for="exampleFormControlInput1">번호</label>
			    <input type="text" name="brd_num_pk" value='<c:out value="${list.brd_num_pk }" />' class="form-control" readonly>
			  </div>
			  <div class="form-group">
			    <label for="exampleFormControlInput1">Title</label>
			    <!-- name을 title로 하면 BoardVO 클래스와 파라미터가 동일해 값이 전송된다. -->
			    <input type="text" name="brd_title" value='<c:out value="${list.brd_title }" />' class="form-control">
			  </div>
			  <div class="form-group">
			    <label for="exampleFormControlTextarea1">content</label>
			    <textarea name="brd_content" class="form-control" rows="3"><c:out value="${list.brd_content }" /></textarea>
			  </div>
			  <div class="form-group">
			    <label for="exampleFormControlInput1">Writer</label>
			    <input type="text" name="mb_id_pk" value='<c:out value="${list.mb_id_pk }" />' class="form-control" readonly>
			  </div>
			  
			  <!-- 원래 리스트페이지 상태로 가기위한 정보 -->
			  <input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum }" />
			  <input type="hidden" id="amount" name="amount" value="${cri.amount }" />
			  
			  <!-- 페이징, 검색관련 정보 -->
			  <input type="hidden" id="type" value='<c:out value="${cri.type }" />'>
			  <input type="hidden" id="keyword" value='<c:out value="${cri.keyword }" />'>
			  
			  
			</form>
			  <div class="form-group">
			  <!-- type을 submit으로 하면안된다. 파라미터를 넘겨야 하기 때문에 -->
			    <button id="btnModify" type="button" class="btn btn-primary">Modify</button>
			    <button id="btnRemove" type="button" class="btn btn-danger">Delete</button>
			    <button id="btnList" type="button" class="btn btn-info">List</button>
			  </div>
			
  			</div>
  		</div>
  	</div>
  </div>
			</section>
			<!-- /.content -->
		
    

	<form id="actionForm" action="/board/list" method="get">
		<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }" />'>
		<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount }" />'>
		<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type }" />'>
		<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword }" />'>
	</form>
		</div>
		<!-- /.content-wrapper -->
 

</main><!-- /.container -->
<script>

  $(document).ready(function(){

	
	var result = '${result}';
	if(result == 'modify'){
		alert('수정되었습니다.');
	}else if(result == 'remove'){
		alert('제거되었습니다.');
	}

	var searchForm = $("#searchForm");

	var actionForm = $("#actionForm");
	

	// [prev] 1 2 3 4 5 [next]
	$(".page-item a").on("click", function(e){
		e.preventDefault();

		console.log("click");
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();

	});
	var form = $("#myForm");
	
	// 리스트 버튼 클릭
	$("#btnList").click(function(){
		//location.href = "/board/list"; // 자바스크립트의 페이지 이동(주소)
		form.attr("action","/board/list").submit(); // 폼정보를 가지고 넘길때
	});
	
	// 수정버튼 클릭
	$("#btnModify").click(function(){

	
		// <form>태그정보를 submit 작업
		// 리스트, 수정에 따라서 action주소가 다르기 때문에 그에 따른 주소작업을 설정한다.
		form.attr("action","/board/modify").submit();
		//form.submit(); 메서드 체이닝
	});
	
	$("#btnRemove").click(function(){
		form.attr("action","/board/remove").submit();
		//form.submit(); 메서드 체이닝
	});

  });
  	
  	

  
</script>
      
  </body>
</html>
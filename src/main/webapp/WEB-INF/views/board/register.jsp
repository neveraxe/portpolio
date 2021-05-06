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
  			<!-- 글쓰기 -->
  			<form role="form" method="post" action="/board/register">
			  <div class="form-group">
			    <label for="exampleFormControlInput1">Title</label>
			    <!-- name을 title로 하면 BoardVO 클래스와 파라미터가 동일해 값이 전송된다. -->
			    <input type="text" name="brd_title" class="form-control" id="brd_title" placeholder="제목입력">
			  </div>
			  <div class="form-group">
			    <label for="exampleFormControlTextarea1">content</label>
			    <textarea name="brd_content" class="form-control" id="brd_content" rows="3" placeholder="내용입력"></textarea>
			  </div>
			  <div class="form-group">
			    <label for="exampleFormControlInput1">ID</label>
			    <input type="text" name="mb_id_pk" class="form-control" id="mb_id_pk" readonly value="<c:out value="${sessionScope.loginStatus.mb_id_pk}"/>">
			  </div>
			  <div class="form-group">
			    <button type="submit" class="btn btn-primary">Submit</button>
			  </div>
			</form>
				
			
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
	// 제목 클릭시 다음 주소로 이동.
	$(".move").on("click", function(e){
		// 링크시 쿼리스트링정보(페이징,검색)를 다음주소로 보내는 작업
		// form태그 사용

		// <a href=""></a>, <input type="submit">
		e.preventDefault(); // 태그가 가지고있는 기본이벤트 성격을 취소.
		actionForm.append("<input type='hidden' name='brd_num_pk' value='" + $(this).attr("href") + "'>");
		actionForm.attr("action", "/board/get");
		actionForm.submit();
	});

	// [prev] 1 2 3 4 5 [next]
	$(".page-item a").on("click", function(e){
		e.preventDefault();

		console.log("click");
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();

	});
	



  });


  
</script>
      
  </body>
</html>
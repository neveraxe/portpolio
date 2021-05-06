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
					      <a class="nav-link active" data-toggle="tab" href="#menu2" id="menu2a">1:1문의게시판</a>
					    </li>
					    <li class="nav-item">
					      <a class="nav-link" data-toggle="tab" href="#menu3" id="menu3a">나의 상품후기</a>
					    </li>
					    <li class="nav-item">
					      <a class="nav-link" data-toggle="tab" href="#menu4" id="menu4a">나의 상품문의</a>
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
					    
					    <div id="menu2" class="container tab-pane active"><br>
					      <h3>1:1문의 게시판</h3>
					      <div class="row">
					    	<div class="col-lg-10">
					    		<div class="panel panel-default">
					    			<div class="panel-heading text-right">
					    			 <button id="regBtn" type="button" class="btn btn-primary pull-right">글쓰기</button>
					    			</div>
					    			
					    			<div class="panel-body">
					    			 <!-- 리스트 -->
					    			 <table class="table table-striped">
									  <thead>
									    <tr>
									      <th scope="col">번호</th>
									      <th scope="col">제목</th>
									      <th scope="col">내용</th>
									      <th scope="col">작성자</th>
									      <th scope="col">작성일</th>
									    </tr>
									  </thead>
									  <tbody>
									  <c:forEach items="${list }" var="brdVO">
									    <tr>
									      <th scope="row"><c:out value="${brdVO.brd_num_pk }"></c:out></th>
									      <td><a class="move" href="${brdVO.brd_num_pk }"><c:out value="${brdVO.brd_title }" /></a></td>
									      <td><c:out value="${brdVO.brd_content }"></c:out></td>
									      <td><c:out value="${brdVO.mb_id_pk }"></c:out></td>
									      <td><fmt:formatDate pattern="yyyy-MM-dd" value="${brdVO.brd_date_reg }"/></td>
									    </tr>
									   </c:forEach>
									   </tbody>
									</table>
					    			</div>
					    		</div>
					    	</div>
					    </div>
					    
					    
					    <div class="row">
					    	<div class="col-lg-10">
					    		<form id="searchForm" action="/member/MyPage/MyPageMenu2" method="get">
					    			<select name="type" id="type">
					    				<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected':'' }" />>--</option>
					    				<option value="T" <c:out value="${pageMaker.cri.type == 'T' ? 'selected':'' }" />>제목</option>
					    				<option value="C" <c:out value="${pageMaker.cri.type == 'C' ? 'selected':'' }" />>내용</option>
					    				<option value="W" <c:out value="${pageMaker.cri.type == 'W' ? 'selected':'' }" />>작성자</option>
					    				<option value="TC" <c:out value="${pageMaker.cri.type == 'TC' ? 'selected':'' }" />>제목 or 내용</option>
					    				<option value="TW" <c:out value="${pageMaker.cri.type == 'TW' ? 'selected':'' }" />>제목 or 작성자</option>
					    				<option value="TCW" <c:out value="${pageMaker.cri.type == 'TCW' ? 'selected':'' }" />>제목 or 내용 or 작성자</option>
					    			</select>
					    			<input type="text" name="keyword" value="${pageMaker.cri.keyword }">
					    			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
					    			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
					    			<button id="btnSearch" class="btn btn-primary" type="button">Search</button>
					    		</form>
					    	</div>
					    </div>
						
						
					    <div class="row">
					    	<div class="col-lg-10">
					    	<!-- 페이징 표시 -->
					    			<div class="panel-footer">
					    			   <ul class="pagination">
					    			   <c:if test="${pageMaker.prev }">
										    <li class="page-item">
										      <a href="${pageMaker.startPage - 1 }" class="page-link" tabindex="-1">Prev</a>
										    </li>
									    </c:if>
									    <c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage}" var="num">
									    	<li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : ''}" name="menu2">
									    		<a href="${num}" class="page-link">${num }</a>
									    	</li>
									    </c:forEach>
									    <c:if test="${pageMaker.next }">
										    <li class="page-item">
										      <a href="${pageMaker.endPage + 1 }" class="page-link">Next</a>
										    </li>
									    </c:if>
									  </ul>
							
							    				<hr>
							    				${pageMaker }
					    			</div>
					    	</div>
					    </div>
						
						
						<form id="actionForm" action="/member/MyPage/MyPageMenu2" method="get">
							<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }" />'>
							<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount }" />'>
							<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type }" />'>
							<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword }" />'>
						</form>
						
					</div>

					     <div id="menu3" class="container tab-pane"><br>
					      
					    </div>
					     <div id="menu4" class="container tab-pane"><br>
					      
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
		
		
		var actionForm = $("#actionForm");

			$(".page-item a").on("click", function(e){
				e.preventDefault();
				console.log("2메뉴");
				
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionForm.submit();
			});
			
			$(".move").on("click", function(e){
				// 링크시 쿼리스트링정보(페이징,검색)를 다음주소로 보내는 작업
				// form태그 사용

				// <a href=""></a>, <input type="submit">
				e.preventDefault(); // 태그가 가지고있는 기본이벤트 성격을 취소.
				actionForm.append("<input type='hidden' name='brd_num_pk' value='" + $(this).attr("href") + "'>");
				actionForm.attr("action", "/board/get");
				actionForm.submit();
			});
			
			$("#searchForm #btnSearch").on("click", function(e){
				if(!searchForm.find("option:selected").val()){
					alert("검색종류를 선택하세요");
					return false;
				}

				if(!searchForm.find("input[name='keyword']").val()){
					alert("검색어를 선택하세요");
					return false;
				}
				
				// 검색시 페이지 1로 시작해야 한다.
				// 리스트에서 변경된 페이지번호가 사용하여 검색결과가 안나올수 있다.
				// 검색버튼이 클릭했을때 첫번째 페이지로
				searchForm.find("input[name='pageNum']").val("1");

				e.preventDefault();

				searchForm.submit();

			});
			
			
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
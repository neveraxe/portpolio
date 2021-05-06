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
					      <a class="nav-link active" data-toggle="tab" href="#menu1" id="menu1a">주문내역/배송조회</a>
					    </li>
					    <li class="nav-item">
					      <a class="nav-link" data-toggle="tab" href="#menu2" id="menu2a">1:1문의게시판</a>
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
					
					    
					    <div id="menu1" class="container tab-pane active"><br>
					     <div class="row">
								<div class="col-lg-12">
									<form id="searchForm" action="/member/MyPage/MyPageMenu1" method="get">
										<select name="type" id="type">
											<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected':'' }" />>--</option>
											<option value="N" <c:out value="${pageMaker.cri.type == 'N' ? 'selected':'' }" />>상품명</option>
											<option value="D" <c:out value="${pageMaker.cri.type == 'D' ? 'selected':'' }" />>상품설명</option>
											<option value="C" <c:out value="${pageMaker.cri.type == 'C' ? 'selected':'' }" />>제조사</option>
											<option value="ND" <c:out value="${pageMaker.cri.type == 'ND' ? 'selected':'' }" />>상품명 or 상품설명</option>
											<option value="NC" <c:out value="${pageMaker.cri.type == 'NC' ? 'selected':'' }" />>상품명 or 제조사</option>
											<option value="NDC" <c:out value="${pageMaker.cri.type == 'NDC' ? 'selected':'' }" />>상품명 or 내용 or 제조사</option>
										</select>
										<input type="text" name="keyword" value="${pageMaker.cri.keyword }">
										<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
										<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
										<button id="btnSearch" type="button" class="btn btn-primary">검색</button>
									</form>
								</div>
							</div>
							
							
								<div class="row">
							    	<div class="col-lg-12">
							    		<div class="panel panel-default">
							    			<div class="panel-heading text-right">
							    			 
							    			</div>
							    			
							    			<div class="panel-body">
							    			 <!-- 리스트 -->
							    			 <table class="table table-striped">
											  <thead>
											    <tr>
											      <th scope="col">선택</th>
											      <th scope="col">번호</th>
											      <th scope="col">주문일시</th>
											      <th scope="col">주문번호</th>
											      <th scope="col">주문자</th>
											      <th scope="col">받는분</th>
											      <th scope="col">금액</th>
											      <th scope="col">처리상태</th>
											    </tr>
											  </thead>
											  <tbody>
											  <c:forEach items="${order_list }" var="orderVO" varStatus="status">
											    <tr>
											      <th scope="row"><input type="checkbox" value="${orderVO.odr_code_pk }"></th>
											      <td>
												     ${(cri.pageNum - 1) * cri.amount + status.count}
											      </td>
											      <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${orderVO.odr_date }"/></td>
											      <td>${orderVO.odr_code_pk}
											      	<button type="button" name="btn_order_detail" data-odr_code="${orderVO.odr_code_pk}" class="btn btn-link">Order Detail</button>
											      </td>
											      <td>${orderVO.mb_id_pk }</td>
											      <td>${orderVO.odr_name }</td>
											      <td><fmt:formatNumber type="currency" value="${orderVO.odr_total_price }"/></td>      
											      <td>
											      	처리상태
											      </td>
											    </tr>
											   </c:forEach>
											   </tbody>
											</table>
							    			</div>
							    		</div>
							    	</div>
							    </div>
							
							<div class="row">
						    	<div class="col-lg-12">
						    	<!-- 페이징 표시 -->
						    			<div class="panel-footer">
						    			   <ul class="pagination">
						    			   <c:if test="${pageMaker.prev }">
											    <li class="page-item">
											      <a href="${pageMaker.startPage - 1 }" class="page-link" href="#" tabindex="-1">Prev</a>
											    </li>
										    </c:if>
										    <c:forEach begin="${pageMaker.startPage }" end="${ pageMaker.endPage}" var="num">
										    	<li class="page-item ${pageMaker.cri.pageNum == num ? "active" : ""}">
										    		<a href="${num }" class="page-link" href="#">${num }</a>
										    	</li>
										    </c:forEach>
										    <c:if test="${pageMaker.next }">
											    <li class="page-item">
											      <a href="${pageMaker.endPage + 1 }" class="page-link" href="#">Next</a>
											    </li>
										    </c:if>
										  </ul>
								
								    				<hr>
								    				${pageMaker }
						    			</div>
						    	</div>
						    </div>	
						    
						    <!-- 페이지 번호 클릭시, 수정, 삭제 클릭시 상품코드정보 추가 등등 공통으로 사용되어야 함 -->
						    <form id="actionForm" action="/member/MyPage/MyPageMenu1" method="get">
								<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }" />'>
								<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount }" />'>
								<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type }" />'>
								<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword }" />'>
							</form>
					    </div>
					    
					    <div id="menu2" class="container tab-pane"><br>
					      
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
			$("button[name='btn_order_detail']").on("click", function(){
				console.log("상품 상세");

				// 파라미터 : 주문번호 

				var odr_code_pk = $(this).attr("data-odr_code");

				console.log(odr_code_pk);

				var current_tr = $(this).parents("tr");

				// ajax 호출 작업: url? 컨트롤러 매핑주소 생성하고, postman 테스트
				
				$.ajax({
					url: "/member/MyPage/order_detail_list",
					type: "get",
					data: {odr_code_pk : odr_code_pk}, // 파라미터명 : 변수 // name : value
					dataType: "json",
					success: function(data){
						
						//alert(data.length);
						// 함수호출 subCategoryList
						orderDetailView(data, current_tr, $("#orderDetailTemplate"));
					}
				});
	
			});
		});
	</script>

<script>
	var orderDetailView = function(orderDetailData, orderDetailTarget, orderDetailTemplate){
		var detailTemplate = Handlebars.compile(orderDetailTemplate.html());
		var details = detailTemplate(orderDetailData);

		//console.log(details);

		$(".dy_order_detail").remove(); // 기존 상세출력된 태그 제거
		orderDetailTarget.after(details); 
	}
</script>
<!-- 주문 상세 데이터와 결합될 태그를 구성 -->
<script id="orderDetailTemplate" type="text/x-handlebars-template">
	
	<tr class="dy_order_detail"><td colspan="8">주문상세내역</td></tr>
	<tr class="dy_order_detail">
		<th>선택</th><th>번호</th><th>상품명</th><th>수량</th><th>상품가격</th><th>소계</th><th colspan="2">비고</th>
	</tr>
	{{#each .}}
	<tr class="dy_order_detail">
		<td>선택</td>
		<td>번호</td>
		<td>
			<img src="/member/displayFile?fileName={{pdt_img}}"> 
			{{pdt_name}}
		</td>
		<td>{{odr_amount}}</td>
		<td>{{odr_price}}</td>
		<td>{{total_price odr_amount odr_price}}</td>
		<td colspan="2">비고</td>
	</tr>
	{{/each}}

</script>


<script>
//핸들바의 사용자 정의 함수
Handlebars.registerHelper("total_price", function(odr_amount, odr_price){
	
	return odr_amount * odr_price;
});


</script>
<script>
	$(document).ready(function(){
		
		
		var actionForm = $("#actionForm");

			$(".page-item a").on("click", function(e){
				e.preventDefault();
				console.log("2메뉴");
				
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionForm.submit();
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
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
    
<%@ include file= "/WEB-INF/views/common/config.jsp" %>
<script>
	// 메인의 status(상태) MemberController의 rttr과 연결되어있음
	var message = '${status}';
	
	if(message == 'loginSuccess'){
		alert('로그인이 되었습니다.');
	}else if(message == 'loginIDFail'){
		alert('아이디가 틀렸습니다.');
	}else if(message == 'loginPWFail'){
		alert('비밀번호가 틀렸습니다.');
	}else if(message == 'logout'){
		alert('로그아웃 되었습니다.');
	}else if(message == 'modifySuccess'){
		alert('회원수정이 되었습니다.');
	}else if(message == 'Delete_user_success'){
		alert('회원탈퇴가 완료 되었습니다.');
	}
	
</script>

  </head>
  <body>
    
<!-- nav.jsp -->
<%@ include file="/WEB-INF/views/common/nav.jsp" %>

<main role="main" class="container-fluid">
	  
  	<div class="row">
    	<div class="col-2">
			<%@ include file="/WEB-INF/views/common/category_list.jsp" %>
		</div>
			
    	<div class="col-10">
    	<div class="col-8">
    		<div class="card-deck mb-3 text-center">
    		<c:forEach items="${productVOList}" var="productVO">
		    	<div class="card mb-4 shadow-sm">
		      		<div class="card-body">
		      		<a href="/product/product_read?pdt_num_pk=${productVO.pdt_num_pk }">
		        	<img src="/product/displayFile?fileName=${productVO.pdt_img }" /></a><br>
		        	<input type="hidden" name="pdt_num_pk" value="${productVO.pdt_num_pk }">
		        	<span><c:out value="${productVO.pdt_name }"/></span><br>
		        	<span><fmt:formatNumber type="currency" value="${productVO.pdt_price }"/>원</span><br>
		        	<input type="number" style="width:50px" name="odr_amount" value="1"> 개<br>
		        	<button type="button" name="btn_direct_buy" class="btn btn-link">즉시구매</button>
		        	<button type="button" name="btn_cart_add" class="btn btn-link">장바구니</button>
		      	</div>
		    </div>
		  	</c:forEach>
			<form id="order_direct_form" method="get" action="/order/order">
				<input type="hidden" name="type" value="1">

			</form>
		  </div>
  		</div>
  	</div>	
  	</div>

</main><!-- /.container -->
</body>
	<script>
		
		$(document).ready(function(){
			$("button[name='btn_direct_buy']").on("click", function(){
				
				console.log("즉시구매");

				// 상품코드, 구매수량

				var pdt_num_pk = $(this).parent().find("input[name='pdt_num_pk']").val(); // <input type='hidden' name='pdt_num_pk'
				var odr_amount = $(this).parent().find("input[name='odr_amount']").val(); // <input type="number" style="width:50px" name="odr_amount" 

				console.log("상품코드: " + pdt_num_pk);
				console.log("상품수량: " + odr_amount);

				

				var order_direct_form = $("#order_direct_form");
				order_direct_form.append("<input type='hidden' name='pdt_num_pk' value='" + pdt_num_pk + "'>");
				order_direct_form.append("<input type='hidden' name='odr_amount' value='" + odr_amount + "'>");				
				
				order_direct_form.submit();

			});
			
			$("button[name='btn_cart_add']").on("click", function(){
				console.log("장바구니");

				/*
				장바구니 코드: 시퀀스, 로그인ID(세션)
				상품코드, 수량

				*/

				var pdt_num_pk = $(this).parent().find("input[name='pdt_num_pk']").val();
				var pdt_amount = $(this).parent().find("input[name='odr_amount']").val();
				
				console.log("상품코드: " + pdt_num_pk);
				console.log("상품수량: " + pdt_amount);

				$.ajax({
					url: "/cart/add",
					type: "post",
					data: {pdt_num_pk : pdt_num_pk, pdt_amount : pdt_amount},
					dataType: "text",
					success: function(data){
						if(data == "SUCCESS"){
							if(confirm("장바구니가 추가되었습니다. \n 확인 하시겠습니까?")){
								location.href="/cart/cart_list";
							}
						}else if(data == "LoginRequired"){
							alert("로그인이 안되어 있습니다.")
							location.href="/member/login";
						}
					}
				});

			});
		});

	</script>
</html>

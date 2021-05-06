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
    		<div class="panel panel-default">
	  			<div class="panel-heading text-right">
	  			 <button id="btn_cart_check_del" type="button" class="btn btn-primary pull-right">선택삭제</button>
	  			</div>
	  			
	  			<div class="panel-body">
	  			 <!-- 리스트 -->
	  			 <table class="table table-striped">
			  <thead>
			    <tr>
			      <th scope="col"><input type="checkbox" id="check_all"></th>
			      <th scope="col">번호</th>
			      <th scope="col">사진</th>
			      <th scope="col">상품명</th>
			      <th scope="col">수량</th>
			      <th scope="col">금액</th>
			      <th scope="col">배송비</th>
			      <th scope="col">취소</th>
			    </tr>
			  </thead>
			  <tbody>
			  <%--데이타가 존재하지 않는 경우 --%>
			  <c:if test="${empty cartVOList }">
			  <tr>
			  	<td colspan="8">
			  		<p style="color:red;">장바구니가 비워있습니다.</p>
			  	</td>
			  </tr>
			  </c:if>
			  
			  <c:set var="i" value="1"></c:set>
			  <c:set var="price" value="0"></c:set>
			  <c:forEach items="${cartVOList }" var="cartList">
			  	<c:set var="price" value="${ cartList.pdt_price * cartList.cart_amount}"></c:set>
			    <tr>
			      <td>
			      	<input type="checkbox" name="cart_check" value="${cartList.cart_code_pk }" >
			      </td>
			      <th scope="row">${i }</th>
			      <td>
			      	<img src="/cart/displayFile?fileName=${cartList.pdt_img}">
			      </td>
			      <td>
			      	<c:out value="${cartList.pdt_name }"></c:out>
			      </td>
			      <td>
			      	<input type="number" value="<c:out value="${cartList.cart_amount }"></c:out>" name="cart_amount" />
			      	<button type="button" name="btnCartEdit" data-cart_code="${cartList.cart_code_pk }" class="btn btn-link">Edit</button>
				  <td data-price="${price}">
			      	<fmt:formatNumber type="currency" value="${price}"></fmt:formatNumber>
			      </td>
			      <td>[기본배송조건]</td>
			      <td>
			      	<button type="button" name="btnCartDel" data-cart_code="${cartList.cart_code_pk }" class="btn btn-link">Delete</button>
			      </td>
			    </tr>
			    <c:set var="i" value="${i+1 }"></c:set>
			    <c:set var="sum" value="${sum + price }"></c:set>
			   </c:forEach>
			   </tbody>
			</table>
	  			</div>
	  			
	  		<div id="sum_price" class="panel-body">
	  			<table class="table table-striped">
	  				<tr>
	  					<td>총 금액</td>
	  					<td data-sum="${sum}"><fmt:formatNumber type="currency" value="${sum}"></fmt:formatNumber></td>
	  				</tr>
	  			 </table>
	  		</div>
	  		
	  		<div id="sum_price" class="panel-footer">
	  			<table class="table table-striped">
	  				<tr>
	  					<td>
	  						<button name="btn_cart_clear" type="button" class="btn btn-link">장바구니 비우기</button>
	  						<button name="btn_order" type="button" class="btn btn-link">전체상품 주문</button>
	  						<button name="btn_chk_order" type="button" class="btn btn-link">선택상품 주문</button>
	  					</td>
	  				</tr>
	  			</table>	
	  		</div>
	  		
	  		</div>
  	</div>
  </div>

</main><!-- /.container -->
<script>
  $(document).ready(function(){

	// 작업1>장바구니 개별삭제
    $("button[name='btnCartDel']").on("click", function(){
      console.log("장바구니 삭제");

      var cart_code_pk = $(this).attr("data-cart_code");
      console.log(cart_code_pk);

      var cart_tr = $(this).parents("tr");

      var cart_price = cart_tr.find("td[data-price]").attr("data-price");

      console.log(cart_price);

      var sum_price = $("div #sum_price td[data-sum]").attr("data-sum");

      console.log(sum_price);

      $.ajax({
			url: '/cart/delete',
			type: 'post',
			dataType: 'text',  
			data: {cart_code_pk : cart_code_pk},  
			success : function(data){
				if(data == 'SUCCESS'){
					
		         	alert("장바구니 상품:" + cart_code_pk + "삭제되었습니다.");
					location.href = "/cart/cart_list"; // db에서 장바구니 삭제처리 콘트롤러에서 걸기(개별 삭제 완료)

		          	// 장바구니 행을 화면에서 제거하는 구문
		          	cart_tr.remove();
                	
					// 합계 계산
					sum_price = parseInt(sum_price) - parseInt(cart_price)
					$("div #sum_price td[data-sum]").attr("data-sum", sum_price); // 삭제 시 값이 변경이 지속적으로 이루어져야함
                	$("div #sum_price td[data-sum]").text(sum_price);

		        }	
				
			}
		});

    });

	// 수량 텍스트박스 변경이벤트 작업
	$("input[name='cart_amount']").on("change", function(){
		console.log("수량변경");
	});

	// 작업2>수량변경Edit 수정버튼 클릭시
	// btnCartEdit
	$("button[name='btnCartEdit']").on("click", function(){
		console.log("수량 버튼변경");

		// 주요 파라미터 : 장바구니코드, 변경된 수량
		// AJAX로 직접처리
		var cart_code_pk = $(this).attr("data-cart_code");
		var cart_amount = $(this).parent().find("input[name='cart_amount']").val();
		//var qty = $(this).siblings("input[name='cart_amount']").val(); // button의 형제(siblings) input
		console.log(cart_code_pk);
		console.log(cart_amount);
		
		var cart_tr = $(this).parents("tr"); // tr의 부모에서 input을 찾아내려온것
		//cart_tr.find("input[name='cart_amount']")


		$.ajax({ // 개별적으로 처리 컨트롤러 수정
			url: '/cart/modify',
			type: 'post',
			dataType: 'text',  
			data: {cart_code_pk : cart_code_pk, cart_amount : cart_amount},  
			success : function(data){
				if(data == 'SUCCESS'){
					
		         	alert("장바구니 상품 수량이 " + cart_amount + "개로 변경되었습니다.");
					location.href = "/cart/cart_list"; // db에서 상품수량 수정하는 update문 걸기
		        }	
				
			}
		});

	});

	// 작업3>장바구니 비우기 버튼
 	$("button[name='btn_cart_clear']").on("click", function(){
		 
 		var cart_table = $(this).parents("table");
 		
 		var cart_code_pk = $(this).attr("data-cart_code"); 
 		
 		$.ajax({
			url: '/cart/deleteAll',
			type: 'post',
			dataType: 'text',  
			data: {cart_code_pk : cart_code_pk},  
			success : function(data){
				if(data == 'SUCCESS'){
					
		         	alert("사용자의 장바구니가 전체 삭제되었습니다.");
					location.href = "/cart/cart_list"; // db에서 장바구니 삭제처리 콘트롤러에서 걸기(개별 삭제 완료)

		          	// 장바구니 전체를 화면에서 제거하는 구문
		          	cart_table.remove();
                	
		        }	
				
			}
		});
 		
 		
 	});
	

	

	// 주문하기 이동 
	$("button[name='btn_order']").on("click", function(){
		location.href = "/order/order?type=2";
	});

	// 장바구니 선택삭제
	$("#btn_cart_check_del").on("click", function(){

		//console.log($("input[name='cart_check']:checked").length);

		if($("input[name='cart_check']:checked").length == 0) {
			alert("삭제할 상품을 선택하세요");
			return;
		}

		var result = confirm("선택한 상품을 삭제하시겠습니까?");

		if(result) {
			var checkArr = [];

			$("input[name='cart_check']:checked").each(function(){
				var cart_code_pk = $(this).val();
				checkArr.push(cart_code_pk); // push로 데이터를 배열에 집어 넣음
			});

			$.ajax({
				url: "/cart/cart_check_delete",
				type: "post",
				data: {checkArr : checkArr}, 
				dataType: "text",
				success: function(data){
					if(data == "SUCCESS"){
						alert("선택된 상품이 삭제되었습니다.");
						location.href = "/cart/cart_list";
					}
				}
			});
		}
	});

	// 제목행의 체크박스 선택시 전체선택 기능
	$("#check_all").on("click", function(){
		$("input[name='cart_check']").prop("checked", this.checked);
	});

	// 데이터 행의 체크박스 클릭
	$("input[name='cart_check']").on("click", function(){
		//$("#check_all").prop("checked", false);
		if($("input[name='cart_check']:checked").length == $("input[name='cart_check']").length) {
			$("#check_all").prop("checked", true);
		}else{
			$("#check_all").prop("checked", false);
		}
	});
	
	// btn_chk_order 
	//선택상품 주문  <input type="checkbox" name="cart_check" value="${cartList.cart_code }" >
		$("button[name='btn_chk_order']").on("click", function(){

			//console.log($("input[name='cart_check']:checked").length);

			if($("input[name='cart_check']:checked").length == 0){
				alert("구매할 상품을 선택하세요.");
				return;
			}

			var result = confirm("선택한 상품을 구매하시겠습니까?");

			if(result){
				var checkArr = [];

				$("input[name='cart_check']:checked").each(function(){
					var cart_code = $(this).val();
					checkArr.push(cart_code);
				});

				$.ajax({
					url : "/cart/cart_check_order",
					type: "post",
					data: {checkArr : checkArr},
					dataType : "text",
					success: function(data){
					if(data == "SUCCESS"){
						
						location.href = "/order/order?type=2";
         
      	 			}
    	 			}
   			});

			}
		});
	

  });

</script>

</body>
 
</html>

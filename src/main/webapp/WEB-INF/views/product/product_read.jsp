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

   <%-- 스타일 --%>
    #star_grade a{
     	font-size:22px;
        text-decoration: none;
        color: lightgray;
    }
    #star_grade a.on{
        color: black;
    }
    
    #star_grade_modal a{
     	font-size:22px;
        text-decoration: none;
        color: lightgray;
    }
    #star_grade_modal a.on{
        color: black;
    }
    
    .popup {position: absolute;}
    .back { background-color: gray; opacity:0.5; width: 100%; height: 300%; overflow:hidden;  z-index:1101;}
    .front { 
       z-index:1110; opacity:1; boarder:1px; margin: auto; 
      }
     .show{
       position:relative;
       max-width: 1200px; 
       max-height: 800px; 
       overflow: auto;       
     } 
 
    
  </style>
    
<%@ include file= "/WEB-INF/views/common/config.jsp" %>

	<!-- 1)handlebars.js 참조 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<!-- 2)UI Template(상품후기 목록 템플릿) -->
	<script id="reviewTemplate" type="text/x-handlebars-template">
			{{#each .}}
			<ul class="list-group">
				<li class="list-group-item" data-no="{{rv_num_pk}}">{{rv_num_pk}}</li>
				<li class="list-group-item" data-content="{{rv_content}}">{{rv_content}}</li>
				<li class="list-group-item" data-id="{{mb_id_pk}}">{{mb_id_pk}}</li>
				<li class="list-group-item" data-date="{{displayTime rv_date_reg}}">{{displayTime rv_date_reg}}</li>
				<li class="list-group-item" data-score="{{rv_score}}"><strong>{{checkRating rv_score}}</strong></li>
				<li class="list-group-item">{{eqReplyer mb_id_pk}}</li>
			</ul>
			{{/each}}
	</script>


	<script>
		// 3) 상품후기 목록 데이터 출력작업
		var printReviewData = function(reviewData, reviewTarget, reviewTemplate){
				var uiTemplate = Handlebars.compile(reviewTemplate.html());

				var reviewDataResult = uiTemplate(reviewData);
				
				reviewTarget.html(reviewDataResult);
			}

		
		// 상품후기 목록 페이지 구현작업
		let curPage = 1;

		//var pageNum = curPage;
		var replyPageDisplay = ""; // [이전] 1 2 3 4 5 6 7 8 9 10 [다음]

	
		// 댓글 페이징번호를 출력하는 기능.

		var displayPageCount = 5; // 페이지에 출력될 개수

		var printReviewPaging = function(replyCnt, pageNum){ // demo06과 차이점 pageNum 변수 추가
			
			// 페이징 알고리즘
			var endNum = Math.ceil(pageNum / 10.0) * 10; // 10 의 의미는 출력될 페이지수(pageSize)
			var startNum = endNum - 9;

			var prev = startNum != 1;
			var next = false;

			// 마지막페이수 번호 * 10개 >= 총데이타개수(실제)
			if(endNum * displayPageCount >= replyCnt){
				//  Math.ceil(12 / 10) = 2
				endNum = Math.ceil(replyCnt/parseFloat(displayPageCount)); // 실제데이타를 이용한 전체페이지 수
			}

			// 실제데이타가 마지막페이지번호*10 보다 크면, 다음데이타를 표시하기위하여 next = true 로 해줘야한다.
			if(endNum * displayPageCount < replyCnt){
				next = true;
			}

			/*
			<nav aria-label="Page navigation example">
			<ul class="pagination">
				<li class="page-item"><a class="page-link" href="#">Previous</a></li>
				<li class="page-item"><a class="page-link" href="#">1</a></li>
				<li class="page-item"><a class="page-link" href="#">2</a></li>
				<li class="page-item"><a class="page-link" href="#">3</a></li>
				<li class="page-item"><a class="page-link" href="#">Next</a></li>
			</ul>
			</nav>

			*/

			var str = '<ul class="pagination">';
			// 이전표시여부
			if(prev){
				str += '<li class="page-item"><a class="page-link" href="' + (startNum - 1) + '">Previous</a></li>';
			}
			// 페이지번호 출력
			for(var i=startNum; i<= endNum; i++){
				var active = pageNum == i ? "active":""; // 현재페이지 상태를 나타내는 스타일시트 적용

				str += '<li class="page-item ' + active + ' "><a class="page-link" href="' + i + '">' + i + '</a></li>';
			}
			// 다음표시여부
			if(next){
				str += '<li class="page-item"><a class="page-link" href="' + (endNum + 1) + '">Next</a></li>';
			}

			str += '</ul>';

			console.log(str);

			
			$("#reviewPaging").html(str);

			//페이징정보 표시

			
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
    		<!-- 상품 상세설명 위치 -->
    		<%----%>
    	<div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
    	<div class="col-auto d-none d-lg-block">
        	<img src="/product/displayFile?fileName=${productVO.pdt_img }" style="width: 200;height: 250;">
          
        </div>
        	<div class="col p-4 d-flex flex-column position-static">
	          <strong class="d-inline-block mb-2 text-primary">${productVO.pdt_name }</strong>
	          <h3 class="mb-0"><fmt:formatNumber type="currency" value="${productVO.pdt_price }"/>원</h3><br>
	          <div class="mb-1">할인율 ${productVO.pdt_discount} %</div>
	          <div class="mb-1">제조사 ${productVO.pdt_company}</div>
	          <div>
	          수량 <input type="text" value="${productVO.pdt_amount}" id="pdt_amount" name="pdt_amount" style="width: 40%">
	          </div>
	          <div>
	          <button type="button" id="btnOrder" class="btn btn-link">즉시구매</button>
		      <button type="button" id="btnCart" class="btn btn-link">장바구니</button>
		      <button type="button" id="btnReview" class="btn btn-link">상품후기</button>
		      </div>
        	</div>
        	<form id="order_direct_form" method="get" action="/order/order">
				<input type="hidden" name="type" value="1">

			</form>
     		</div>
     		
     		<div>
		      ${productVO.pdt_detail }
		    </div>
		    
    		</div>
  		</div>
  		
  		<!-- 상품후기 목록-->
		<div class="row">
			<div class="col-lg-2">
				&nbsp;
			</div>			
			<div class="col-lg-10">
	    		<div class="panel panel-default">
	    			<div class="panel-heading">
	    			 Review List
	    			</div>
	    			
	    			<!-- 상품후기 목록위치 -->
	    			<div class="panel-body" id="reviewListView"></div>
					<!-- 페이징 위치 -->
					<div class="panel-footer" id="reviewPaging"></div>
				</div>
			</div>
		</div>

</main><!-- /.container -->
<script>
	$(document).ready(function(){
		$("#btnCart").on("click", function(){
			console.log("장바구니");

			/*
			장바구니 코드: 시퀀스, 로그인ID(세션)
			상품코드, 수량

			*/

			var pdt_num_pk = ${productVO.pdt_num_pk};
			var pdt_amount = $("#pdt_amount").val();

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
		
		$("#btnOrder").on("click", function(){
			
			console.log("즉시구매");

			// 상품코드, 구매수량

			var pdt_num_pk = ${productVO.pdt_num_pk}; // <input type='hidden' name='pdt_num_pk'
			var odr_amount = $("#pdt_amount").val(); // <input type="number" style="width:50px" name="odr_amount" 

			console.log("상품코드: " + pdt_num_pk);
			console.log("상품수량: " + odr_amount);

			

			var order_direct_form = $("#order_direct_form");
			order_direct_form.append("<input type='hidden' name='pdt_num_pk' value='" + pdt_num_pk + "'>");
			order_direct_form.append("<input type='hidden' name='odr_amount' value='" + odr_amount + "'>");				
			
			order_direct_form.submit();

		});
		
	});

</script>

<script>

	// 상품후기 목록/페이징
	var showReviewList = function(curPage) {
		
		// 상품코드
		let pdt_num_pk = ${productVO.pdt_num_pk};
		let page = curPage;

		console.log(pdt_num_pk);
		
		let url = "/review/pages/" + pdt_num_pk + "/" + page; // /pages/100/1

		$.getJSON(url, function(data){
			
			//alert(data.reviewCnt);
			//alert(data.list[0].rv_num_pk);

			// 댓글데이터 없는 경우처리 할 것
			// 1) 상품후기목록 출력
			// var printReviewData = function(reviewData, reviewTarget, reviewTemplate)
			
			printReviewData(data.list, $("#reviewListView"), $("#reviewTemplate"));
			
			// 2) 페이징 출력 작업
			// var printReviewPaging = function(replyCnt){
			printReviewPaging(data.reviewCnt, page);
		});

	}

	showReviewList(curPage);
	
</script>

<script>

	$(document).ready(function(){
		// 모달대화상자 보기
		$("#btnReview").on("click", function(){
			$("#modalLabel").html("Product Review Modal-Register");
			
			$("button.btnModal").hide();
			$("#btnReviewAdd").show();
			
			// 모달 창 띄우는 구문
			$("#reviewModal").modal("show");
		});

		// 별점 색상변경
		$("#star_grade a").on("click",function(e){
			
			e.preventDefault(); // 링크기능 취소
			$(this).parent().children("a").removeClass("on"); // removeClasS("on")은 뒷부분 선택한 별을 지우는 효과
			$(this).addClass("on").prevAll("a").addClass("on"); // prevAll은 선택한 별(a)의 앞부분까지 선택

		});

		// 상품후기 쓰기
		$("#btnReviewAdd").on("click", function(){

			let rv_score = 0;
			let rv_content = $("#rv_content").val();
			let pdt_num_pk = $("#pdt_num_pk").val();

			$("#star_grade a").each(function(i, e){ // i는 인덱스 e는 a태그를 가리킴
				if($(this).attr("class") == "on"){
					rv_score += 1;
				}
			});

			if(rv_score == 0) {
				alert("평점을 선택해주세요.");
				return;
			}else if(rv_content == "" || rv_content == null) {
				alert("후기 내용을 입력해주세요.");
				return;
			}

			// ajax 호출
			// 후기 입력데이터를 전송시키는 작업
			$.ajax({
				url: "/review/review_register",
				type: "post",
				data: {rv_score : rv_score, rv_content : rv_content, pdt_num_pk : pdt_num_pk}, //{VO의 파라미터 : jquery의 변수}
				dataType: "text",
				success: function(data) {
					alert("상품후기가 등록되었습니다.");
					$("#star_grade a").parent().children("a").removeClass("on"); // 평점 0으로 ajax
					$("#rv_content").val(""); // 빈칸으로 ajax

					$("#reviewModal").modal("hide");

					// 상품후기 목록호출 함수
					showReviewList(1);
				}
			});

		});
		
		// 닫기버튼 눌렀을때 평점, 상품후기란 초기화
		$("#btnclose").on("click", function(){
			$("#star_grade a").parent().children("a").removeClass("on");
			$("#rv_content").val("");
		});
		
		// 로그인 사용자와 상품후기 작성자가 동일하면 수정, 삭제 표시
		Handlebars.registerHelper("eqReplyer", function(replyer, rv_num_pk){
			var str = '';
			var login_id = "${sessionScope.loginStatus.mb_id_pk}";
			if(replyer == login_id){
				str += '<button type="button" class="btn btn-primary btn-edit">Modify</button>';
				str += '<button type="button" class="btn btn-danger btn-del">Delete</button>';
			}

			return new Handlebars.SafeString(str); // 태그문자열 처리시 사용

		});

		// 상품후기 목록 수정클릭시
		// 동적으로 추가되는 btn-edit은 $("#btn-edit")으로 바로 넣을 수 없음
		$("#reviewListView").on("click", ".btn-edit", function(){ // btn-edit 버튼이 로그인시만 동적으로 추가되서 .btn-edit으로 추가
			console.log("후기수정 버튼");

			// 모달 대화상자 표시 - 수정내용 반영

			var rv_num_pk, mb_id_pk, pdt_num_pk, rv_content, rv_score, rv_date_reg;

			
			rv_num_pk = $(this).parents("ul.list-group").find("li[data-no]").attr("data-no");
			mb_id_pk = $(this).parents("ul.list-group").find("li[data-id]").attr("data-id");
			pdt_num_pk = $(this).parents("ul.list-group").find("li[data-no]").attr("data-no");
			rv_content = $(this).parents("ul.list-group").find("li[data-content]").attr("data-content");
			rv_score = $(this).parents("ul.list-group").find("li[data-score]").attr("data-score");
			rv_date_reg = $(this).parents("ul.list-group").find("li[data-date]").attr("data-date");

			//console.log(rv_num_pk);

			$("#modalLabel").html("Product Review Modal-Modify" + rv_num_pk + "번");
		
			$("#rv_num_pk").val(rv_num_pk);
			$("#rv_content").val(rv_content);

			// 상품후기 수정 모달대화상자에서 별점표시 작업
			$("#star_grade a").each(function(index, item){
				if(index < rv_score){ // 0 < 3, 1 < 3, 2 < 3, 3 < 3 
					$(item).addClass("on");
				}else{
					$(item).removeClass("on");
				}
			});
			
			$("button.btnModal").hide(); // 추가, 수정, 삭제버튼 모두 숨기기
			$("#btnReviewEdit").show(); //
			
			// 모달 창 띄우는 구문
			$("#reviewModal").modal("show");

		});
	
		// 상품후기 수정하기
		$("#btnReviewEdit").on("click", function(){
			
			let rv_score = 0;
			let rv_content = $("#rv_content").val();
			
			let rv_num_pk = $("#rv_num_pk").val();

			$("#star_grade a").each(function(i, e){ // i는 인덱스 e는 a태그를 가리킴
				if($(this).attr("class") == "on"){
					rv_score += 1;
				}
			});

			if(rv_score == 0) {
				alert("평점을 선택해주세요.");
				return;
			}else if(rv_content == "" || rv_content == null) {
				alert("후기 내용을 입력해주세요.");
				return;
			}
			
			console.log(rv_score);
			console.log(rv_content);
			console.log(rv_num_pk);

			// ajax 호출
			// 후기 입력데이터를 전송시키는 작업
			$.ajax({
				url: "/review/review_modify",
				type: "post",
				data: {rv_score : rv_score, rv_content : rv_content, rv_num_pk : rv_num_pk}, //{VO의 파라미터 : jquery의 변수}
				dataType: "text",
				success: function(data) {
					alert("상품후기가 수정되었습니다.");
					$("#star_grade a").parent().children("a").removeClass("on"); // 평점 0으로 ajax
					$("#rv_content").val(""); // 빈칸으로 ajax

					$("#reviewModal").modal("hide");

					// 상품후기 목록호출 함수. 목록의 페이지번호
					showReviewList(curPage);
				}
			});
		});

		// 상품후기 목록 삭제 보기
		$("#reviewListView").on("click", ".btn-del", function(){
			
			var rv_num_pk, mb_id_pk, pdt_num_pk, rv_content, rv_score, rv_date_reg;

			
			rv_num_pk = $(this).parents("ul.list-group").find("li[data-no]").attr("data-no");
			mb_id_pk = $(this).parents("ul.list-group").find("li[data-id]").attr("data-id");
			pdt_num_pk = $(this).parents("ul.list-group").find("li[data-no]").attr("data-no");
			rv_content = $(this).parents("ul.list-group").find("li[data-content]").attr("data-content");
			rv_score = $(this).parents("ul.list-group").find("li[data-score]").attr("data-score");
			rv_date_reg = $(this).parents("ul.list-group").find("li[data-date]").attr("data-date");

			//console.log(rv_num_pk);

			$("#modalLabel").html("Product Review Modal-Delete" + rv_num_pk + "번");
		
			$("#rv_num_pk").val(rv_num_pk);
			$("#rv_content").val(rv_content);

			// 상품후기 수정 모달대화상자에서 별점표시 작업
			$("#star_grade a").each(function(index, item){
				if(index < rv_score){ // 0 < 3, 1 < 3, 2 < 3, 3 < 3 
					$(item).addClass("on");
				}else{
					$(item).removeClass("on");
				}
			});
			
			$("button.btnModal").hide(); // 추가, 수정, 삭제버튼 모두 숨기기
			$("#btnReviewDel").show(); //
			
			// 모달 창 띄우는 구문
			$("#reviewModal").modal("show");
		});
		
		// 상품후기 목록 삭제클릭시
		$("#btnReviewDel").on("click", function(){
						
			let rv_num_pk = $("#rv_num_pk").val();

			// ajax 호출
			// 후기 입력데이터를 전송시키는 작업
			$.ajax({
				url: "/review/review_delete",
				type: "post",
				data: {rv_num_pk : rv_num_pk}, //{VO의 파라미터 : jquery의 변수}
				dataType: "text",
				success: function(data) {
					alert("상품후기가 삭제되었습니다.");
					$("#star_grade a").parent().children("a").removeClass("on"); // 평점 0으로 ajax
					$("#rv_content").val(""); // 빈칸으로 ajax

					$("#reviewModal").modal("hide");

					// 상품후기 목록호출 함수. 목록의 페이지번호
					showReviewList(curPage);
				}
			});
		});
		
		// 4)사용자정의 헬퍼(Handlebars 버전의 함수)
		// 댓글 날짜를 하루기준으로 표현을 1)24시간 이전 시:분:초 2)24시간 이후 년/월/일
		Handlebars.registerHelper("displayTime", function(timeValue){
			var today = new Date(); // 1970년1월1일 0시0분0초 0 밀리세컨드
			var gap = today.getTime() - timeValue;

			var dateObj = new Date(timeValue);
			var str = "";

			if (gap < (1000 * 60 * 60 * 24)){
				var hh = dateObj.getHours();
				var mi = dateObj.getMinutes();
				var ss = dateObj.getSeconds();

				return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
						':', (ss > 9 ? '' : '0') + ss ].join('');
			}else {
				var yy = dateObj.getFullYear();
				var mm = dateObj.getMonth();
				var dd = dateObj.getDate();

				return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
						(dd > 9 ? '' : '0') + dd ].join('');
			}
		});

		
		Handlebars.registerHelper("checkRating", function(rating){
			var stars = "";

			switch(rating){
				case 1:
					stars = "★☆☆☆☆";
					break;
				case 2:
					stars = "★★☆☆☆";
					break;
				case 3:
					stars = "★★★☆☆";
					break;
				case 4:
					stars = "★★★★☆";
					break;
				case 5:
					stars = "★★★★★";
					break;
				default:
					stars = "☆☆☆☆☆";
					break;
						
			}

			return stars;

		});

		$("#reviewPaging").on("click", "li.page-item a", function(e){
			e.preventDefault(); // a 태그 기능을 취소시킴
			console.log("페이지 번호클릭");

			curPage = $(this).attr("href");
			showReviewList(curPage);
		});

	});

</script>


<!-- 상품후기 모달대화상자 : 후기쓰기, 후기수정, 후기삭제 -->
<div class="modal fade" id="reviewModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalLabel">Product Review Modal-Register</h5>
		
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="form-group">
        <label for="review">상품후기 평점</label><br>
			<div class="rating">
				<p id="star_grade">
			        <a href="#">★</a>
			        <a href="#">★</a>
			        <a href="#">★</a>
			        <a href="#">★</a>
			        <a href="#">★</a>
				</p>
			</div>
        </div>
        <div class="form-group">
        	<label>상품후기</label>
			<input type="hidden" class="form-control" name="pdt_num_pk" id="pdt_num_pk" value="${productVO.pdt_num_pk }">
			<input type="hidden" name="rv_num_pk" id="rv_num_pk">
        	<textarea class="form-control" name="rv_content" id="rv_content"></textarea>
        </div>
        
      </div>
      <div class="modal-footer">
        <button type="button" id="btnclose" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <button type="button" id="btnReviewAdd" class="btn btn-primary btnModal">작성</button>
		<button type="button" id="btnReviewEdit" class="btn btn-primary btnModal">수정</button>
		<button type="button" id="btnReviewDel" class="btn btn-primary btnModal">삭제</button>
      </div>
    </div>
  </div>
</div>

</body>
</html>

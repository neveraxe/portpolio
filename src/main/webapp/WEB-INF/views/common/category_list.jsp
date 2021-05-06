<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<ul>
	<c:forEach items="${mainCateList}" var="cateVO">
	<li class="nav-item mainCategory">
        <a class="nav-link"  href="#" data-code="${cateVO.cg_code_pk }">${cateVO.cg_name }</a>

         <!-- 1차 카테고리 선택에 의한 2차카테고리 출력 위치-->
         <ul class="subCategory"></ul>
    </li>
    </c:forEach>
</ul>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script id="subCGListTemplate" type="text/x-handlebars-template">
  {{#each .}}
    <li><a href="/product/product_list?cg_code_pk={{cg_code_pk}}">{{cg_name}}</a></li>
  {{/each}}
</script>
	<script>
	$(document).ready(function(){
	  $(".mainCategory").on("click", function(){
	    
	    var mainCategory = $(this); // this를 변수로 받아서 사용
	    var cg_code_pk = $(this).find("a").attr("data-code"); // 클릭한 1차카테고리 자신(this)의 a코드를 찾아서 href속성을 읽어온다
	    var url = "/product/subCategoryList/" + cg_code_pk;
	
	    //alert(url);
	
	    // Ajax 요청작업
	    // 1차카테고리를 참조하는 2차카테고리 정보
	    $.getJSON(url, function(data){
	      subCGList(data, mainCategory, $("#subCGListTemplate"));
	    });
	
	  });
	});
	
	  var subCGList = function(subCGData, targetSubCategory, templateObject) {
	
	    var template = Handlebars.compile(templateObject.html());
	    var subCGLi = template(subCGData);
	
	    //targetSubCategory.find(".subCategory").empty();
	    $(".mainCategory .subCategory").empty();
	    targetSubCategory.find(".subCategory").append(subCGLi);
	    
	  }
	</script>
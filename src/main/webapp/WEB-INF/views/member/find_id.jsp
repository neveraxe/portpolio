<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

<script type="text/javascript" src="/js/member/id_pw_search.js"></script>
    
  </head>
  <body>
    
<!-- nav.jsp -->
<%@ include file="/WEB-INF/views/common/nav.jsp" %>

  <div class="container" align="center" style="width:450px; height:620px; background-color: white; margin-top:30px">
  	  <h2 class="form-signin-heading">Id Search</h2><br>
	  <label for="inputId" class="sr-only">이름</label>
	  <input type="text" id="mb_name" name="mb_name" class="form-control" required autofocus placeholder="이름을 입력하세요">
	 
	  <br>
	  <button class="btn btn-primary btn-block" id="btn_ID_Search" name="btn_login" type="submit">Search ID</button>
	  <p id="result" style="color:red;"></p>
  </div>


  </body>
</html>

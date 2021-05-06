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

<script type="text/javascript" src="/js/member/login.js"></script>
    
  </head>
  <body>
    
<!-- nav.jsp -->
<%@ include file="/WEB-INF/views/common/nav.jsp" %>

  <div class="container" align="center" style="width:450px; height:620px; background-color: white; margin-top:30px">
  <form id="loginForm" class="form-signin" action="/member/loginPost" method="post" style="padding:50px 30px;">
  <h2 class="form-signin-heading">Login</h2><br>
  <label for="inputId" class="sr-only">아이디</label>
  <input type="text" id="mb_id_pk" name="mb_id_pk" class="form-control" placeholder="Id" required autofocus>
  <label for="inputPassword" class="sr-only">패스워드</label>
  <input type="password" id="mb_passwd" name="mb_passwd" class="form-control" placeholder="password" required>
  
  <div class="checkbox">
    <label>
      <input type="checkbox" value="remember-me"> Remember me
    </label>
  </div>
  <br>
  <button class="btn btn-primary btn-block" id="btn_login" name="btn_login" type="submit">Sign in</button>
</form>
<div>
	<a class="btn btn-link" href="/member/find_id">Id Search</a>
	<a class="btn btn-link" href="/member/find_pwd">PW Search</a>
</div>
</div>


  </body>
</html>

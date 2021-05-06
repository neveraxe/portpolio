<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
  
  <div class="collapse navbar-collapse" id="navbarsExampleDefault">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="/">Home <span class="sr-only">(current)</span></a>
      </li>
      <!-- 인증 전 표시 -->
      <c:if test="${sessionScope.loginStatus == null }">
      <li class="nav-item">
        <a class="nav-link" href="/member/login">Login</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/member/join">Join</a>
      </li>
      
       <li class="nav-item">
        <a class="nav-link" href="/member/pw_search?id=neveraxe">pass Search</a>
      </li>
       
      </c:if>
      <!-- 인증 후 표시  c:if는 로그인한 조건-->
      <c:if test="${sessionScope.loginStatus != null }">
      <li class="nav-item">
        <a class="nav-link" href="/member/logout">LogOut</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/member/Modify">RegModify</a>
      </li>
      
      <li class="nav-item">
        <a class="nav-link" href="/cart/cart_list">CartList</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/member/MyPage/MyPageHome">MyPage</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/board/list">Board</a>
      </li>
      
      <li class="nav-item">
        <a class="nav-link" href="/member/delete">RegDelete</a>
      </li>
      
      </c:if>

      <!--  
      <li class="nav-item">
        <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
      </li>
      -->
      
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Product</a>
        <div class="dropdown-menu" aria-labelledby="dropdown01">      
          <a class="dropdown-item" href="#">Home Audio</a>
          <a class="dropdown-item" href="#">Heritage Series</a>
          <a class="dropdown-item" href="#">Personal Music</a>
        </div>
      </li>
      
    </ul>
  </div>
</nav>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Left side column. contains the logo and sidebar -->
	<aside class="main-sidebar">
   <!-- sidebar: style can be found in sidebar.less -->
		<section class="sidebar">

			<!-- Sidebar user panel (optional) -->
			<!-- 인증 전 표시 -->
			<%-- 
			<c:if test="${sessionScope.AdminloginStatus == null }">
			<div class="user-panel">
				<div class="pull-left image">
					<p>unnamed</p>
				</div>
				<div class="pull-left info">
					<p>unnamed</p>
					<!-- Status -->
					<a href="#"><i class="fa fa-circle text-success"></i> Offline</a>
				</div>
			</div>
			</c:if>
			--%>
				
			<div class="user-panel">
				<div class="pull-left image">
					<img src="/dist/img/mementomori.jpg" class="img-circle" alt="User Image">
				</div>
				<div class="pull-left info">
					<p>neveraxe</p>
					<!-- Status -->
					<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
				</div>
			</div>
			
			<!-- search form (Optional) -->
			<form action="#" method="get" class="sidebar-form">
				<div class="input-group">
					<input type="text" name="q" class="form-control" placeholder="Search...">
					<span class="input-group-btn">
						<button type="submit" name="search" id="search-btn" class="btn btn-flat">
							<i class="fa fa-search"></i>
						</button>
					</span>
				</div>
			</form>
			<!-- /.search form -->

			<!-- Sidebar Menu -->
			<ul class="sidebar-menu" data-widget="tree">
				<li class="header">HEADER</li>
				<!-- Optionally, you can add icons to the links -->

				<li class="treeview">
					<a href="#"><i class="fa fa-link"></i> <span>상품관리</span> <span class="pull-right-container">
							<i class="fa fa-angle-left pull-right"></i>
						</span> </a>
					<ul class="treeview-menu">
						<li>
							<!-- context 경로가 어떤 값이 와도 읽어오는 코드 구문 -->
							<a href="${pageContext.request.contextPath }/admin/product/product_insert">상품등록</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath }/admin/product/pro_list">상품목록</a>
						</li>
					</ul>
				</li>
				<li class="treeview">
					<a href="#"><i class="fa fa-link"></i> <span>주문관리</span> <span class="pull-right-container">
							<i class="fa fa-angle-left pull-right"></i>
						</span> </a>
					<ul class="treeview-menu">
						<li>
							<a href="${pageContext.request.contextPath }/admin/order/order_list">주문목록</a>
						</li>
					</ul>
				</li>
				<li class="treeview">
					<a href="#"><i class="fa fa-link"></i> <span>회원관리</span> <span class="pull-right-container">
							<i class="fa fa-angle-left pull-right"></i>
						</span> </a>
					<ul class="treeview-menu">
						<li>
							<a href="${pageContext.request.contextPath }/admin/member/userinfo_list">회원목록</a>
						</li>
					</ul>
				</li>
				<li class="treeview">
					<a href="#"><i class="fa fa-link"></i> <span>게시판관리</span> <span class="pull-right-container">
							<i class="fa fa-angle-left pull-right"></i>
						</span> </a>
					<ul class="treeview-menu">
						<li>
							<a href="${pageContext.request.contextPath }/admin/board/list">게시판목록</a>
						</li>
					</ul>
				</li>
				<li class="treeview">
					<a href="#"><i class="fa fa-link"></i> <span>통계/매출현황관리</span> <span class="pull-right-container">
							<i class="fa fa-angle-left pull-right"></i>
						</span> </a>
					<ul class="treeview-menu">
						<li>
							<a href="${pageContext.request.contextPath }/admin/order/order_sale">매출통계</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath }/admin/chart/chart">차트통계</a>
						</li>
					</ul>
				</li>
				
			</ul>
			<!-- /.sidebar-menu -->
		</section>
		<!-- /.sidebar -->
	</aside>
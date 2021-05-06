<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
	
	<!-- Main Header -->
	<header class="main-header">
    
	<!-- Logo -->
		<a href="/admin/" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels --> <span class="logo-mini">
				<b>Klip</b>
			</span> <!-- logo for regular state and mobile devices --> <span class="logo-lg">
				<b>Klipsch</b>
			</span>
		</a>

		<!-- Header Navbar -->
		<nav class="navbar navbar-static-top" role="navigation">
			<!-- Sidebar toggle button-->
			<a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button"> <span class="sr-only">Toggle navigation</span>
			</a>
			<!-- Navbar Right Menu -->
			<div class="navbar-custom-menu">
				<ul class="nav navbar-nav">
					<!-- Messages: style can be found in dropdown.less-->
					<li class="dropdown messages-menu">
						<!-- Menu toggle button -->
						<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="fa fa-envelope-o"></i> <span class="label label-success"></span>
						</a>
						
					</li>
					<!-- /.messages-menu -->

					<!-- Notifications Menu -->
					<li class="dropdown notifications-menu">
						<!-- Menu toggle button -->
						<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="fa fa-bell-o"></i> <span class="label label-warning"></span>
						</a>
						
					</li>
					<!-- Tasks Menu -->
					<li class="dropdown tasks-menu">
						<!-- Menu Toggle Button -->
						<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="fa fa-flag-o"></i> <span class="label label-danger"></span>
						</a>
						<ul class="dropdown-menu">

						</ul>
					</li>
					<!-- User Account Menu -->
					
					
					<li>
						<p>최근 로그인시간:
						<fmt:formatDate value="${sessionScope.adLoginStatus.admin_date_late }" pattern="yyyy-MM-dd HH:mm:ss" />
						</p>
					</li>
					<li class="dropdown user user-menu">
						
						<!-- Menu Toggle Button -->
						<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <!-- The user image in the navbar--> <img src="/dist/img/mementomori.jpg" class="user-image" alt="User Image"> <!-- hidden-xs hides the username on small devices so only the image appears. --> <span class="hidden-xs">neveraxe</span>
						</a>
						<ul class="dropdown-menu">
							<!-- The user image in the menu -->
							
							<li class="user-header">
								<img src="/dist/img/mementomori.jpg" class="img-circle" alt="User Image">

								<p>
									neveraxe - Web Developer <small>Member since April. 2021</small>
								</p>
							</li>
							
							<!-- Menu Body -->
							<li class="user-body">
								
								
							</li>
							<!-- Menu Footer-->
							<li class="user-footer">
								<div class="pull-left">
									<button id="" class="btn btn-default btn-flat">정보변경</button>
								</div>
								<div class="pull-right">
									<a href="/admin/logout" class="btn btn-default btn-flat">로그아웃</a>
								</div>
							</li>
						</ul>
					</li>
				
					
				</ul>
				
				
		</nav>
	</header>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
<!-- css file -->
<!-- 절대경로 : 어떤 위치에 있어도 무관 -->
<%@ include file="/WEB-INF/views/admin/include/head_inc.jsp" %>

<%-- 상대경로 : 위치가 정해져 있어야 함 상대적인 경로이기에
<%@ include file="include/head_inc.jsp" %>
--%>

<script src="/ckeditor/ckeditor.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>



</head>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		
		<%@ include file="/WEB-INF/views/admin/include/main-header.jsp" %>		
		
		<%@ include file="/WEB-INF/views/admin/include/main-sidebar.jsp" %>
	
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					Page Header <small>Optional description</small>
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="#"><i class="fa fa-dashboard"></i> 통계/매출현황관리</a>
					</li>
					<li class="active">매출통계</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">
			
			<div class="row">
				<div class="col-lg-12">
					<form id="formDate" action="/admin/order/order_sale" method="get">
						<!-- 자바코드가 실행되면서 현재날짜와 시간을 갖게됨 -->
						<c:set var="today" value="<%=new java.util.Date() %>" />
						<c:set var="year"><fmt:formatDate value="${today }" pattern="yyyy"/></c:set>
						<c:set var="month"><fmt:formatDate value="${today }" pattern="MM"/></c:set>
						<select name="year" id="year">
							<c:forEach begin="0" end="2" var="i" step="1">
							<option value="<c:out value="${year-2+i }"/>" ${(year-2+i) == sel_year ? 'selected':''}>
							<c:out value="${year-2+i }"/>
							</option>
							</c:forEach>
							
							<c:forEach begin="1" end="2" var="i" step="1">
							<option value="<c:out value="${year+i }"/>" ${(year+i) == sel_year ? 'selected':''}>
							<c:out value="${year+i }"/>
							</option>
							</c:forEach>
						</select>년
						<select name="month" id="month">
							<c:forEach begin="1" end="12" var="i" step="1">
							<fmt:formatNumber var="dal" minIntegerDigits="2" value="${i}" type="number" />
							<fmt:formatNumber var="cur_month" minIntegerDigits="2" value="${month}" type="number" />
							<option value="${dal }" ${dal == sel_month ? 'selected':''}>${dal }</option>
							</c:forEach>
						</select>월
						<button id="btnSearch" type="submit" class="btn btn-primary">검색</button>
						
						<%-- 이렇게 forEach를 꺼꾸로 돌리면 에러 맞음 
						<c:forEach begin="12" end="1" var="i" step="-1">
							<c:out value="${i }"></c:out>
						</c:forEach>
						 --%>
					</form>
				</div>
			</div>
			
			<!-- 주문통계 리스트 -->
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
							      <th scope="col">일별통계</th>
							      <th scope="col">주문건수</th>
							      <th scope="col">비고</th>
							    </tr>
							  </thead>
							  <tbody>
							  <c:forEach items="${order_salelist }" var="orderSaleDTO">
							    <tr>
							      <th scope="row">
							      	${orderSaleDTO.odr_date }(${orderSaleDTO.day })
							      </th>
							      <td>
								    ${orderSaleDTO.cnt } 
							      </td>
							      <td></td>
							   </c:forEach>
							   </tbody>
							</table>
			    			</div>
			    		</div>
			    	</div>
			    </div>
			
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<%@ include file="/WEB-INF/views/admin/include/main-footer.jsp" %>	

		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Create the tabs -->
			<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
				<li class="active">
					<a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a>
				</li>
				<li>
					<a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a>
				</li>
			</ul>
			<!-- Tab panes -->
			<div class="tab-content">
				<!-- Home tab content -->
				<div class="tab-pane active" id="control-sidebar-home-tab">
					<h3 class="control-sidebar-heading">Recent Activity</h3>
					<ul class="control-sidebar-menu">
						<li>
							<a href="javascript:;"> <i class="menu-icon fa fa-birthday-cake bg-red"></i>

								<div class="menu-info">
									<h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

									<p>Will be 23 on April 24th</p>
								</div>
							</a>
						</li>
					</ul>
					<!-- /.control-sidebar-menu -->

					<h3 class="control-sidebar-heading">Tasks Progress</h3>
					<ul class="control-sidebar-menu">
						<li>
							<a href="javascript:;">
								<h4 class="control-sidebar-subheading">
									Custom Template Design
									<span class="pull-right-container">
										<span class="label label-danger pull-right">70%</span>
									</span>
								</h4>

								<div class="progress progress-xxs">
									<div class="progress-bar progress-bar-danger" style="width: 70%"></div>
								</div>
							</a>
						</li>
					</ul>
					<!-- /.control-sidebar-menu -->

				</div>
				<!-- /.tab-pane -->
				<!-- Stats tab content -->
				<div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
				<!-- /.tab-pane -->
				<!-- Settings tab content -->
				<div class="tab-pane" id="control-sidebar-settings-tab">
					<form method="post">
						<h3 class="control-sidebar-heading">General Settings</h3>

						<div class="form-group">
							<label class="control-sidebar-subheading">
								Report panel usage
								<input type="checkbox" class="pull-right" checked>
							</label>

							<p>Some information about this general settings option</p>
						</div>
						<!-- /.form-group -->
					</form>
				</div>
				<!-- /.tab-pane -->
			</div>
		</aside>
		<!-- /.control-sidebar -->
		<!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->

	<!-- REQUIRED JS SCRIPTS -->
		
		<%@ include file="/WEB-INF/views/admin/include/scripts.jsp" %>
		
	<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
       
	
</body>
</html>
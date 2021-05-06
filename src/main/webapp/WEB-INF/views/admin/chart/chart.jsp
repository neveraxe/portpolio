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
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>	
	google.charts.load('current', {'packages':['corechart'] }  );
    //google.charts.load('current', {'packages':['bar']}); 
    
    google.charts.setOnLoadCallback(drawChart); // drawChart()함수 호출
    
    function drawChart() {
    	
        var jsonData = $.ajax({
            url: "/admin/chart/chartData", // 주소를 호출하면 구글에서 요구하는 차트데이터 포맷에 맞게 데이터를 json형태로 받아온다.
            type: "get",
            dataType: "json",
            async: false,

        }).responseText; // json 내용을 텍스트로 읽어들임.

        console.log(jsonData);

        var data
        = new google.visualization.DataTable(jsonData);
        //제이슨 형식을 구글의 테이블 형식으로 바꿔주기 위해서 집어넣음
        //차트를 출력할 div
        //LineChart, ColumnChart, PieChart에 따라서 차트의 형식이 바뀐다.
        
        var chart = new google.visualization.PieChart(document.getElementById('chart_div')); //원형 그래프
        
        //var chart
        // = new google.visualization.LineChart(
                //document.getElementById('chart_div')); 선 그래프 
                
        //var chart
        //  = new google.visualization.ColumnChart(document.getElementById('chart_div'));
                //차트 객체.draw(데이터 테이블, 옵션) //막대그래프
                
                //cuveType : "function" => 곡선처리
                
        //데이터를 가지고 (타이틀, 높이, 너비) 차트를 그린다.
        chart.draw(data, {
            title : "스피커 판매량",
            //curveType : "function", //curveType는 차트의 모양이 곡선으로 바뀐다는 뜻
            width : 600,
            height : 400
        });
    }
    
    $(document).ready(function(){
    	$("#btnChart").on("click", function(){
        	drawChart();
        });	// drawChart();
	});

    
</script>

<script>
	
</script>


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
					<li class="active">차트통계</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">
			
			<div class="row">
				<div class="col-lg-12">
					<div id="chart_div"></div>
					<div>
					<button id="btnChart" type="button">클릭!!!</button>
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
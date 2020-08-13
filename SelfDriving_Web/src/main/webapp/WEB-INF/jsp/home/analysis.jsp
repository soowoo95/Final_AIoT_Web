<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
  <head> 
	    <meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <title>AIOT FINAL PROJECT | TEAM 2</title>
	    <meta name="description" content="">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <meta name="robots" content="all,follow">
	    
	    <script src="${pageContext.request.contextPath}/resource/jquery/jquery-3.4.1.min.js" crossorigin="anonymous"></script>
	    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
	    
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/bootstrap/css/bootstrap.min.css">
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/font-awesome/css/font-awesome.min.css">
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/css/font.css">
	    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Muli:300,400,700">
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/css/style.default.css" id="theme-stylesheet">
		<link rel=icon href="${pageContext.request.contextPath}/resource/img/jetracer.png">
		
		<script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/bootstrap/js/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script src="https://code.highcharts.com/highcharts-more.js"></script>
		<script src="https://code.highcharts.com/modules/solid-gauge.js"></script>
		<script src="https://code.highcharts.com/modules/exporting.js"></script>
		<script src="https://code.highcharts.com/modules/export-data.js"></script>
		<script src="https://code.highcharts.com/modules/accessibility.js"></script>
		<script src="<%=application.getContextPath()%>/resources/highcharts/code/themes/gray.js"></script>

	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/popper.js/umd/popper.min.js"> </script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/bootstrap/js/bootstrap.min.js"></script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/jquery.cookie/jquery.cookie.js"> </script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/jquery-validation/jquery.validate.min.js"></script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/js/front.js"></script>
	</head>
	
	<body>
	<header class="header">   
	      <nav class="navbar navbar-expand-lg" style="height: 50px">
	        <div class="container-fluid d-flex align-items-center justify-content-between">
	          <div class="navbar-header">
	            <a href="${pageContext.request.contextPath}/home/main.do" class="navbar-brand">
		              <div class="brand-text brand-big visible text-uppercase" style="font-size: x-large"><strong class="text-primary">AIOT</strong><strong>Admin</strong></div>
		              <div class="brand-text brand-sm"><strong class="text-primary">A</strong><strong>A</strong></div>
		         </a>
	            <!-- Sidebar Toggle Btn-->
	            <button class="sidebar-toggle"><i class="fa fa-long-arrow-left"></i></button>
	          </div>
	          <div class="right-menu list-inline no-margin-bottom">    
	            <!-- Languages dropdown    -->
	            <div class="list-inline-item dropdown"><a id="languages" rel="nofollow" data-target="#" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link language dropdown-toggle"><img src="img/flags/16/GB.png" alt=""><span class="d-none d-sm-inline-block">LOGIN</span></a>
	              <div aria-labelledby="languages" class="dropdown-menu"><a rel="nofollow" href="#" class="dropdown-item"> <img src="img/flags/16/DE.png" alt="" class="mr-2"><span>German</span></a><a rel="nofollow" href="#" class="dropdown-item"> <img src="img/flags/16/FR.png" alt="English" class="mr-2"><span>French  </span></a></div>
	            </div>
	            <!-- Log out               -->
	            <div class="list-inline-item logout"><a id="logout" href="login.html" class="nav-link"> <span class="d-none d-sm-inline">Logout </span><i class="icon-logout"></i></a></div>
	          </div>
	        </div>
	      </nav>
	    </header>
    <div class="d-flex align-items-stretch" style="height: 875px;">
      <nav id="sidebar" style="height: 1030px;">
        <div class="sidebar-header d-flex align-items-center">
          <div class="avatar" style="width: 100px; height: 100px; align-itself: center; "><img src="${pageContext.request.contextPath}/resource/img/milk.jpg" class="img-fluid rounded-circle"></div>
          <div class="title">
            <h1 class="h5" style="color: lightgray">AIoT Project</h1>
            <p style="color: lightgray">Team 2</p>
          </div>
        </div>
        <span class="heading" style="color: lightgray">MENU</span>
        <ul class="list-unstyled">
          <li><a href="${pageContext.request.contextPath}/home/main.do" style="color: lightgray"> <i class="icon-home"></i>MAIN DASHBOARD </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/jetracer.do" style="color: lightgray"> <i class="icon-writing-whiteboard"></i>JET-RACERS </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/history.do" style="color: lightgray"> <i class="icon-grid"></i>HISTORY </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/status.do" style="color: lightgray"> <i class="icon-padnote"></i>REAL-TIME STATUS </a></li>
	      	  <li class="active"><a href="${pageContext.request.contextPath}/home/analysis.do" style="color: lightgray"> <i class="icon-chart"></i>ANALYSIS </a></li>
        </ul>
      </nav>    
	      <div class="page-content" style="top: -50px; height: 1080px; padding-bottom: 0px; " >
	      <div>
			<div style = "width:97%;  height:300px;">
	      <div id="container" class="chart_container" style="width:100%; float:left; height:280px; padding-top: 40px; padding-left: 100px;"></div>
	      <div id="container2" class="chart_container" style="width:100%; float:left; height:280px; padding-top: 40px; padding-left: 100px;"></div>
	      </div>
	      </div>
	      <script>
	      var numbers2;
	      var numbers3;
	      var numbers4;
	      var numbers5;
	    	  $.ajax({
	 				type: "POST",
	 				async: false,
	 				url: "${pageContext.request.contextPath}/home/analysisMonth.do",
	 				success: 
		   			function(monthlist){
	 					//monthlist.filter(myFunction);
	 					 numbers2 = monthlist.map(myFunction);
	 					 numbers3 = monthlist.map(myFunction2);
	 				}
	      		});
	    	  $.ajax({
	 				type: "POST",
	 				async: false,
	 				url: "${pageContext.request.contextPath}/home/analysisRegion.do",
	 				success: 
		   			function(regionlist){
	 					//monthlist.filter(myFunction);
	 					 numbers4 = regionlist.map(myFunction4);
	 					 numbers5 = regionlist.map(myFunction3);
	 				}
	      		});
	      function myFunction(value, index, array) {
	    	  return value.dactno;
	    	}
	      function myFunction2(value, index, array) {
	    	  return value.dpertime;
	    	}
	      function myFunction3(value, index, array) {
	    	  return value.dfinder;
	    	}
	      function myFunction4(value, index, array) {
	    	  return value.dperfinder;
	    	}
	      var chart = Highcharts.chart('container', {
	    	    title: {
	    	        text: '분별 탐지사건 발생수'
	    	    },

	    	    subtitle: {
	    	        text: '분별하세요'
	    	    },

	    	    xAxis: {
	    	        categories: numbers3
	    	    },

	    	    series: [{
	    	        type: 'column',
	    	        colorByPoint: true,
	    	        data: numbers2,
	    	        showInLegend: false
	    	    }]

	    	});
	      var chart = Highcharts.chart('container2', {
	    	    title: {
	    	        text: '탐지객체별 탐지사건 발생수'
	    	    },

	    	    subtitle: {
	    	        text: '감사하십시오'
	    	    },

	    	    xAxis: {
	    	        categories: numbers5
	    	    },

	    	    series: [{
	    	        type: 'column',
	    	        colorByPoint: true,
	    	        data: numbers4,
	    	        showInLegend: false
	    	    }]

	    	});

</script>
		</div>
	</div>

    
    </body>
</html>
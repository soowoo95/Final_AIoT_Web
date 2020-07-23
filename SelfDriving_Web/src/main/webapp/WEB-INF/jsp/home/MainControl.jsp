<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
  <head> 
	    <meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <title>AIOT FINAL PROJECT | TEAM 2</title>
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    
	    <!-- Bootstrap CSS-->
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/bootstrap/css/bootstrap.min.css">
	    <!-- Font Awesome CSS-->
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/font-awesome/css/font-awesome.min.css">
	    <!-- Custom Font Icons CSS-->
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/css/font.css">
	    <!-- Google fonts - Muli-->
	    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Muli:300,400,700">
	    <!-- theme stylesheet-->
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/css/style.default.css" id="theme-stylesheet">
	    <!-- Custom stylesheet - for your changes-->
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/css/custom.css">
	    <!-- Favicon-->
	    <link rel="shortcut icon" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/img/favicon.ico">
		    
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jQueryRotate.js"></script>
		
		<link href="${pageContext.request.contextPath}/resource/bootstrap/css/change.css" rel="stylesheet">
		
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		
<!-- 	 <script src="https://cdn.anychart.com/releases/v8/js/anychart-base.min.js"></script>
		  <script src="https://cdn.anychart.com/releases/v8/js/anychart-ui.min.js"></script>
		  <script src="https://cdn.anychart.com/releases/v8/js/anychart-exports.min.js"></script>
		  <script src="https://cdn.anychart.com/releases/v8/js/anychart-linear-gauge.min.js"></script>
		  <script src="https://cdn.anychart.com/releases/v8/js/anychart-table.min.js"></script>
		  <script src="https://cdn.anychart.com/releases/v8/themes/dark_provence.min.js"></script>
		  <link href="https://cdn.anychart.com/releases/v8/css/anychart-ui.min.css" type="text/css" rel="stylesheet">
		  <link href="https://cdn.anychart.com/releases/v8/fonts/css/anychart-font.min.css" type="text/css" rel="stylesheet">
		  --> 
		  
<!-- 		배터리 ui 사용할 경우
		  <script src="https://www.koolchart.com/demo/LicenseKey/KoolChartLicense.js"></script>
		  <script src="https://www.koolchart.com/demo/KoolChart/JS/KoolChart.js"></script>
		  <link rel="stylesheet" href="https://www.koolchart.com/demo/KoolChart/Assets/Css/KoolChart.css"/> -->

		 <style>
			#div1 {font-size:48px;}
		 </style>
	</head>
	
	<body>
		<header class="header"> 
	      <nav class="navbar navbar-expand-lg">
	        <div class="search-panel">
	          <div class="search-inner d-flex align-items-center justify-content-center">
	            <div class="close-btn">Close <i class="fa fa-close"></i></div>
	            <form id="searchForm" action="#">
	              <div class="form-group">
	                <input type="search" name="search" placeholder="What are you searching for...">
	                <button type="submit" class="submit">Search</button>
	              </div>
	            </form>
	          </div>
	        </div>
	        <div class="container-fluid d-flex align-items-center justify-content-between">
	          <div class="navbar-header">
	            <!-- Navbar Header--><a href="index.html" class="navbar-brand">
	              <div class="brand-text brand-big visible text-uppercase"><strong class="text-primary">Master</strong><strong>Admin</strong></div>
	              <div class="brand-text brand-sm"><strong class="text-primary">M</strong><strong>A</strong></div></a>
	          </div>
	        </div>
	      </nav>
	    </header>
	    
		<div class="d-flex align-items-stretch">
	      <!-- Sidebar Navigation-->
	      <nav id="sidebar">
	        <!-- Sidebar Header-->
	        <div class="sidebar-header d-flex align-items-center">
	          <div class="avatar"><img src="${pageContext.request.contextPath}/resource/img/cotton.jpg"class="img-fluid rounded-circle"></div>
	          <div class="title">
	            <h1 class="h5">AIoT Final Project</h1>
	            <p>Team 2</p>
	          </div>
	        </div>
	        <!-- Sidebar Navidation Menus--><span class="heading">Main</span>
	        <ul class="list-unstyled">
	          <li class="active"><a href="${pageContext.request.contextPath}/home/MainControl.do"> <i class="icon-home"></i>Home </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/history.do"> <i class="icon-grid"></i>History </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/chart.do"> <i class="fa fa-bar-chart"></i>Charts </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/status.do"> <i class="icon-padnote"></i>Status </a></li>
			<li><a href="login.html"> <i class="icon-logout"></i>Login page </a></li>
	      </nav>
	      
	  <!-- <div class="page-content">
        <div class="page-header">
          <div class="container-fluid">
            <h2 class="h5 no-margin-bottom">Master Dashboard</h2>
          </div>
        </div>
        <section class="no-padding-top no-padding-bottom">
          <div class="container-fluid">
            <div class="row">
              <div class="col-md-3 col-sm-6">
                <div class="statistic-block block">
                  <div class="progress-details d-flex align-items-end justify-content-between">
                    <div class="title">
                      <div class="icon"><i class="icon-user-1"></i></div><strong>Total Detect #</strong>
                    </div>
                    <div class="number dashtext-1">85</div>
                  </div>
                  <div class="progress progress-template">
                    <div role="progressbar" style="width: 85%" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-1"></div>
                  </div>
                </div>
              </div>
              <div class="col-md-3 col-sm-6">
                <div class="statistic-block block">
                  <div class="progress-details d-flex align-items-end justify-content-between">
                    <div class="title">
                      <div class="icon"><i class="icon-writing-whiteboard"></i></div><strong>Detect Lev.1</strong>
                    </div>
                    <div class="number dashtext-2">35</div>
                  </div>
                  <div class="progress progress-template">
                    <div role="progressbar" style="width: 35%" aria-valuenow="35" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-2"></div>
                  </div>
                </div>
              </div>
              <div class="col-md-3 col-sm-6">
                <div class="statistic-block block">
                  <div class="progress-details d-flex align-items-end justify-content-between">
                    <div class="title">
                      <div class="icon"><i class="icon-writing-whiteboard"></i></div><strong>Detect Lev.2</strong>
                    </div>
                    <div class="number dashtext-3">10</div>
                  </div>
                  <div class="progress progress-template">
                    <div role="progressbar" style="width: 10%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-3"></div>
                  </div>
                </div>
              </div>
              <div class="col-md-3 col-sm-6">
                <div class="statistic-block block">
                  <div class="progress-details d-flex align-items-end justify-content-between">
                    <div class="title">
                      <div class="icon"><i class="icon-writing-whiteboard"></i></div><strong>Detect Lev.3</strong>
                    </div>
                    <div class="number dashtext-4">40</div>
                  </div>
                  <div class="progress progress-template">
                    <div role="progressbar" style="width: 40%" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-4"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
        </div> -->

		
		<script>

			$(function(){
				client = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime().toString());
				client.onMessageArrived = onMessageArrived;
				client.connect({onSuccess:onConnect});
			});
	
			function onConnect() {
				//console.log("mqtt broker connected")
				client.subscribe("/1cctv");
				client.subscribe("/2cctv");
				client.subscribe("/3cctv");
				client.subscribe("/4cctv");
				client.subscribe("/sensor");
			}
			
			function onMessageArrived(message) {
				if(message.destinationName =="/1cctv") {
					$("#cameraView1").attr("src", "data:image/jpg;base64,"+ message.payloadString);
				}
				if(message.destinationName =="/2cctv") {
					$("#cameraView2").attr("src", "data:image/jpg;base64,"+ message.payloadString);
				}
				if(message.destinationName =="/3cctv") {
					$("#cameraView3").attr("src", "data:image/jpg;base64,"+ message.payloadString);
				}
				if(message.destinationName =="/4cctv") {
					
					const json = message.payloadString;
					const obj = JSON.parse(json);

					$("#cameraView4").attr("src", "data:image/jpg;base64,"+ obj.Cam);
					//이미지에 탐지된 클래스에 대한 정보
					//console.log(obj.Class)
					
					obj["witness"]= message.destinationName;

					if (obj.Class.length != 0){
						console.log(obj.Class.length);
						var jsonData = JSON.stringify(obj);
						$.ajax({
							type:"POST",
							url:"${pageContext.request.contextPath}/animal/saveImage.do",
							contentType: "application/json;charset=UTF-8",
							dataType: "json",
							data: jsonData
						});
					}
				}
				if(message.destinationName =="/sensor") {
					const json = message.payloadString;
					const obj = JSON.parse(json);
					$("#Battery").attr("value", obj.Battery);
				}
			}
		</script>

<!-- 
		<div class="btn-group mr-2" role="group" aria-label="First group" style="margin-left: 320px; width: 320px">
		    <button type="button" class="btn btn-secondary" onclick="view('1')">CCTV 1</button>
		    <button type="button" class="btn btn-secondary" onclick="view('2')">CCTV 2</button>
		    <button type="button" class="btn btn-secondary" onclick="view('3')">CCTV 3</button>
		    <button type="button" class="btn btn-secondary" onclick="view('4')">CCTV 4</button>
		 </div>
 -->
 		<div class="row row-cols-2" style="width: 640px; height:480px">
			<div class="col"  id="show1"><img id=cameraView1 style="width: 320px;height:240px"/></div>
			<div class="col"  id="show2"><img id=cameraView2 style="width: 320px;height:240px"/></div>
			<div class="col"  id="show3"><img id=cameraView3 style="width: 320px;height:240px"/></div>
			<div class="col"  id="show4"><img id=cameraView4 style="width: 320px;height:240px"/></div>
		</div>
		
		<div style="margin-left: 300px">
			<input id="Battery" value="">
		</div>
		
<!-- 
  		<div id="content">
			<div id="bigImages">
					<img class="big" id=cameraView1>
			</div>
			<div id="smallImages">
					<img class="small" id=cameraView2>
					<img class="small" id=cameraView3>
					<img class="small" id=cameraView4>
			</div>
		</div>
 -->	
<!-- 		<div>
			<input id="Battery" value="">
		</div>
 -->
		<script src="${pageContext.request.contextPath}/resource/jquery/change.js"></script>
</body>
</html>
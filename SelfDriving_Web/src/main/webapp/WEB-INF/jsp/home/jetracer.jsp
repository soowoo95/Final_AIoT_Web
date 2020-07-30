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
	    
	    <!--  Template 관련 설정 파일들 -->
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

		<script src="${pageContext.request.contextPath}/resource/jquery/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>

		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jQueryRotate.js"></script>
		
		<link href="${pageContext.request.contextPath}/resource/bootstrap/css/change.css" rel="stylesheet">
		
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		
		<style>
			#div1 {font-size:48px;}
			
			.no-gutters {
			  margin-right: 0;
			  margin-left: 0;
			  > .col,
			  > [class*="*cols-"] {
			    padding-right: 0;
			    padding-left: 0;
			  }
			}
			
			.raphael-group-LubRMsVW{
				opacity: 0;
				width: 0px;
			
			}
		</style>
		 
		<script>
			$(function(){
				client = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime().toString());
				client.onMessageArrived = onMessageArrived;
				client.connect({onSuccess:onConnect});
			});
			
			function onConnect() {
				console.log("mqtt broker connected")
				client.subscribe("/1jetbot");
				client.subscribe("/2jetbot");
				client.subscribe("/3jetbot");
				client.subscribe("/4cctv");
				client.subscribe("/sensor");
			}
			
			var battery = null;
			
			function onMessageArrived(message) {
				console.log("mqtt broker connected")
				
 				if(message.destinationName =="/1jetbot") {
 					const json = message.payloadString;
					const obj = JSON.parse(json);
					$("#jetbotView1").attr("src", "data:image/jpg;base64,"+ obj.Cam);
				}
				if(message.destinationName =="/2jetbot") {
					console.log("mqtt broker connected")
					const json = message.payloadString;
					const obj = JSON.parse(json);
					$("#jetbotView2").attr("src", "data:image/jpg;base64,"+ obj.Cam);
				}
				if(message.destinationName =="/3jetbot") {
					const json = message.payloadString;
					const obj = JSON.parse(json);
					$("#jetbotView3").attr("src", "data:image/jpg;base64,"+ obj.Cam);
				}
				if(message.destinationName =="/4cctv") {
					const json = message.payloadString;
					const obj = JSON.parse(json);
					$("#jetbotView4").attr("src", "data:image/jpg;base64,"+ obj.Cam);
				}
				if(message.destinationName =="/sensor") {
					console.log(message.destinationName)
					const json = message.payloadString;
					const obj = JSON.parse(json);
					console.log(obj.Battery);
					battery = obj.Battery;
					$("#battery").attr("value", obj.Battery);
			      	document.getElementById('jet1Battery').style.width = obj.Battery + '%';
				}
			}
		</script>		 
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
	            <!-- Navbar Header--><a href="${pageContext.request.contextPath}/home/main.do" class="navbar-brand">
	              <div class="brand-text brand-big visible text-uppercase" style="font-size: x-large"><strong class="text-primary">AIOT</strong><strong>Admin</strong></div>
	              <div class="brand-text brand-sm"><strong class="text-primary">A</strong><strong>A</strong></div></a>
	          </div>
	        </div>
	      </nav>
	    </header>
	    
		<div class="d-flex align-items-stretch">
	      <!-- Sidebar Navigation-->
	      <nav id="sidebar">
	        <!-- Sidebar Header-->
	        <div class="sidebar-header d-flex align-items-center">
	          <div class="avatar" style="width: 100px; height: 100px; align-itself: center; "><img src="${pageContext.request.contextPath}/resource/img/milk.jpg" class="img-fluid rounded-circle"></div>
	          <div class="title">
	            <h1 class="h5" style="color: lightgray">AIoT Project</h1>
	            <p style="color: lightgray">Team 2</p>
	          </div>
	        </div>
	        <!-- Sidebar Navidation Menus--><span class="heading" style="color:lightgray ;">MENU</span>
	        <ul class="list-unstyled">
	          <li><a href="${pageContext.request.contextPath}/home/main.do" style="color: lightgray"> <i class="icon-home"></i>MAIN DASHBOARD </a></li>
	          <li class="active"><a href="${pageContext.request.contextPath}/home/jetracer.do" style="color: lightgray"> <i class="icon-writing-whiteboard"></i>JET-RACERS </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/history.do" style="color: lightgray"> <i class="icon-grid"></i>HISTORY </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/status.do" style="color: lightgray"> <i class="icon-padnote"></i>REAL-TIME STATUS </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/analysis.do" style="color: lightgray"> <i class="icon-chart"></i>ANALYSIS </a></li>
	      </nav>
	      
	      <div class="page-content">
	     	<div class="page-header no-margin-bottom">
	          <div class="container-fluid">
	            <h2 class="h5 no-margin-bottom" style="color: lightgray">JET-RACERS</h2>
	          </div>
	        </div>
	        <!-- Breadcrumb-->
	        <div class="container-fluid">
	          <ul class="breadcrumb" style="background-color:transparent;">
	            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home/main.do" style="font-size: 20px ; margin-top: 10px; color: #DB6574; font-weight: 600;">Home</a></li>
	            
	            <li class="breadcrumb-item active" style="font-size: large; margin-top: 10px; color: lightgray">JET-RACERS        </li>
	          </ul>
	        </div>

	      	<section class="no-padding-top no-padding-bottom">
	          <div class="container-fluid">
	            <div class="row">
	              <div class="col-md-3 col-sm-6">
	                <div class="statistic-block block">
	                  <div class="progress-details d-flex align-items-end justify-content-between">
	                    <div class="title">
	                      <div class="icon"><i class="icon-user-1"></i></div><strong>Jet-Racer #1</strong>
	                    </div>
	                    <div class="number dashtext-1">33</div>
	                  </div>
	                  <div class="progress progress-template">
	                    <div id="jet1Battery" role="progressbar" style="width: 30%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-1"></div>
	                  </div>
	                </div>
	              </div>
	              <div class="col-md-3 col-sm-6">
	                <div class="statistic-block block">
	                  <div class="progress-details d-flex align-items-end justify-content-between">
	                    <div class="title">
	                      <div class="icon"><i class="icon-contract"></i></div><strong>Jet-Racer #2</strong>
	                    </div>
	                    <div class="number dashtext-2">375</div>
	                  </div>
	                  <div class="progress progress-template">
	                    <div id="jet2Battery" role="progressbar" style="width: 70%" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-2"></div>
	                  </div>
	                </div>
	              </div>
	              <div class="col-md-3 col-sm-6">
	                <div class="statistic-block block">
	                  <div class="progress-details d-flex align-items-end justify-content-between">
	                    <div class="title">
	                      <div class="icon"><i class="icon-paper-and-pencil"></i></div><strong>Jet-Racer #3</strong>
	                    </div>
	                    <div class="number dashtext-3">140</div>
	                  </div>
	                  <div class="progress progress-template">
	                    <div id="jet3Battery" role="progressbar" style="width: 55%" aria-valuenow="55" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-3"></div>
	                  </div>
	                </div>
	              </div>
	            </div>
	          </div>
	        </section>
	              
            <section style="padding-right: 0px">
	          <div class="container-fluid">
	         	<div class="container" style="position:absolute; margin-right: 0px; margin-left: 0px; width: 800px; height: 600px; margin-top: 20px;">
				  <div class="row row-cols-2">
				    <div class="col" style="padding-left: 0px; padding-right: 0px; width: 400px; height: 300px"><img id=jetbotView1 style="width: 400px; height: 300px; padding-left: 0px; padding-right: 0px"/></div>
				    <div class="col" style="padding-left: 0px; padding-right: 0px; width: 400px; height: 300px"><img id=jetbotView2 style="width: 400px; height: 300px; padding-left: 0px; padding-right: 0px"/></div>
				    <div class="col" style="padding-left: 0px; padding-right: 0px; width: 400px; height: 300px"><img id=jetbotView3 style="width: 400px; height: 300px; padding-left: 0px; padding-right: 0px"/></div>
				    <div class="col" style="padding-left: 0px; padding-right: 0px; width: 400px; height: 300px"><img id=jetbotView4 style="width: 400px; height: 300px; padding-left: 0px; padding-right: 0px"/></div>
				  </div>
				</div>
	          </div>
	        </section>
	        
           	<div style="margin-top: 650px; margin-left: 30px; color: white">
  		      Battery Status: <input id="battery" value="" style="background-color: transparent; border-color: transparent; color: white"/>
  			</div>
  			
	</body>
</html>
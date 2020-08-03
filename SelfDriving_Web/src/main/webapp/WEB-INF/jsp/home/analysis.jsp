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
		<link rel=icon href="${pageContext.request.contextPath}/resource/img/jetracer.png">
		
		<script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/bootstrap/js/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
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
		</style>
		 
		<script>
			$(function(){
				client = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime().toString());
				client.onMessageArrived = onMessageArrived;
				client.connect({onSuccess:onConnect});
			});
			
			function onConnect() {
				console.log("mqtt broker connected")
				client.subscribe("/1cctv");
				client.subscribe("/2cctv");
				client.subscribe("/3cctv");
				client.subscribe("/4cctv");
			}
			
			function onMessageArrived(message) {
 				if(message.destinationName =="/1cctv") {
 					const json = message.payloadString;
					const obj = JSON.parse(json);
					obj["witness"]= message.destinationName;
					
					$("#cameraView1").attr("src", "data:image/jpg;base64,"+ obj.Cam);
					
					if (obj.Class.length != 0){
						console.log(obj.Class.length);
						
						$("#c1Obj").attr("value", obj.Class);
						document.getElementById('c1Obj').style.color = '#DB6574';
						document.getElementById('c1Obj').style.fontWeight = 'bold';
						document.getElementById('c1Obj').style.fontSize = '20px';
						
						$("#c1Lev").attr("value", "등급이 몰까");
						document.getElementById('c1Lev').style.color = '#DB6574';
						document.getElementById('c1Lev').style.fontWeight = 'bold';
						document.getElementById('c1Lev').style.fontSize = '20px';
						
						$("#c1Loc").attr("value", "1번 CCTV 촬영 구간");
						document.getElementById('c1Loc').style.color = '#DB6574';
						document.getElementById('c1Loc').style.fontWeight = 'bold';
						document.getElementById('c1Loc').style.fontSize = '20px';
						
						if (obj["witness"].replace("/","") == "1cctv"){
							document.getElementById('cameraView1').style.border = '8px solid red';
						}
					}

					if (obj.Class.length == 0){
						$("#c1Obj").attr("value","*****  탐지대상 없음  *****");
						document.getElementById('c1Obj').style.color = 'white';
						document.getElementById('c1Obj').style.fontSize = 'medium';
						document.getElementById('c1Obj').style.fontSize = '15px';
						
						$("#c1Lev").attr("value","*****  해당사항 없음  *****");
						document.getElementById('c1Lev').style.color = 'white';
						document.getElementById('c1Lev').style.fontSize = 'medium';
						document.getElementById('c1Lev').style.fontSize = '15px';
						
						$("#c1Loc").attr("value","*****  해당사항 없음  *****");
						document.getElementById('c1Loc').style.color = 'white';
						document.getElementById('c1Loc').style.fontSize = 'medium';
						document.getElementById('c1Loc').style.fontSize = '15px';
						
						document.getElementById('cameraView1').style.border = 'inactiveborder';
					}
				}
 				
				if(message.destinationName =="/2cctv") {
					const json = message.payloadString;
					const obj = JSON.parse(json);
					obj["witness"]= message.destinationName;
					
					$("#cameraView1").attr("src", "data:image/jpg;base64,"+ obj.Cam);
					$("#cameraView2").attr("src", "data:image/jpg;base64,"+ obj.Cam);
					
					if (obj.Class.length != 0){
						console.log(obj.Class.length);
						
						$("#c2Obj").attr("value", obj.Class);
						document.getElementById('c2Obj').style.color = '#DB6574';
						document.getElementById('c2Obj').style.fontWeight = 'bold';
						document.getElementById('c2Obj').style.fontSize = '20px';
						
						$("#c2Lev").attr("value", "등급이 몰까");
						document.getElementById('c2Lev').style.color = '#DB6574';
						document.getElementById('c2Lev').style.fontWeight = 'bold';
						document.getElementById('c2Lev').style.fontSize = '20px';
						
						$("#c2Loc").attr("value", "2번 CCTV 촬영 구간");
						document.getElementById('c2Loc').style.color = '#DB6574';
						document.getElementById('c2Loc').style.fontWeight = 'bold';
						document.getElementById('c2Loc').style.fontSize = '20px';
						
						if (obj["witness"].replace("/","") == "2cctv"){
							document.getElementById('cameraView2').style.border = '8px solid red';
						}
					}
					
					if (obj.Class.length == 0){
						$("#c2Obj").attr("value","*****  탐지대상 없음  *****");
						document.getElementById('c2Obj').style.color = 'white';
						document.getElementById('c2Obj').style.fontSize = 'medium';
						document.getElementById('c2Obj').style.fontSize = '15px';
						
						$("#c2Lev").attr("value","*****  해당사항 없음  *****");
						document.getElementById('c2Lev').style.color = 'white';
						document.getElementById('c2Lev').style.fontSize = 'medium';
						document.getElementById('c2Lev').style.fontSize = '15px';
						
						$("#c2Loc").attr("value","*****  해당사항 없음  *****");
						document.getElementById('c2Loc').style.color = 'white';
						document.getElementById('c2Loc').style.fontSize = 'medium';
						document.getElementById('c2Loc').style.fontSize = '15px';

						document.getElementById('cameraView2').style.border = 'inactiveborder';
					}
				}
				
				if(message.destinationName =="/3cctv") {
					const json = message.payloadString;
					const obj = JSON.parse(json);
					obj["witness"]= message.destinationName;
					
					$("#cameraView3").attr("src", "data:image/jpg;base64,"+ obj.Cam);
					
					if (obj.Class.length != 0){
						console.log(obj.Class.length);
						
						$("#c3Obj").attr("value", obj.Class);
						document.getElementById('c3Obj').style.color = '#DB6574';
						document.getElementById('c3Obj').style.fontWeight = 'bold';
						document.getElementById('c3Obj').style.fontSize = '20px';
						
						$("#c3Lev").attr("value", "등급이 몰까");
						document.getElementById('c3Lev').style.color = '#DB6574';
						document.getElementById('c3Lev').style.fontWeight = 'bold';
						document.getElementById('c3Lev').style.fontSize = '20px';
						
						$("#c3Loc").attr("value", "3번 CCTV 촬영 구간");
						document.getElementById('c3Loc').style.color = '#DB6574';
						document.getElementById('c3Loc').style.fontWeight = 'bold';
						document.getElementById('c3Loc').style.fontSize = '20px';
						
						if (obj["witness"].replace("/","") == "3cctv"){
							document.getElementById('cameraView3').style.border = '8px solid red';
						}
					}

					if (obj.Class.length == 0){
						$("#c3Obj").attr("value","*****  탐지대상 없음  *****");
						document.getElementById('c3Obj').style.color = 'white';
						document.getElementById('c3Obj').style.fontSize = 'medium';
						document.getElementById('c3Obj').style.fontSize = '15px';
						
						$("#c3Lev").attr("value","*****  해당사항 없음  *****");
						document.getElementById('c3Lev').style.color = 'white';
						document.getElementById('c3Lev').style.fontSize = 'medium';
						document.getElementById('c3Lev').style.fontSize = '15px';
						
						$("#c3Loc").attr("value","*****  해당사항 없음  *****");
						document.getElementById('c3Loc').style.color = 'white';
						document.getElementById('c3Loc').style.fontSize = 'medium';
						document.getElementById('c3Loc').style.fontSize = '15px';

						document.getElementById('cameraView3').style.border = 'inactiveborder';
					}
				}
				
				if(message.destinationName =="/4cctv") {
					const json = message.payloadString;
					const obj = JSON.parse(json);
					obj["witness"]= message.destinationName;
					
					$("#cameraView4").attr("src", "data:image/jpg;base64,"+ obj.Cam);
					//이미지에 탐지된 클래스에 대한 정보
					//console.log(obj.Class)

					if (obj.Class.length != 0){
						console.log(obj.Class.length);
						
						$("#c4Obj").attr("value", obj.Class);
						document.getElementById('c4Obj').style.color = '#DB6574';
						document.getElementById('c4Obj').style.fontWeight = 'bold';
						document.getElementById('c4Obj').style.fontSize = '20px';
						
						$("#c4Lev").attr("value", "등급이 몰까");
						document.getElementById('c4Lev').style.color = '#DB6574';
						document.getElementById('c4Lev').style.fontWeight = 'bold';
						document.getElementById('c4Lev').style.fontSize = '20px';
						
						$("#c4Loc").attr("value", "4번 CCTV 촬영 구간");
						document.getElementById('c4Loc').style.color = '#DB6574';
						document.getElementById('c4Loc').style.fontWeight = 'bold';
						document.getElementById('c4Loc').style.fontSize = '20px';
						
						if (obj["witness"].replace("/","") == "4cctv"){
							document.getElementById('cameraView4').style.border = '8px solid red';
						}
					}
					
					if (obj.Class.length == 0){
						$("#c4Obj").attr("value","*****  탐지대상 없음  *****");
						document.getElementById('c4Obj').style.color = 'white';
						document.getElementById('c4Obj').style.fontWeight = 'normal';
						document.getElementById('c4Obj').style.fontSize = '15px';
						
						$("#c4Lev").attr("value","*****  해당사항 없음  *****");
						document.getElementById('c4Lev').style.color = 'white';
						document.getElementById('c4Lev').style.fontWeight = 'normal';
						document.getElementById('c4Lev').style.fontSize = '15px';
						
						$("#c4Loc").attr("value","*****  해당사항 없음  *****");
						document.getElementById('c4Loc').style.color = 'white';
						document.getElementById('c4Loc').style.fontWeight = 'normal';
						document.getElementById('c4Loc').style.fontSize = '15px';
						
						document.getElementById('cameraView4').style.border = 'inactiveborder'; 
					}
				}
			}
		</script>
	</head>
	
	<body>
	<header class="header">   
	      <nav class="navbar navbar-expand-lg">
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
        <!-- Sidebar Navidation Menus--><span class="heading" style="color: lightgray">MENU</span>
        <ul class="list-unstyled">
          <li><a href="${pageContext.request.contextPath}/home/main.do" style="color: lightgray"> <i class="icon-home"></i>MAIN DASHBOARD </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/jetracer.do" style="color: lightgray"> <i class="icon-writing-whiteboard"></i>JET-RACERS </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/history.do" style="color: lightgray"> <i class="icon-grid"></i>HISTORY </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/status.do" style="color: lightgray"> <i class="icon-padnote"></i>REAL-TIME STATUS </a></li>
	      	  <li class="active"><a href="${pageContext.request.contextPath}/home/analysis.do" style="color: lightgray"> <i class="icon-chart"></i>ANALYSIS </a></li>
        </ul>
      </nav>
      <!-- Sidebar Navigation end-->	    
	      <div class="page-content">


		</div>
	</div>
	
    <!-- JavaScript files-->
    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/popper.js/umd/popper.min.js"> </script>
    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/jquery.cookie/jquery.cookie.js"> </script>
    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/jquery-validation/jquery.validate.min.js"></script>
    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/js/front.js"></script>
    
    </body>
</html>
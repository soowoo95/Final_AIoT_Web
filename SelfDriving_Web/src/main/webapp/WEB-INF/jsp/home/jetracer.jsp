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

		<script src="${pageContext.request.contextPath}/resource/jquery/jquery-3.4.1.min.js" crossorigin="anonymous"></script>
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		
<%-- 		<script src="${pageContext.request.contextPath}/resource/js/manual_control.js" ></script>  --%>
		
		<!--  Template 관련 설정 파일들 -->
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/popper.js/umd/popper.min.js"> </script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/bootstrap/js/bootstrap.min.js"></script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/jquery.cookie/jquery.cookie.js"> </script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/jquery-validation/jquery.validate.min.js"></script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/js/front.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js"></script>
	    
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/bootstrap/css/bootstrap.min.css">
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/font-awesome/css/font-awesome.min.css">
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/css/font.css">
	    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Muli:300,400,700">
		<link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/css/style.default.css" id="theme-stylesheet">
	    <link rel=icon href="${pageContext.request.contextPath}/resource/img/jetracer.png">
	    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/yunjis.css">

		<script>
			$(function(){
				client = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime().toString());
				client.onMessageArrived = onMessageArrived;
				client.connect({onSuccess:onConnect});
			});
			
			function onConnect() {
				console.log("mqtt broker connected")
				client.subscribe("/1jetracer");
				client.subscribe("/1jr");
				client.subscribe("/2jetracer");
				client.subscribe("/2jr");
				client.subscribe("/3jetracer");
				client.subscribe("/3jr");
				client.subscribe("/3jr");
			}
			
			function onMessageArrived(message) {
				if(message.destinationName =="/mirror") {
					const json = message.payloadString;
 					const obj = JSON.parse(json);
					$("#mirrorView").attr("src", "data:image/jpg;base64,"+ obj.Cam);
					if(obj.direction=="left"){
						location.href="main.do";
					}else if (obj.direction=="right"){
						location.href="history.do";
					}
				}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////		jetracer #1 	/////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 				if(message.destinationName =="/1jetracer") {
 					$("#jetView1").attr("src", "data:image/jpg;base64,"+ message.payloadString);
					//$("#driveView1").attr("src", "data:image/jpg;base64,"+ message.payloadString);
				}

 				if(message.destinationName =="/1jr") {
 					const json = message.payloadString;
 					const obj = JSON.parse(json);
				/////////////////////////////////////////////////		배터리 상태		///////////////////////////////////////////////////////////////////////
					bat1 = obj.battery;
			      	bat1 = parseInt(bat1);
					//console.log("battery1:",obj.battery, "%");
			      	
			      	if (bat1 >= 100){
			      		bat1 == 100;
			      		document.getElementById('batt').style.backgroundColor = 'dimgray';
			      		document.getElementById('batt').style.opacity = '0.9';
			      		document.getElementById('batt').style.color = 'white';
			      		document.getElementById('adtt').style.backgroundColor = 'red';
			      		document.getElementById('jet1Battery').style.width = bat1 + '%';
			      		$("#batt").attr("value", "Battery");
			      		$("#jetRacerText1").text("100%");
			      	}
			      	else if (40<bat1 && bat1<100){
			      		document.getElementById('batt').style.backgroundColor = '#ADFF2F';
			      		document.getElementById('batt').style.color = 'black';
			      		document.getElementById('adtt').style.backgroundColor = 'dimgray';
			      		document.getElementById('adtt').style.opacity = '0.9';
			      		document.getElementById('jet1Battery').style.width = String(bat1) + '%';
			      		$("#batt").attr("value", "Battery");
			      		$("#jetRacerText1").text(String(bat1) + "%");
			      	}
			      	else if (bat1 <= 40){
			      		document.getElementById('batt').style.backgroundColor = 'red';
			      		document.getElementById('batt').style.color = 'white';
			      		document.getElementById('adtt').style.backgroundColor = 'dimgray';
			      		document.getElementById('adtt').style.opacity = '0.9';
			      		document.getElementById('vacant').style.backgroundColor ="transparent";
			      		document.getElementById('jet1Battery').style.width = String(bat1) + '%';
			      		$("#batt").attr("value", "CHARGE NOW !!!");
			      		$("#jetRacerText1").text(String(bat1) + "%");
			      	}
				/////////////////////////////////////////////////		dc speed		///////////////////////////////////////////////////////////////////
					speed1 = obj.speed;
			      	speed1=Math.round(speed1);
			      	//console.log("speed:", speed1);
			      	if(speed1 < 40){
			      		$("#MotorSpeed").text(0 +" km/h");
			      	}
			      	else if(40 <= speed1){
			      		$("#MotorSpeed").text(speed1 +" km/h");
			      	}
				/////////////////////////////////////////////////		주행 구역		///////////////////////////////////////////////////////////////////////
			      	//area1 = obj.area;
			   		var text = "";
					var possible = "ABCDEFGHIJKLMNOPQRST";
					text = possible.charAt(Math.floor(Math.random() * possible.length));
			      	$("#district1").text("Zone " + text);

				/////////////////////////////////		외부 온도		///////////////////////////////////////////////////////////////////////
			      	//temp1 = obj.temp;
			      	temp1 = parseInt(((Math.random()*10+1))+20);
			      	$("#Temperature").text(temp1 +" °C");
				}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////		jetracer #2		/////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				if(message.destinationName =="/2jetracer") {
					const json = message.payloadString;
 					const obj = JSON.parse(json);
					$("#jetView2").attr("src", "data:image/jpg;base64,"+ obj.Cam);
				}
				
				
				if(message.destinationName =="/2jr") {
					//console.log("2jr 들어오고 있음");
 					const json = message.payloadString;
 					const obj = JSON.parse(json);
				/////////////////////////////////////////////////		배터리 상태		///////////////////////////////////////////////////////////////////////
					//console.log("battery2:",obj.battery, "%");
					bat2 = obj.battery;
					//$("#jetRacerText1").text(bat1 + "%");
			      	bat2 = parseInt(bat2);
			      	
			      	if (bat2 >= 100){
			      		bat2 == 100;
			      		document.getElementById('batt2').style.backgroundColor = 'dimgray';
			      		document.getElementById('batt2').style.opacity = '0.9';
			      		document.getElementById('batt2').style.color = 'white';
			      		document.getElementById('adtt2').style.backgroundColor = 'red';
			      		document.getElementById('jet2Battery').style.width = bat2 + '%';
			      		$("#batt2").attr("value", "Battery");
			      		$("#jetRacerText2").text("100%");
			      	}
			      	else if (40<bat2 && bat2<100){
			      		document.getElementById('batt2').style.backgroundColor = '#ADFF2F';
			      		document.getElementById('batt2').style.color = 'black';
			      		document.getElementById('adtt2').style.backgroundColor = 'dimgray';
			      		document.getElementById('adtt2').style.opacity = '0.9';
			      		document.getElementById('jet2Battery').style.width = String(bat2) + '%';
			      		$("#batt2").attr("value", "Battery");
			      		$("#jetRacerText2").text(String(bat2) + "%");
			      	}
			      	else if (bat2 <= 40){
			      		document.getElementById('batt2').style.backgroundColor = 'red';
			      		document.getElementById('batt2').style.color = 'white';
			      		document.getElementById('adtt2').style.backgroundColor = 'dimgray';
			      		document.getElementById('adtt2').style.opacity = '0.9';
			      		document.getElementById('vacant2').style.backgroundColor ="transparent";
			      		document.getElementById('jet2Battery').style.width = String(bat2) + '%';
			      		$("#batt2").attr("value", "CHARGE NOW !!!");
			      		$("#jetRacerText2").text(String(bat2) + "%");
			      	}
	
				/////////////////////////////////////////////////		dc speed		///////////////////////////////////////////////////////////////////
					speed2 = obj.speed;
			      	speed2=Math.round(speed2);
			      	
			      	if(speed2 < 40){
			      		$("#MotorSpeed2").text(0 +" km/h");
			      		//$("#MotorSpeed").attr("value", 0 +" km/h");
			      	}
			      	else if(40 <= speed2){
			      		$("#MotorSpeed2").text(speed2 +" km/h");
			      		//$("#MotorSpeed").attr("value", speed1 +" km/h");
			      	}
			      	//console.log("speed:", speed1);

				/////////////////////////////////////////////////		주행 구역		///////////////////////////////////////////////////////////////////////
			      	//area1 = obj.area;
			   		var text2 = "";
					var possible = "ABCDEFGHIJKLMNOPQRST";
					text2 = possible.charAt(Math.floor(Math.random() * possible.length));
					//console.log(text);
			      	$("#district2").text("Zone " + text2);
			      	//document.getElementById('jet1District').style.width = (area1*5) + '%';

				/////////////////////////////////////////////////		외부 온도		///////////////////////////////////////////////////////////////////////
			      	//temp1 = obj.temp;
			      	temp2 = parseInt(((Math.random()*10+1))+20);
			      	$("#Temperature2").text(temp2 +" °C");
			      	//$("#Temperature").attr("value", temp1 +" °C");
				}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////		jetracer #3		/////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

				if(message.destinationName =="/3jetracer") {
					const json = message.payloadString;
 					const obj = JSON.parse(json);
					$("#jetView3").attr("src", "data:image/jpg;base64,"+ obj.Cam);
				}
				
				if(message.destinationName =="/3jr") {
					const json = message.payloadString;
 					const obj = JSON.parse(json);
 					bat3 = obj.battery;
 					bat3 = parseInt(bat3);

			      	if (bat3 >= 100){
			      		bat3 == 100;
			      		document.getElementById('batt3').style.backgroundColor = 'dimgray';
			      		document.getElementById('batt3').style.opacity = '0.9';
			      		document.getElementById('batt3').style.color = 'white';
			      		document.getElementById('adtt3').style.backgroundColor = 'red';
			      		document.getElementById('jet3Battery').style.width = bat3 + '%';
			      		$("#batt3").attr("value", "Battery");
			      		$("#jetRacerText3").text("100%");
			      	}
			      	else if (40<bat3 && bat3<100){
			      		document.getElementById('batt3').style.backgroundColor = '#ADFF2F';
			      		document.getElementById('batt3').style.color = 'black';
			      		document.getElementById('adtt3').style.backgroundColor = 'dimgray';
			      		document.getElementById('adtt3').style.opacity = '0.9';
			      		document.getElementById('jet3Battery').style.width = String(bat3) + '%';
			      		$("#batt3").attr("value", "Battery");
			      		$("#jetRacerText3").text(String(bat3) + "%");
			      	}
			      	else if (bat3 <= 40){
			      		document.getElementById('batt3').style.backgroundColor = 'red';
			      		document.getElementById('batt3').style.color = 'white';
			      		document.getElementById('adtt3').style.backgroundColor = 'dimgray';
			      		document.getElementById('adtt3').style.opacity = '0.9';
			      		document.getElementById('vacant3').style.backgroundColor ="transparent";
			      		document.getElementById('jet3Battery').style.width = String(bat3) + '%';
			      		$("#batt3").attr("value", "CHARGE NOW !!!");
			      		$("#jetRacerText3").text(String(bat3) + "%");
			      	}
	
				/////////////////////////////////////////////////		dc speed		///////////////////////////////////////////////////////////////////
					speed3 = obj.speed;
			      	speed3=Math.round(speed2);
			      	
			      	if(speed3 < 40){
			      		$("#MotorSpeed3").text(0 +" km/h");
			      	}
			      	else if(40 <= speed3){
			      		$("#MotorSpeed3").text(speed3 +" km/h");
			      	}

				/////////////////////////////////////////////////		주행 구역		///////////////////////////////////////////////////////////////////////
			      	//area1 = obj.area;
			   		var text3 = "";
					var possible = "ABCDEFGHIJKLMNOPQRST";
					text3 = possible.charAt(Math.floor(Math.random() * possible.length));
			      	$("#district3").text("Zone " + text3);
			      	
				/////////////////////////////////////////////////		외부 온도		///////////////////////////////////////////////////////////////////////
			      	temp3 = parseInt(((Math.random()*10+1))+20);
			      	$("#Temperature3").text(temp3 +" °C");
				}
			}
 			
			/////////////////////////////////////////////////		매뉴얼 컨트롤 모드 변경		///////////////////////////////////////////////////////////////////////						
			
			function manual(value){
				console.log(value);
				
				if (value == 'On'){
					document.getElementById('modeOn').style.backgroundColor = '#ADFF2F';
					document.getElementById('modeOn').style.color = 'black';
					document.getElementById('modeOff').style.backgroundColor = 'dimgray';
					document.getElementById('modeOff').style.color = 'white';
					document.getElementById('manual_control').style.display = 'block';
					
					alert("Converting to Manual Driving Mode-1");
					
					$(document).keydown(function(event) {
						if (event.keyCode == '38') {
						  	console.log("달리자")
						  	$("#up").css("background-color", "#FFF8DC");
		 				  	message = new Paho.MQTT.Message("speed:"+ 40);
							message.destinationName = "/1manual/go";
							message.qos = 0;
							client.send(message);
						}
					
						if (event.keyCode == '40') { 		
						    console.log("멈추거라")
		 				  	message = new Paho.MQTT.Message("speed:" + 0);
							message.destinationName = "/1manual/stop";
							message.qos = 0;
							client.send(message);
						}
					});
					
					document.onkeydown = onkeydown_handler;
					document.onkeyup = onkeyup_handler;

					function onkeydown_handler(event) {
						var keycode = event.which || event.keycode;
						console.log(keycode);
						if(keycode == 87 || keycode== 65 || keycode== 83 || keycode== 68){		//카메라 제어
							if(keycode == 83){					//앞
								$("#cameradown").css("background-color", "#FFF8DC");
								var topic="command/camera/front";
							} else if(keycode == 65){			//왼쪽
								$("#cameraleft").css("background-color", "#FFF8DC");
								console.log(keycode);
								var topic="command/camera/left";
							} else if(keycode == 87){			//뒤
								$("#cameraup").css("background-color", "#FFF8DC");
								var topic="command/camera/back";
							} else if(keycode == 68){			//오른쪽
								$("#cameraright").css("background-color", "#FFF8DC");
								var topic="command/camera/right";
							}
							message = new Paho.MQTT.Message("camera");
							message.destinationName = topic;
							client.send(message);
						}
						if(keycode == 37 || keycode == 39) {
							if(keycode == 37) {
								//left
								$("#left").css("background-color", "#FFF8DC");
								var topic = "command/frontTire/left";
								console.log(topic);
							}else if(keycode == 39) {
								//right
								$("#right").css("background-color", "#FFF8DC");
								topic = "command/frontTire/right";
								console.log(topic);
							}
							message = new Paho.MQTT.Message("frontTire");
							message.destinationName = topic;
							client.send(message);
						}
						if(keycode == 38 || keycode == 40 || keycode == 32) {
							if(keycode == 38) {
								// up
								$("#up").css("background-color", "#FFF8DC");
								var topic = "command/backTire/forward";
							} else if(keycode == 40) {
								// down
								$("#down").css("background-color", "#FFF8DC");
								var topic = "command/backTire/backward";
							} else if(keycode == 32) {
								//spacebar
								stopped = true;
								var topic = "command/backTire/stop";
							}
							message = new Paho.MQTT.Message("backTire");
							message.destinationName = topic;
							client.send(message);
						}
						if(keycode == 100 || keycode == 102) {		// 거리 센서 제어
							if(keycode == 100) {					//좌
								$("#sonicleft").css("background-color", "#FFF8DC");
								var topic = "command/distance/left";
							} else if(keycode == 102) {				//우
								$("#sonicright").css("background-color", "#FFF8DC");
								var topic = "command/distance/right";
							} 
							message = new Paho.MQTT.Message("distance");
							message.destinationName = topic;
							client.send(message);
						}
					}

					function onkeyup_handler(event) {
						var keycode = event.which || event.keycode;
						if(keycode == 37 || keycode == 39) {
							$("#left").css("background-color", "");
							$("#right").css("background-color", "");
							var topic = "command/frontTire/front";
							message = new Paho.MQTT.Message("frontTire");
							message.destinationName = topic;
							client.send(message);
						}
						if(keycode == 38 || keycode == 40) {
							$("#up").css("background-color", "");
							$("#down").css("background-color", "");
							var topic = "command/backTire/respeed";
							message = new Paho.MQTT.Message("backTire");
							message.destinationName = topic;
							client.send(message);
						}
						if(keycode == 87 || keycode== 65 || keycode== 83 || keycode== 68) {
							$("#cameraup").css("background-color", "");
							$("#cameradown").css("background-color", "");
							$("#cameraright").css("background-color", "");
							$("#cameraleft").css("background-color", "");
						}
						if(keycode == 100 || keycode == 102) {
							$("#sonicleft").css("background-color", "");
							$("#sonicright").css("background-color", "");
						}
					}
					
					
					
				}
				
				else if (value == 'Off'){
					document.getElementById('modeOn').style.backgroundColor = 'dimgray';
					document.getElementById('modeOn').style.color = 'white';
					document.getElementById('modeOff').style.backgroundColor = '#ADFF2F';
					document.getElementById('modeOff').style.color = 'black';
					document.getElementById('manual_control').style.display = 'none';
					alert("Converting to Auto Driving Mode-1");

					message = new Paho.MQTT.Message(value);
					message.destinationName = "/1manual/mode";
					message.qos = 0;
					client.send(message);
				}
			}
			
			function manual2(value){
				console.log(value);
				if (value == 'On'){
					document.getElementById('modeOn2').style.backgroundColor = '#ADFF2F';
					document.getElementById('modeOn2').style.color = 'black';
					document.getElementById('modeOff2').style.backgroundColor = 'dimgray';
					document.getElementById('modeOff2').style.color = 'white';
					document.getElementById('manual_control2').style.display = 'block';
					
					alert("Converting to Manual Driving Mode-2");

					$(document).keydown(function(event) {
						if (event.keyCode == '37'){
						  	console.log("달리자2");
		 				  	message = new Paho.MQTT.Message("speed");
							message.destinationName = "/2manual/go";
							message.qos = 0;
							client.send(message);
							console.log(message);
						}
						if (event.keyCode == '39'){ 	
							console.log("멈추자2");
		 				  	message = new Paho.MQTT.Message("speed");
							message.destinationName = "/2manual/stop";
							message.qos = 0;
							client.send(message);
						}
						if (event.keyCode == '65'){
						  	console.log("toL");
		 				  	message = new Paho.MQTT.Message("lineChangeToL");
							message.destinationName = "/2manual/toL";
							message.qos = 0;
							client.send(message);
							console.log(message);
						}
						if (event.keyCode == '83'){ 	
							console.log("toR");
		 				  	message = new Paho.MQTT.Message("lineChangeToR");
							message.destinationName = "/2manual/toR";
							message.qos = 0;
							client.send(message);
						}
					});
				}
			
				else if (value == 'Off'){
					document.getElementById('modeOn2').style.backgroundColor = 'dimgray';
					document.getElementById('modeOn2').style.color = 'white';
					document.getElementById('modeOff2').style.backgroundColor = '#ADFF2F';
					document.getElementById('modeOff2').style.color = 'black';
					document.getElementById('manual_control2').style.display = 'none';
					alert("Converting to Auto Driving Mode-2");

					message = new Paho.MQTT.Message(value);
					message.destinationName = "/2manual/mode";
					message.qos = 0;
					client.send(message);
				}
			};
			
			function manual3(value){
				console.log(value);
				if (value == 'On'){
					document.getElementById('modeOn3').style.backgroundColor = '#ADFF2F';
					document.getElementById('modeOn3').style.color = 'black';
					document.getElementById('modeOff3').style.backgroundColor = 'dimgray';
					document.getElementById('modeOff3').style.color = 'white';
					document.getElementById('manual_control3').style.display = 'block';

					alert("Converting to Manual Driving Mode");
					
					$(document).keydown(function(event) {
						if (event.keyCode == '38') {
						  	console.log("달리자3")
		 				  	message = new Paho.MQTT.Message("speed:"+ 40);
							message.destinationName = "/3manual/go";
							message.qos = 0;
							client.send(message);
						}
					
						if (event.keyCode == '40') { 		
						    console.log("멈추거라3")
		 				  	message = new Paho.MQTT.Message("speed:" + 0);
							message.destinationName = "/3manual/stop";
							message.qos = 0;
							client.send(message);
						}
					});
				}
				
				else if (value == 'Off'){
					document.getElementById('modeOn3').style.backgroundColor = 'dimgray';
					document.getElementById('modeOn3').style.color = 'white';
					document.getElementById('modeOff3').style.backgroundColor = '#ADFF2F';
					document.getElementById('modeOff3').style.color = 'black';
					document.getElementById('manual_control3').style.display = 'none';
					alert("Converting to Auto Driving Mode");

					message = new Paho.MQTT.Message(value);
					message.destinationName = "/3manual/mode";
					message.qos = 0;
					client.send(message);
				}
			}
		</script>
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
	            <button class="sidebar-toggle"><i class="fa fa-long-arrow-left"></i></button>
	          </div>
	          <div class="right-menu list-inline no-margin-bottom">    
	            <div class="list-inline-item dropdown"><a id="languages" rel="nofollow" data-target="#" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link language dropdown-toggle"><img src="img/flags/16/GB.png" alt=""><span class="d-none d-sm-inline-block">LOGIN</span></a>
	              <div aria-labelledby="languages" class="dropdown-menu"><a rel="nofollow" href="#" class="dropdown-item"> <img src="img/flags/16/DE.png" alt="" class="mr-2"><span>German</span></a><a rel="nofollow" href="#" class="dropdown-item"> <img src="img/flags/16/FR.png" alt="English" class="mr-2"><span>French  </span></a></div>
	            </div>
	            <div class="list-inline-item logout"><a id="logout" href="login.html" class="nav-link"> <span class="d-none d-sm-inline">Logout </span><i class="icon-logout"></i></a></div>
	          </div>
	        </div>
	      </nav>
	    </header>
	    
		<div class="d-flex align-items-stretch" style="height: 875px;">
	      <nav id="sidebar" style="height: 1030px;">
	        <!-- Sidebar Header-->
	        <div class="sidebar-header d-flex align-items-center">
	          <div class="avatar" style="width: 100px; height: 100px; align-itself: center"><img src="${pageContext.request.contextPath}/resource/img/milk.jpg" class="img-fluid rounded-circle"></div>
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
	       	</ul>
	      </nav>
	      
	      <div class="page-content" style="top: -50px; height: 1080px; padding-bottom: 0px; ">
	      
			<div style="margin-top: 65px">
			  <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist" style="max-width: 100%; margin-left: 30px" >
				  <li class="nav-item" role="presentation" style="width: 33%; text-align: center">
				    <a class="nav-link active" id="jet-racer1-tab" data-toggle="pill" href="#jet-racer1" role="tab" aria-controls="jet-racer1" aria-selected="true" style="font-weight: bold; font-size: large">Jet-Racer #1</a>
				  </li>
				  <li class="nav-item" role="presentation" style="width: 33%; text-align: center">
				    <a class="nav-link" id="jet-racer2-tab" data-toggle="pill" href="#jet-racer2" role="tab" aria-controls="jet-racer2" aria-selected="false" style="font-weight: bold; font-size: large;">Jet-Racer #2</a>
				  </li>
				  <li class="nav-item" role="presentation" style="width: 33%; text-align: center">
				    <a class="nav-link" id="jet-racer3-tab" data-toggle="pill" href="#jet-racer3" role="tab" aria-controls="jet-racer3" aria-selected="false" style="font-weight: bold; font-size: large;">Jet-Racer #3</a>
				  </li>
		      </ul>
	      	</div>

			<div class="tab-content" id="pills-tabContent" style="height: 944px; margin-left: 25px; margin-right: 25px;  border-color: dimgray; border-style:solid; border-width:medium; ">
			  
		  	<!-- jet racer # 1 -->
		  	<div class="tab-pane fade show active" id="jet-racer1" role="tabpanel" aria-labelledby="jet-racer1-tab">
  				
  				<div style="background-color: dimgray; height: 900px; width: 1200px; position: absolute; margin-left:22px; margin-top: 22px; text-align: center; font-weight: bolder; font-size: 300px;">여기에 HUD</div>
  				
  				<input value="Battery Charging Status" readonly="readonly" style="border-color: transparent ; background-color: #864DD9 ; text-align: center; color: white; font-weight: bold;justify-content: center;width: 320px; position: absolute; top: 150px; left: 1260px; height: 30px;">
  				<div style="position: absolute; top: 180px; left: 1260px; height: 30px; display: flex; flex-direction:  row;">
            		<div>
            			<input value="Battery" readonly="readonly" style="border-color: transparent; background-color: #ADFF2F; text-align: center; color: black;  font-weight: bold;justify-content: center; width: 160px; height: 50px">
            		</div>
					<div>
						<input value="Adapter Connected" readonly="readonly" style="border-color: transparent; background-color:dimgray; text-align: center; color: white;  font-weight: bold;justify-content: center;width: 160px; height: 50px">
					</div>
	           	</div>
  				
  				<input value="Motion Detection" readonly="readonly" style="border-color: transparent ; background-color: #864DD9 ; text-align: center; color: white;  font-weight: bold;justify-content: center;width: 320px; position: absolute; top: 250px; left: 1260px; height: 30px;">
  				<img id=driveView2 style="width: 320px; height: 280px; position: absolute; top: 280px; left: 1260px"/>
				
				<section class="no-padding-top no-padding-bottom" style="top:560px; left: 1260px; position: absolute;padding: 0px">
		          <div class="container-fluid">
		            <div class="row" style="width: 320px; height: 200px" >
		              <div class="col-md-3 col-sm-6" style="padding: 0px">
		                <div class="statistic-block block" style="justify-content: center; padding: 0px; width: 320px; margin-bottom: 10px">
		                  <div class="progress-details d-flex align-items-end justify-content-between" style="justify-content: center;height: 80px; padding: 0px">
		                    <div class="title" style="justify-content: center; margin: 15px">
		                      <div class="icon"><i class="icon-info"></i></div><strong style="color: white">Detected Motion</strong>
		                    </div>
		                    <div id="district1" style="color: #864DD9; font-size: x-large;  font-weight:bold; ; margin-right: 15px; margin-bottom: 15px">
		                    	STOP
		                    </div>
		                 </div>
		                </div>
 		                <div class="statistic-block block" style="justify-content: center; padding: 0px; width: 320px">
		                  <div class="progress-details d-flex align-items-end justify-content-between" style="justify-content: center; height: 80px">
		                    <div class="title" style="justify-content: center; margin: 15px">
		                      <div class="icon"><i class="icon-info"></i></div><strong style="color: white">Target Action</strong>
		                    </div>
		                    <div id="MotorSpeed" style="color: #864DD9; font-size: x-large;  font-weight:bold; ; margin-right: 15px; margin-bottom: 15px">
		                    	Speed : 0
		                    </div>
		                 </div>
		                </div>
		              </div>
		            </div>
		          </div>
		        </section>
		        
		        
		        <input value="Driving Mode" readonly="readonly" style="border-color: transparent ; background-color: #864DD9 ; text-align: center; color: white;font-weight: bold;justify-content: center; width: 320px; position: absolute; top: 750px; left: 1260px; height: 30px">
		        <div id=batteryMode style="background-color: #864DD9; width:320px; color: white; font-weight: bold;justify-content: center; position: absolute; left: 1260px; top:780px">
           			<div style="width:160px">
             			<input id="modeOn" onclick="manual('On')" value="Manual Driving" readonly="readonly" style="border-color: transparent; width: 160px; background-color: dimgray; text-align: center; color: white; font-weight: bold;justify-content: center;">
             		</div>
					<div  style="width: 160px">
						<input id="modeOff" onclick="manual('Off')" value="Auto Driving" readonly="readonly" style="border-color: transparent; width: 160px; background-color: #ADFF2F; text-align: center; color: black; font-weight: bold;justify-content: center;">
					</div>
           		</div>
				
				<div id="manual_control" style="display:none ; width: 380px; height: 200px; position: absolute; top: 790px;">
					<div style="margin-left: 1180px; width: 320px; height:200px; position: absolute" align="center">
						<input value="Motor Ctrl" style="background-color: transparent; border-color: transparent; font-weight: bold; font-size: large; color: white; text-align: center; width: 160px; display: none"></br>
						<a class="btn btn-outline-warning btn-lg" id="up" onmousedown="tire_button_down('up')" onmouseup="tire_button_up('up')" onclick="click_up()"style=" margin-bottom:5px ;border-color:#ADFF2F; border-width: medium; font-weight: bold;">↑</a><br/>
						<a class="btn btn-outline-warning btn-lg" id="left" onmousedown="tire_button_down('left')" onmouseup="tire_button_up('left')" onclick="click_left()" style="border-color:#ADFF2F; border-width: medium; font-weight: bold;">←</a>
						<a class="btn btn-outline-warning btn-lg" id="down" onmousedown="tire_button_down('down')" onmouseup="tire_button_up('down')" onclick="click_down()" style="border-color:#ADFF2F; border-width: medium; font-weight: bold;">□</a>
						<a class="btn btn-outline-warning btn-lg" id="right" onmousedown="tire_button_down('right')" onmouseup="tire_button_up('right')" onclick="click_right()" style="border-color:#ADFF2F; border-width: medium; font-weight: bold;">→</a></br>
 						<a class="btn btn-outline-warning btn-sm manual-line" onclick="manual('W')" style="color: black">L Line</a>
						<a class="btn btn-outline-warning btn-sm manual-line" onclick="manual('W')" style="color: black">R Line</a>
					</div>

					
					<div style="margin-left: 1350px; width: 190px; height:200px; position: absolute" align="center">
						<input ="Sensor Ctrl" style="background-color: transparent; border-color: transparent; font-weight: bold; font-size: large; color: white; text-align: center; width: 190px"></br>
<!-- 						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual('W')" style="border-color:darkred;  color: darkred">RED</a> 
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual('S')" style="border-color:white;  color: white">SIREN</a>
 						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual('W')" style="border-color:gold;  padding-left: 8px; margin-top: 10px; color: gold">YELLOW</a>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual('W')" style="border-color:white;  padding-left: 8px; margin-top: 10px; color: white">FLASH</a></br>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual('W')" style="border-color:green; margin-top: 10px; color: green">GREEN</a> -->
					</div>
				</div>
				


<!--    		
             	<div id="title" style="background-color: #864DD9; width: 875px; color: white; font-weight: bold; text-align : center; margin-left: 30px; margin-top:30px; height: 30px">Auto Driving Situation</div>

             	<div id="batteryMode" style="position: absolute; left: 578px; top: 187px">
              		<div id="batMode" style="width: 180px">
              			<input id="batt" value="Battery" readonly="readonly" style="border-color: transparent; background-color: #ADFF2F; text-align: center; width: 180px; color: black; font-weight: bold;justify-content: center; opacity: 0.7">
              		</div>
					<div id="adtMode" style="width: 180px">
						<input id="adtt" value="Adapter Connected" readonly="readonly" style="border-color: transparent; background-color:dimgray; text-align: center; width: 180px; color: white; font-weight: bold;justify-content: center; opacity: 0.7">
					</div>
              	</div>
             	
             	<img id=jetView1 style="width: 875px; height: 610px; padding-left: 0px; padding-right: 0px; margin-left: 30px; margin-top: 0px"/>
             	
		      	<section class="no-padding-top no-padding-bottom" style="top:187px; position: absolute; background-color: transparent;">
		          <div class="container-fluid">
		            <div class="row">
		              <div class="col-md-3 col-sm-6">
		                <div class="statistic-block block" style="width: 380px; height: 100px; margin-bottom: 10px; padding-bottom: 0px; margin-left: 495px; background-color: transparent;">
		                  <div class="progress-details d-flex align-items-end justify-content-between">
		                    <div class="title">
		                      <div class="icon"><i class="icon-writing-whiteboard"></i></div><strong style="color: white">Battery Status</strong>
		                    </div> 
		                    <div class="number dashtext-1" id="jetRacerText1">
		                    	100%
		                    </div>
		                  </div>
		                  <div class="progress progress-template">
		                    <div id="jet1Battery" role="progressbar" style="width: 100%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-1"></div>
		                  </div>
		                </div>
		                <div class="statistic-block block" style="width: 380px; height: 80px; margin-left: 495px; justify-content: center; margin-bottom: 10px; padding-bottom: 0px; background-color: transparent;">
		                  <div class="progress-details d-flex align-items-end justify-content-between" style="justify-content: center;">
		                    <div class="title" style="padding-bottom: 30px">
		                      <div class="icon"><i class="icon-info"></i></div><strong style="color: white">Driving District</strong>
		                    </div>
		                    <div class="number dashtext-1" id="district1" style="padding-bottom: 30px">
		                    	Zone A
		                    </div>
		                 </div>
		                </div>
 		                <div class="statistic-block block" style="width: 380px; height: 80px; margin-left: 495px; justify-content: center; margin-bottom: 10px; padding-bottom: 0px; background-color: transparent;">
		                  <div class="progress-details d-flex align-items-end justify-content-between" style="justify-content: center;">
		                    <div class="title" style="padding-bottom: 30px">
		                      <div class="icon"><i class="icon-info"></i></div><strong style="color: white">Motor Speed</strong>
		                    </div>
		                    <div class="number dashtext-1" id="MotorSpeed" style="padding-bottom: 30px; color: white;">
		                    	60 km/h
		                    </div>
		                 </div>
		                </div>
		                <div class="statistic-block block" style="width: 380px; height: 80px; margin-left: 495px; justify-content: center; margin-bottom: 10px; padding-bottom: 0px; background-color: transparent;">
		                  <div class="progress-details d-flex align-items-end justify-content-between" style="justify-content: center;">
		                    <div class="title" style="padding-bottom: 30px; padding-top: 0px">
		                      <div class="icon"><i class="icon-info"></i></div><strong style="color: white">Current °C</strong>
		                    </div>
		                    <div class="number dashtext-1" id="Temperature" style="padding-bottom: 30px">
		                    	25 °C
		                    </div>
		                 </div>
		                </div>
		              </div>
		            </div>
		          </div>
		        </section>

           		<div id=batteryMode style="background-color: #864DD9; width: 870px; color: white; font-weight: bold;justify-content: center; position: absolute; left: 65px; top:766px">
           			<div style="width: 435px">
             			<input id="modeOn" onclick="manual('On')" value="Manual Driving Mode" readonly="readonly" style="border-color: transparent;width: 435px; background-color: dimgray; text-align: center; color: white; font-weight: bold;justify-content: center;">
             		</div>
					<div  style="width: 435px">
						<input id="modeOff" onclick="manual('Off')" value="Auto Driving Mode" readonly="readonly" style="border-color: transparent;width: 435px; background-color: #ADFF2F; text-align: center; color: black; font-weight: bold;justify-content: center;">
					</div>
           		</div>
           		 
              	 
             	주행 중 탐지하는 표지판 내용 표시
             	<div class="driving-sign" style="height: 51px; top: 550px">Detected Object </div>
             		<input id="driveObject1" value="N/A" readonly="readonly" style="background-color: transparent; border-color: transparent; position: absolute; color: white; left: 390px; font-weight: bold; font-size:x-large; top:632px ">
             	
             	<div class="driving-sign" style="height: 51px; top: 620px">Detected Sign </div>
					<input id=driveSign1 value="N/A" readonly="readonly" style="background-color: transparent; border-color: transparent; position: absolute; color: white; left: 390px; font-weight: bold; font-size:x-large; top:687px ">
				
				<div class="driving-sign" style="height: 51px;top: 690px">Detected Zone </div>
					<input id=driveLoc1 value="N/A" readonly="readonly" style="background-color: transparent; border-color: transparent; position: absolute; color: white; left: 390px; font-weight: bold; font-size:x-large; top:742px ">
				
				<div class="driving-sign" style="height: 51px; top: 760px">Target Speed </div>
					<input id=driveSpeed1 value="N/A" readonly="readonly" style="background-color: transparent; border-color: transparent; position: absolute; color: white; left: 390px; font-weight: bold; font-size:x-large; top:797px ">
				
				<div class="driving-sign" style="height: 55px;top: 570px">Target Action </div>
					<input id=driveAction1 value="N/A" readonly="readonly" style="background-color: transparent; border-color: transparent; position: absolute; color: white; left: 390px; font-weight: bold; font-size:x-large; top:852px ">

				<div id="manual_control" style="display:none ; width: 380px; height: 100px; position: absolute; top: 775px;">
					<div style="margin-left: 60px; width: 190px; height:100px; position: absolute" align="center">
						키보드로 출발/정지
						<input value="Motor Ctrl" style="background-color: transparent; border-color: transparent; font-weight: bold; font-size: large; color: white; text-align: center; width: 190px; display: none;"></br>
						<a class="btn btn-outline-warning btn-lg" id="up" onmousedown="tire_button_down('up')" onmouseup="tire_button_up('up')" onclick="click_up()"style=" margin-bottom:5px ;border-color:#ADFF2F; border-width: medium; font-weight: bold;">↑</a><br/>
						<a class="btn btn-outline-warning btn-lg" id="left" onmousedown="tire_button_down('left')" onmouseup="tire_button_up('left')" onclick="click_left()" style="border-color:#ADFF2F; border-width: medium; font-weight: bold;">←</a>
						<a class="btn btn-outline-warning btn-lg" id="down" onmousedown="tire_button_down('down')" onmouseup="tire_button_up('down')" onclick="click_down()" style="border-color:#ADFF2F; border-width: medium; font-weight: bold;">□</a>
						<a class="btn btn-outline-warning btn-lg" id="right" onmousedown="tire_button_down('right')" onmouseup="tire_button_up('right')" onclick="click_right()" style="border-color:#ADFF2F; border-width: medium; font-weight: bold;">→</a></br>
					
						<a class="btn btn-outline-warning btn-sm manual-line" onclick="manual('W')" style="color: black">L Line</a>
						<a class="btn btn-outline-warning btn-sm manual-line" onclick="manual('W')" style="color: black">R Line</a>
					</div>

					
					<div style="margin-left: 715px; width: 190px; height:100px; position: absolute" align="center">
						센서 띄우기
						<input ="Sensor Ctrl" style="background-color: transparent; border-color: transparent; font-weight: bold; font-size: large; color: white; text-align: center; width: 190px"></br>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual('W')" style="border-color:darkred;  color: darkred">RED</a>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual('S')" style="border-color:white;  color: white">SIREN</a>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual('W')" style="border-color:gold;  padding-left: 8px; margin-top: 10px; color: gold">YELLOW</a>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual('W')" style="border-color:white;  padding-left: 8px; margin-top: 10px; color: white">FLASH</a></br>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual('W')" style="border-color:green; margin-top: 10px; color: green">GREEN</a>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual('W')" style="border-color:white; margin-top: 10px; color: white">???</a>
					</div>
				</div>
				 -->
			</div> 
			<!-- END OF jet racer # 1 -->
		 		
			<!-- jet racer # 2 -->
			<div class="tab-pane fade" id="jet-racer2" role="tabpanel" aria-labelledby="jet-racer2-tab">
		      	<div id=showView style="margin-top: 30px; margin-left: 30px">
             		<div id="title" style="background-color: #864DD9; width: 490px; color: white; font-weight: bold;justify-content: center;">Auto Driving Situation</div>
             		<div id="vacant2" style="background-color: transparent; width: 5px"></div>
             		<div id=batteryMode>
	              		<div id="batMode" style="width: 190px">
	              			<input id="batt2" value="Battery" readonly="readonly" style="border-color: transparent; background-color: #ADFF2F; text-align: center; color: black; width: 190px; font-weight: bold;justify-content: center;">
	              		</div>
						<div id="adtMode2" style="width: 190px">
							<input id="adtt2" value="Adapter Connected" readonly="readonly" style="border-color: transparent; background-color:dimgray; text-align: center; color: white; width: 190px; font-weight: bold;justify-content: center;">
						</div>
              		</div>
             	</div>
             	
             	<img id=jetView2 style="width: 490px; height: 370px; padding-left: 0px; padding-right: 0px; margin-left: 30px; margin-top: 0px"/>
             	
		      	<section class="no-padding-top no-padding-bottom" style="top:187px; position: absolute">
		          <div class="container-fluid">
		            <div class="row">
		              <div class="col-md-3 col-sm-6">
		                <div class="statistic-block block" style="width: 380px; height: 100px; margin-bottom: 10px; padding-bottom: 0px; margin-left: 495px">
		                  <div class="progress-details d-flex align-items-end justify-content-between">
		                    <div class="title">
		                      <div class="icon"><i class="icon-writing-whiteboard"></i></div><strong style="color: white">Battery Status</strong>
		                    </div> 
		                    <div class="number dashtext-1" id="jetRacerText2">
		                    	100%
		                    </div>
		                  </div>
		                  <div class="progress progress-template">
		                    <div id="jet2Battery" role="progressbar" style="width: 100%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-1"></div>
		                  </div>
		                </div>
		                <div class="statistic-block block" style="width: 380px; height: 80px; margin-left: 495px; justify-content: center; margin-bottom: 10px; padding-bottom: 0px">
		                  <div class="progress-details d-flex align-items-end justify-content-between" style="justify-content: center;">
		                    <div class="title" style="padding-bottom: 30px">
		                      <div class="icon"><i class="icon-info"></i></div><strong style="color: white">Driving District</strong>
		                    </div>
		                    <div class="number dashtext-1" id="district2" style="padding-bottom: 30px">
		                    	Zone A
		                    </div>
		                 </div>
		                </div>
 		                <div class="statistic-block block" style="width: 380px; height: 80px; margin-left: 495px; justify-content: center; margin-bottom: 10px; padding-bottom: 0px">
		                  <div class="progress-details d-flex align-items-end justify-content-between" style="justify-content: center;">
		                    <div class="title" style="padding-bottom: 30px">
		                      <div class="icon"><i class="icon-info"></i></div><strong style="color: white">Motor Speed</strong>
		                    </div>
		                    <div class="number dashtext-1" id="MotorSpeed2" style="padding-bottom: 30px">
		                    	60 km/h
		                    </div>
		                 </div>
		                </div>
		                <div class="statistic-block block" style="width: 380px; height: 80px; margin-left: 495px; justify-content: center; margin-bottom: 10px; padding-bottom: 0px">
		                  <div class="progress-details d-flex align-items-end justify-content-between" style="justify-content: center;">
		                    <div class="title" style="padding-bottom: 30px; padding-top: 0px">
		                      <div class="icon"><i class="icon-info"></i></div><strong style="color: white">Current °C</strong>
		                    </div>
		                    <div class="number dashtext-1" id="Temperature2" style="padding-bottom: 30px">
		                    	25 °C
		                    </div>
		                 </div>
		                </div>
		              </div>
		            </div>
		          </div>
		        </section>
		        
		        <div id=showView style="margin-top: 30px; margin-left: 30px">
             		<div style="background-color: #864DD9; width: 490px; color: white; font-weight: bold;justify-content: center;">Object Detection Situation</div>
             		<div style="background-color: transparent; width: 5px"></div>
             		<div id=batteryMode style="background-color: #864DD9; width: 380px; color: white; font-weight: bold;justify-content: center;">
             			<div style="width: 190px">
	              			<input id="modeOn2" onclick="manual2('On')" value="Manual Driving Mode" readonly="readonly" style="border-color: transparent; background-color: dimgray; text-align: center; color: white; width: 190px; font-weight: bold;justify-content: center;">
	              		</div>
						<div  style="width: 190px">
							<input id="modeOff2" onclick="manual2('Off')" value="Auto Driving Mode" readonly="readonly" style="border-color: transparent; background-color: #ADFF2F; text-align: center; color: black; width: 190px; font-weight: bold;justify-content: center;">
						</div>
             		</div>
             	</div>
             	
             	<!-- 주행 중 탐지한 이미지 보여주기 -->
             	<img id=driveView2 style="width: 325px; height: 275px; position: absolute; top: 617px; left: 63px"/>
             	<img id=detectView2 src="${pageContext.request.contextPath}/resource/img/milk.jpg" style="width: 140px; height: 140px; position: absolute; top: 750px; left: 250px; opacity: 0.8; display: none;"/>
             	
             	<!-- 주행 중 탐지하는 표지판 내용 표시 -->
             	<div class="driving-sign" style="height: 51px; top: 617px">Detected Object </div>
             		<input id="driveObject2" value="N/A" readonly="readonly" style="background-color: transparent; border-color: transparent; position: absolute; color: white; left: 390px; font-weight: bold; font-size:x-large; top:632px ">
             	
             	<div class="driving-sign" style="height: 51px; top: 672px">Detected Sign </div>
					<input id="driveSign2" value="N/A" readonly="readonly" style="background-color: transparent; border-color: transparent; position: absolute; color: white; left: 390px; font-weight: bold; font-size:x-large; top:687px ">
				
				<div class="driving-sign" style="height: 51px;top: 727px">Detected Zone </div>
					<input id="driveLoc2" value="N/A" readonly="readonly" style="background-color: transparent; border-color: transparent; position: absolute; color: white; left: 390px; font-weight: bold; font-size:x-large; top:742px ">
				
				<div class="driving-sign" style="height: 51px; top: 782px">Target Speed </div>
					<input id="driveSpeed2" value="N/A" readonly="readonly" style="background-color: transparent; border-color: transparent; position: absolute; color: white; left: 390px; font-weight: bold; font-size:x-large; top:797px ">
				
				<div class="driving-sign" style="height: 55px;top: 837px">Target Action </div>
					<input id="driveAction2" value="N/A" readonly="readonly" style="background-color: transparent; border-color: transparent; position: absolute; color: white; left: 390px; font-weight: bold; font-size:x-large; top:852px ">

				<div id="manual_control2" style="display:none; width: 380px; height: 280px">
					<div style="margin-left: 525px; width: 190px; height:280px; position: absolute" align="center">
						<!-- 키보드로 출발/정지 -->
						<input value="Motor Ctrl" style="background-color: transparent; border-color: transparent; font-weight: bold; font-size: large; color: white; text-align: center; width: 190px"></br>
						<a class="btn btn-outline-warning btn-lg" id="up2" onmousedown="tire_button_down('up')" onmouseup="tire_button_up('up')" onclick="click_up()"style=" margin-bottom:5px ;border-color:#ADFF2F; border-width: medium; font-weight: bold;">↑</a><br/>
						<a class="btn btn-outline-warning btn-lg" id="left2" onmousedown="tire_button_down('left')" onmouseup="tire_button_up('left')" onclick="click_left()" style="border-color:#ADFF2F; border-width: medium; font-weight: bold;">←</a>
						<a class="btn btn-outline-warning btn-lg" id="down2" onmousedown="tire_button_down('down')" onmouseup="tire_button_up('down')" onclick="click_down()" style="border-color:#ADFF2F; border-width: medium; font-weight: bold;">□</a>
						<a class="btn btn-outline-warning btn-lg" id="right2" onmousedown="tire_button_down('right')" onmouseup="tire_button_up('right')" onclick="click_right()" style="border-color:#ADFF2F; border-width: medium; font-weight: bold;">→</a></br>
					
						<a class="btn btn-outline-warning btn-sm manual-line" onclick="manual2('W')" style="color: black">L Line</a>
						<a class="btn btn-outline-warning btn-sm manual-line" onclick="manual2('W')" style="color: black">R Line</a>
					</div>
					
					<div style="margin-left: 715px; width: 190px; height:280px; position: absolute" align="center" >
						<!-- 센서 띄우기 -->
						<input value="Sensor Ctrl" style="background-color: transparent; border-color: transparent; font-weight: bold; font-size: large; color: white; text-align: center; width: 190px"></br>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual2('W')" style="border-color:darkred;  color: darkred">RED</a>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual2('S')" style="border-color:white;  color: white">SIREN</a>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual2('W')" style="border-color:gold;  padding-left: 8px; margin-top: 10px; color: gold">YELLOW</a>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual2('W')" style="border-color:white;  padding-left: 8px; margin-top: 10px; color: white">FLASH</a></br>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual2('W')" style="border-color:green; margin-top: 10px; color: green">GREEN</a>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual2('W')" style="border-color:white; margin-top: 10px; color: white">???</a>
					</div>
				</div>
			</div>
			<!-- END OF jet racer # 2 -->
			  
			  <!-- jet racer # 3 -->
			  <div class="tab-pane fade" id="jet-racer3" role="tabpanel" aria-labelledby="jet-racer3-tab">
		        <div id=showView style="margin-top: 30px; margin-left: 30px">
             		<div id="title" style="background-color: #864DD9; width: 490px; color: white; font-weight: bold;justify-content: center;">Auto Driving Situation</div>
             		<div id="vacant" style="background-color: transparent; width: 5px"></div>
             		<div id=batteryMode>
	              		<div id="batMode" style="width: 190px">
	              			<input id="batt3" value="Battery" readonly="readonly" style="border-color: transparent; background-color: #ADFF2F; text-align: center; color: black; width: 190px; font-weight: bold;justify-content: center;">
	              		</div>
						<div id="adtMode" style="width: 190px">
							<input id="adtt3" value="Adapter Connected" readonly="readonly" style="border-color: transparent; background-color:dimgray; text-align: center; color: white; width: 190px; font-weight: bold;justify-content: center;">
						</div>
              		</div>
             	</div>
             	
             	<img id=jetView3 style="width: 490px; height: 370px; padding-left: 0px; padding-right: 0px; margin-left: 30px; margin-top: 0px"/>

		      	<section class="no-padding-top no-padding-bottom" style="top:187px; position: absolute">
		          <div class="container-fluid">
		            <div class="row">
		              <div class="col-md-3 col-sm-6">
		                <div class="statistic-block block" style="width: 380px; height: 100px; margin-bottom: 10px; padding-bottom: 0px; margin-left: 495px">
		                  <div class="progress-details d-flex align-items-end justify-content-between">
		                    <div class="title">
		                      <div class="icon"><i class="icon-writing-whiteboard"></i></div><strong style="color: white">Battery Status</strong>
		                    </div> 
		                    <div class="number dashtext-1" id="jetRacerText3">
		                    	100%
		                    </div>
		                  </div>
		                  <div class="progress progress-template">
		                    <div id="jet2Battery" role="progressbar" style="width: 100%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-1"></div>
		                  </div>
		                </div>
		                <div class="statistic-block block" style="width: 380px; height: 80px; margin-left: 495px; justify-content: center; margin-bottom: 10px; padding-bottom: 0px">
		                  <div class="progress-details d-flex align-items-end justify-content-between" style="justify-content: center;">
		                    <div class="title" style="padding-bottom: 30px">
		                      <div class="icon"><i class="icon-info"></i></div><strong style="color: white">Driving District</strong>
		                    </div>
		                    <div class="number dashtext-1" id="district3" style="padding-bottom: 30px">
		                    	Zone A
		                    </div>
		                 </div>
		                </div>
 		                <div class="statistic-block block" style="width: 380px; height: 80px; margin-left: 495px; justify-content: center; margin-bottom: 10px; padding-bottom: 0px">
		                  <div class="progress-details d-flex align-items-end justify-content-between" style="justify-content: center;">
		                    <div class="title" style="padding-bottom: 30px">
		                      <div class="icon"><i class="icon-info"></i></div><strong style="color: white">Motor Speed</strong>
		                    </div>
		                    <div class="number dashtext-1" id="MotorSpeed3" style="padding-bottom: 30px">
		                    	60 km/h
		                    </div>
		                 </div>
		                </div>
		                <div class="statistic-block block" style="width: 380px; height: 80px; margin-left: 495px; justify-content: center; margin-bottom: 10px; padding-bottom: 0px">
		                  <div class="progress-details d-flex align-items-end justify-content-between" style="justify-content: center;">
		                    <div class="title" style="padding-bottom: 30px; padding-top: 0px">
		                      <div class="icon"><i class="icon-info"></i></div><strong style="color: white">Current °C</strong>
		                    </div>
		                    <div class="number dashtext-1" id="Temperature3" style="padding-bottom: 30px">
		                    	25 °C
		                    </div>
		                 </div>
		                </div>
		              </div>
		            </div>
		          </div>
		        </section>
		        
		        <div id=showView style="margin-top: 30px; margin-left: 30px">
             		<div style="background-color: #864DD9; width: 490px; color: white; font-weight: bold;justify-content: center;">Object Detection Situation</div>
             		<div style="background-color: transparent; width: 5px"></div>
             		<div id=batteryMode style="background-color: #864DD9; width: 380px; color: white; font-weight: bold;justify-content: center;">
             			<div style="width: 190px">
	              			<input id="modeOn3" onclick="manual3('On')" value="Manual Driving Mode" readonly="readonly" style="border-color: transparent; background-color: dimgray; text-align: center; color: white; width: 190px; font-weight: bold;justify-content: center;">
	              		</div>
						<div  style="width: 190px">
							<input id="modeOff3" onclick="manual3('Off')" value="Auto Driving Mode" readonly="readonly" style="border-color: transparent; background-color: #ADFF2F; text-align: center; color: black; width: 190px; font-weight: bold;justify-content: center;">
						</div>
             		</div>
             	</div>
             	
             	<!-- 주행 중 탐지한 이미지 보여주기 -->
             	<img id=driveView3 style="width: 325px; height: 275px; position: absolute; top: 617px; left: 63px"/>
             	<img id=detectView3 src="${pageContext.request.contextPath}/resource/img/milk.jpg" style="width: 140px; height: 140px; position: absolute; top: 750px; left: 250px; opacity: 0.8; display: none;"/>
             	
             	<!-- 주행 중 탐지하는 표지판 내용 표시 -->
             	<div class="driving-sign" style="height: 51px; top: 617px">Detected Object </div>
             		<input id="driveObject3" value="N/A" readonly="readonly" style="background-color: transparent; border-color: transparent; position: absolute; color: white; left: 390px; font-weight: bold; font-size:x-large; top:632px ">
             	
             	<div class="driving-sign" style="height: 51px; top: 672px">Detected Sign </div>
					<input id="driveSign3" value="N/A" readonly="readonly" style="background-color: transparent; border-color: transparent; position: absolute; color: white; left: 390px; font-weight: bold; font-size:x-large; top:687px ">
				
				<div class="driving-sign" style="height: 51px;top: 727px">Detected Zone </div>
					<input id="driveLoc3" value="N/A" readonly="readonly" style="background-color: transparent; border-color: transparent; position: absolute; color: white; left: 390px; font-weight: bold; font-size:x-large; top:742px ">
				
				<div class="driving-sign" style="height: 51px; top: 782px">Target Speed </div>
					<input id="driveSpeed3" value="N/A" readonly="readonly" style="background-color: transparent; border-color: transparent; position: absolute; color: white; left: 390px; font-weight: bold; font-size:x-large; top:797px ">
				
				<div class="driving-sign" style="height: 55px;top: 837px">Target Action </div>
					<input id="driveAction3" value="N/A" readonly="readonly" style="background-color: transparent; border-color: transparent; position: absolute; color: white; left: 390px; font-weight: bold; font-size:x-large; top:852px ">

				<div id="manual_control3" style="display:none; width: 380px; height: 100px ">
					<div style="margin-left: 525px; width: 190px; height:100px; position: absolute" align="center">
						<!-- 키보드로 출발/정지 -->
						<input value="Motor Ctrl" style="background-color: transparent; border-color: transparent; font-weight: bold; font-size: large; color: white; text-align: center; width: 190px"></br>
						<a class="btn btn-outline-warning btn-lg" id="up3" onmousedown="tire_button_down('up')" onmouseup="tire_button_up('up')" onclick="click_up()"style=" margin-bottom:5px ;border-color:#ADFF2F; border-width: medium; font-weight: bold;">↑</a><br/>
						<a class="btn btn-outline-warning btn-lg" id="left3" onmousedown="tire_button_down('left')" onmouseup="tire_button_up('left')" onclick="click_left()" style="border-color:#ADFF2F; border-width: medium; font-weight: bold;">←</a>
						<a class="btn btn-outline-warning btn-lg" id="down3" onmousedown="tire_button_down('down')" onmouseup="tire_button_up('down')" onclick="click_down()" style="border-color:#ADFF2F; border-width: medium; font-weight: bold;">□</a>
						<a class="btn btn-outline-warning btn-lg" id="right3" onmousedown="tire_button_down('right')" onmouseup="tire_button_up('right')" onclick="click_right()" style="border-color:#ADFF2F; border-width: medium; font-weight: bold;">→</a></br>
					
						<a class="btn btn-outline-warning btn-sm manual-line" onclick="manual3('W')" style="color: black">L Line</a>
						<a class="btn btn-outline-warning btn-sm manual-line" onclick="manual3('W')" style="color: black">R Line</a>
					</div>
					
					<div style="margin-left: 715px; width: 190px; height:100px; position: absolute" align="center" >
						<!-- 센서 띄우기 -->
						<input value="Sensor Ctrl" style="background-color: transparent; border-color: transparent; font-weight: bold; font-size: large; color: white; text-align: center; width: 190px"></br>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual3('W')" style="border-color:darkred;  color: darkred">RED</a>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual3('S')" style="border-color:white;  color: white">SIREN</a>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual3('W')" style="border-color:gold;  padding-left: 8px; margin-top: 10px; color: gold">YELLOW</a>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual3('W')" style="border-color:white;  padding-left: 8px; margin-top: 10px; color: white">FLASH</a>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual3('W')" style="border-color:green; margin-top: 10px; color: green">GREEN</a>
						<a class="btn btn-outline-warning btn-sm manual-button" onclick="manual3('W')" style="border-color:white; margin-top: 10px; color: white">???</a>
					</div>
				</div>
			</div>
			<!-- END OF jet racer # 3 -->
		</div>
	</div>
	</div>
	</body>
</html>
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
		
		<script src="${pageContext.request.contextPath}/resource/js/manual_control.js" ></script> 

		<style>
			#div1 {font-size:48px}
			
			.no-gutters {
			  margin-right: 0;
			  margin-left: 0;
			  > .col,
			  > [class*="*cols-"] {
			    padding-right: 0;
			    padding-left: 0;
			  }
			}
			.center {
			  display: flex;
			  justify-content: center;
			  align-items: center;
			  height: 50px;
			  font-size: 30px;
			  font-weight: bold;
			}
			.jetToggle {
			justify-content: center; 
			align-content: center;
			}
			#image_steering {
			transform: rotate(0deg);
			}
			#chart-container {
			  height: 300px; 
			  width: 380px;
			}
			.highcharts-figure, .highcharts-data-table table {
			  min-width: 300px; 
			  max-width: 300px;
			  margin: 1em auto;
			}
			.highcharts-data-table table {
			  font-family: Verdana, sans-serif;
			  border-collapse: collapse;
			  border: 1px solid #EBEBEB;
			  margin: 10px auto;
			  text-align: center;
			  width: 100%;
			  max-width: 500px;
			}
			.highcharts-data-table caption {
			  font-size: 1.2em;
			  color: #555;
			}
			.highcharts-data-table th {
			  font-weight: 200;
			}
			.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
			  background: #f8f8f8;
			}
			.highcharts-data-table tr:hover {
			  background: #f1f7ff;
			}
			.highcharts-background {
			fill: transparent;
			width: 380px;
			}
			.highcharts-title {
			display: none;
			}
			.highcharts-root {
			width: 380px;
			}
			#batteryMode {
			  width: 380px;
			  height: 30px;
			  display: flex;
			  flex-direction: row;
			}
			#batteryMode div {
			  width: 190px;
			  height: 30px;
			  text-align: center;
			}
			#showView {
			  width: 875px;
			  height: 30px;
			  display: flex;
			  flex-direction: row;
			}
			#showView div {
			  height: 30px;
			  text-align: center;
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
				client.subscribe("/1jetracer");
				client.subscribe("/1jr");
				client.subscribe("/2jetracer");
				client.subscribe("/3jetracer");
				client.subscribe("/sensor");
			}
			
			var speed = 0; 
			function onMessageArrived(message) {
				//console.log("mqtt message received");
				
 				if(message.destinationName =="/1jetracer") {
					$("#jetView1").attr("src", "data:image/jpg;base64,"+ message.payloadString);
				}
 				
 				if(message.destinationName =="/1jr") {
 					const json = message.payloadString;
 					const obj = JSON.parse(json);
 					
/////////////////////////////////////////////////		배터리 상태		///////////////////////////////////////////////////////////////////////
					//console.log("battery:",obj.battery, "%");
					bat1 = obj.battery;
					//$("#jetRacerText1").text(bat1 + "%");
			      	bat1 = parseInt(bat1);
			      	
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
	
/////////////////////////////////////////////////		servo 각도 조절			//////////////////////////////////////////////////////////////
			      	angle = obj.servo;
					//console.log("servo:",angle);
			      	if (angle > 90){
	  			    	angle=540-(2*angle);
	  			    	$("#image_steering").css({transform:'rotate(' + angle + 'deg)'});
			      	}
	  			    else if (angle == 90){
			      		$("#image_steering").css({transform:'rotate(' + 0 + 'deg)'});
			      	}
	  			    else if (angle < 90){
			      		angle=180-(2*angle);
			      		$("#image_steering").css({transform:'rotate(' + angle + 'deg)'});
			      	}

/////////////////////////////////////////////////		dc speed		///////////////////////////////////////////////////////////////////
					speed1 = obj.speed;
			      	speed1=Math.round(speed1);
			      	if(speed1 < 40){
			      		$("#MotorSpeed").text(0 +" km/h");
			      		//$("#MotorSpeed").attr("value", 0 +" km/h");
			      	}
			      	else if(40 <= speed1){
			      		$("#MotorSpeed").text(speed1 +" km/h");
			      		//$("#MotorSpeed").attr("value", speed1 +" km/h");
			      	}
			      	//console.log("speed:", speed1);

/////////////////////////////////////////////////		주행 구역		///////////////////////////////////////////////////////////////////////
			      	//area1 = obj.area;
			   		var text = "";
					var possible = "ABCDEFGHIJKLMNOPQRST";
					text = possible.charAt(Math.floor(Math.random() * possible.length));
					//console.log(text);
			      	$("#district1").text("Zone " + text);
			      	//document.getElementById('jet1District').style.width = (area1*5) + '%';

/////////////////////////////////////////////////		외부 온도		///////////////////////////////////////////////////////////////////////
			      	//temp1 = obj.temp;
			      	temp1 = parseInt(((Math.random()*10+1))+20);
			      	$("#Temperature").text(temp1 +" °C");
			      	//$("#Temperature").attr("value", temp1 +" °C");
				}
 				
				if(message.destinationName =="/2jetracer") {
					$("#jetView2").attr("src", "data:image/jpg;base64,"+ message.payloadString);
				}
				
				if(message.destinationName =="/2jr") {
 					const json = message.payloadString;
 					const obj = JSON.parse(json);
					bat2 = obj.battery;
					$("#jetRacerText2").text(bat2 + "%");
			      	document.getElementById('jet2Battery').style.width = bat2 + '%';
				}
				
				if(message.destinationName =="/3jetracer") {
					const json = message.payloadString;
					const obj = JSON.parse(json);
					$("#jetView3").attr("src", "data:image/jpg;base64,"+ message.payloadString);
				}
				if(message.destinationName =="/sensor") {
					const json = message.payloadString;
					const obj = JSON.parse(json);
			      	
			      	$("#battery2").attr("value", obj.Battery);
			      	$("#jetRacerText2").text(obj.Battery + "%");
			      	document.getElementById('jet2Battery').style.width = obj.Battery + '%';
			      	
			      	$("#battery3").attr("value", obj.Battery);
			      	$("#jetRacerText3").text(obj.Battery + "%");
			      	document.getElementById('jet3Battery').style.width = obj.Battery + '%';
				}
			}
		</script>
		<script>
		//키보드 전용 토픽 서보 만들기		키보드 이벤트를 통해 정보를 송신받아서 키보드에 해당하는 특정 작업을 수행하는걸 실시간으로 보여준다
		$(document).keydown(function(event) {	// 동시에 누르면 가운데로 정렬
			
			if (event.keyCode == '37' && event.keyCode == '39') { //좌우키를 동시 누르는 중
			    
			    console.log("좌우 키보드 누름")
				servo4 = 90
								
				message = new Paho.MQTT.Message("value:"+ servo4);
				message.destinationName = "/servo/servo4/middle";
				message.qos = 0;
				client.send(message);
			}
			  
			  
			if (event.keyCode == '40' && event.keyCode == '38') { //앞이랑 뒤 키를 동시에 눌렀을때 : 일단 멈춤
				    speed = 0
				    console.log("상하 키보드 동시에 누름")
				  	message = new Paho.MQTT.Message("value:"+ speed);
					message.destinationName = "/speed/stop";
					message.qos = 0;
					client.send(message);
			}
			  
			if (event.keyCode == '38') {
				  	console.log("달리자")
				  	message = new Paho.MQTT.Message("speed:"+ 40);
					message.destinationName = "/manual/go";
					message.qos = 0;
					client.send(message);
			}
			
			if (event.keyCode == '40') { 		
				    console.log("멈추거라")
				  	message = new Paho.MQTT.Message("speed:" + 0);
					message.destinationName = "/manual/stop";
					message.qos = 0;
					client.send(message);
			}
			
			if (event.keyCode == '32') { //스페이스바
					buzzerOn()
			}
		});
		</script>
		<script>	// 키보드 이벤트 / 손가락 뗏을때 키보드 이벤트 발생하고 그것을 mqtt 메시지로 보드로 보내준다
			$(document).keyup(function(event) {			  
			  if (event.keyCode == '40' && event.keyCode == '38') { //멈춤
				    speed = 0
				    console.log("상하 동시 뗌")
				  	message = new Paho.MQTT.Message("value:"+ speed);
					message.destinationName = "/speed";
					message.qos = 0;
					client.send(message);
			  }
			  
			  if (event.keyCode == '38') { //멈춤
				  	speed = 0
				  	console.log("위 버튼 뗐는데~~~")
				  	message = new Paho.MQTT.Message("value:"+ speed);
					message.destinationName = "/speed";
					message.qos = 0;
					client.send(message);
				  }
			  
			  if (event.keyCode == '37' && event.keyCode == '39') { //좌우 동시 뗄때
				  	servo4 = 90
				  	console.log("좌우 키보드 동시 뗌")
					message = new Paho.MQTT.Message("value:"+ servo4);
					message.destinationName = "/servo4";
					message.qos = 0;
					client.send(message);
			  }
			  			  
			  if (event.keyCode == '40') { //멈춤
				    speed = 0
				    console.log("아래 버튼 뗐는데~~~")
				  	message = new Paho.MQTT.Message("value:"+ speed);
					message.destinationName = "/speed/down";
					message.qos = 0;
					client.send(message);
			  }
			  		  
			  if (event.keyCode == '32') { //스페이스바
				  buzzerOff()
			  }
			});
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
	       	</ul>
	      </nav>
	      
	      <div class="page-content">
			<div style="margin-top: 10px">
			  <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist" style="max-width: 100%; margin-left: 30px" >
				  <li class="nav-item" role="presentation" style="width: 33%; text-align: center">
				    <a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true" style="font-weight: bold; font-size: large">Jet-Racer #1</a>
				  </li>
				  <li class="nav-item" role="presentation" style="width: 33%; text-align: center">
				    <a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false" style="font-weight: bold; font-size: large;">Jet-Racer #2</a>
				  </li>
				  <li class="nav-item" role="presentation" style="width: 33%; text-align: center">
				    <a class="nav-link" id="pills-contact-tab" data-toggle="pill" href="#pills-contact" role="tab" aria-controls="pills-contact" aria-selected="false" style="font-weight: bold; font-size: large;">Jet-Racer #3</a>
				  </li>
		      </ul>
	      	</div>

			<div class="tab-content" id="pills-tabContent" style="height: 750px; margin-left: 30px; margin-right: 20px;  border-color: dimgray; border-style:solid; border-width:thick">
			  
		  	<!-- jet racer # 1 -->
		  	<div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
  				<div id=showView style="margin-top: 10px; margin-left: 30px">
             		<div id="title" style="background-color: #864DD9; width: 490px; color: white; font-weight: bold;justify-content: center;">Line Tracing Situation</div>
             		<div id="vacant" style="background-color: transparent; width: 5px"></div>
             		<div id=batteryMode>
	              		<div id="batMode" style="width: 190px">
	              			<input id="batt" value="Battery" style="border-color: transparent; background-color: #ADFF2F; text-align: center; color: black; width: 190px; font-weight: bold;justify-content: center;">
	              		</div>
						<div id="adtMode" style="width: 190px">
							<input id="adtt" value="Adapter Connected" style="border-color: transparent; background-color:dimgray; text-align: center; color: white; width: 190px; font-weight: bold;justify-content: center;">
						</div>
              		</div>
             	</div>
             	
             	<img id=jetView1 style="width: 490px; height: 370px; padding-left: 0px; padding-right: 0px; margin-left: 30px; margin-top: 0px"/>

		      	<section class="no-padding-top no-padding-bottom" style="top:115px; position: absolute">
		          <div class="container-fluid">
		            <div class="row">
		              <div class="col-md-3 col-sm-6">
		                <div class="statistic-block block" style="width: 380px; height: 100px; margin-bottom: 10px; padding-bottom: 0px; margin-left: 495px">
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
		                <div class="statistic-block block" style="width: 380px; height: 80px; margin-left: 495px; justify-content: center; margin-bottom: 10px; padding-bottom: 0px">
		                  <div class="progress-details d-flex align-items-end justify-content-between" style="justify-content: center;">
		                    <div class="title" style="padding-bottom: 30px">
		                      <div class="icon"><i class="icon-info"></i></div><strong style="color: white">Driving District</strong>
		                    </div>
		                    <div class="number dashtext-1" id="district1" style="padding-bottom: 30px">
		                    	Zone A
		                    </div>
		                 </div>
		                </div>
 		                <div class="statistic-block block" style="width: 380px; height: 80px; margin-left: 495px; justify-content: center; margin-bottom: 10px; padding-bottom: 0px">
		                  <div class="progress-details d-flex align-items-end justify-content-between" style="justify-content: center;">
		                    <div class="title" style="padding-bottom: 30px">
		                      <div class="icon"><i class="icon-info"></i></div><strong style="color: white">Motor Speed</strong>
		                    </div>
		                    <div class="number dashtext-1" id="MotorSpeed" style="padding-bottom: 30px">
		                    	60 km/h
		                    </div>
		                 </div>
		                </div>
		                <div class="statistic-block block" style="width: 380px; height: 80px; margin-left: 495px; justify-content: center; margin-bottom: 10px; padding-bottom: 0px">
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
		        
		        <div id=showView style="margin-top: 10px; margin-left: 30px">
             		<div id="title" style="background-color: #864DD9; width: 490px; color: white; font-weight: bold;justify-content: center;">Driving Situation</div>
             		<div id="vacant" style="background-color: transparent; width: 5px"></div>
             		<div id="title" style="background-color: #864DD9; width: 380px; color: white; font-weight: bold;justify-content: center;">Manual Control</div>
             	</div>

				
					<div id="tire_control" align="center" style="margin-top: 10px; margin-left: 70px">
						<a class="btn btn-outline-warning btn-lg" id="up" onmousedown="tire_button_down('up')" onmouseup="tire_button_up('up')" onclick="click_up()"style="margin-bottom: 5px; border-color:#864DD9; border-width: medium; ">↑</a><br/>
						<a class="btn btn-outline-warning btn-lg" id="left" onmousedown="tire_button_down('left')" onmouseup="tire_button_up('left')" onclick="click_left()" style="border-color:#864DD9; border-width: medium">←</a>
						<a class="btn btn-outline-warning btn-lg" id="down" onmousedown="tire_button_down('down')" onmouseup="tire_button_up('down')" onclick="click_down()" style="border-color:#864DD9; border-width: medium">↓</a>
						<a class="btn btn-outline-warning btn-lg" id="right" onmousedown="tire_button_down('right')" onmouseup="tire_button_up('right')" onclick="click_right()" style="border-color:#864DD9; border-width: medium">→</a>
					</div><br/>
					
				</div>

             	
		        
<!-- 		    <input id="MotorSpeed" value="60 km/h" style="background-color: #2d3035; border-color: transparent; font-size: xx-large; font-weight: bold; color: lightgray; position: absolute; top:370px; width: 380px; margin-left: 5px"></input> -->
	            <%-- 서보 각도에 따라 핸들 돌리기 (캔버스로 대체할 것임)
	            <section>
		          <div class="container-fluid">
		         	<div class="container">
		         	<img id=image_steering src="${pageContext.request.contextPath}/resource/img/steering.png" style=" width: 150px; height: 150px; position: absolute; left: 140px; top: 550px"/>
					</div>
		          </div>
		        </section>
		        <img src="${pageContext.request.contextPath}/resource/img/driverseat.jpg" style="width: 490px; height: 240px; margin-left: 30px; margin-top: 0px"/> --%>
		 		
		 		<!-- 
         		<div style="opacity: 0.3">
	                <button class="up"  style="height:50px; width:50px;">△</button><br/>
	                <button class="left"  style="height:50px; width:50px;">◁</button>
	                <button class="center" style="height:50px; width:50px;">□</button>
	                <button class="right" style="height:50px; width:50px;">▷</button><br/>
	                <button class="down" style="height:50px; width:50px;">▽</button>
            	</div>
			 -->	
		 	
			  
				<!-- jet racer # 2 -->
			 	<div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
		      	<div id=showView style="margin-top: 10px; margin-left: 30px">
             		<div id="title" style="background-color: #864DD9; width: 490px; color: white; font-weight: bold;justify-content: center;">Line Tracing Situation</div>
             		<div id="vacant" style="background-color: transparent; width: 5px"></div>
             		<div id=batteryMode>
	              		<div id="batMode" style="width: 190px">
	              			<input id="batt2" value="Battery" style="border-color: transparent; background-color: #ADFF2F; text-align: center; color: black; width: 190px; font-weight: bold;justify-content: center;">
	              		</div>
						<div id="adtMode" style="width: 190px">
							<input id="adtt2" value="Adapter Connected" style="border-color: transparent; background-color:dimgray; text-align: center; color: white; width: 190px; font-weight: bold;justify-content: center;">
						</div>
              		</div>
             	</div>
             	
             	<img id=jetView2 style="width: 490px; height: 370px; padding-left: 0px; padding-right: 0px; margin-left: 30px; margin-top: 0px"/>

		      	<section class="no-padding-top no-padding-bottom" style="top:115px; position: absolute">
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
		        
		        <div id=showView style="margin-top: 10px; margin-left: 30px">
             		<div id="title" style="background-color: #864DD9; width: 490px; color: white; font-weight: bold;justify-content: center;">Driving Situation</div>
             		<div id="vacant" style="background-color: transparent; width: 5px"></div>
             		<div id="title" style="background-color: #864DD9; width: 380px; color: white; font-weight: bold;justify-content: center;">Manual Control</div>
             	</div>

				
					<div id="tire_control" align="center" style="margin-top: 10px; margin-left: 70px">
						<a class="btn btn-outline-warning btn-lg" id="up" onmousedown="tire_button_down('up')" onmouseup="tire_button_up('up')" onclick="click_up()"style="margin-bottom: 5px; border-color:#864DD9; border-width: medium; ">↑</a><br/>
						<a class="btn btn-outline-warning btn-lg" id="left" onmousedown="tire_button_down('left')" onmouseup="tire_button_up('left')" onclick="click_left()" style="border-color:#864DD9; border-width: medium">←</a>
						<a class="btn btn-outline-warning btn-lg" id="down" onmousedown="tire_button_down('down')" onmouseup="tire_button_up('down')" onclick="click_down()" style="border-color:#864DD9; border-width: medium">↓</a>
						<a class="btn btn-outline-warning btn-lg" id="right" onmousedown="tire_button_down('right')" onmouseup="tire_button_up('right')" onclick="click_right()" style="border-color:#864DD9; border-width: medium">→</a>
					</div><br/>
			  </div>
			  
			  <!-- jet racer # 3 -->
			  <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
		        <div id=showView style="margin-top: 10px; margin-left: 30px">
             		<div id="title" style="background-color: #864DD9; width: 490px; color: white; font-weight: bold;justify-content: center;">Line Tracing Situation</div>
             		<div id="vacant" style="background-color: transparent; width: 5px"></div>
             		<div id=batteryMode>
	              		<div id="batMode" style="width: 190px">
	              			<input id="batt3" value="Battery" style="border-color: transparent; background-color: #ADFF2F; text-align: center; color: black; width: 190px; font-weight: bold;justify-content: center;">
	              		</div>
						<div id="adtMode" style="width: 190px">
							<input id="adtt3" value="Adapter Connected" style="border-color: transparent; background-color:dimgray; text-align: center; color: white; width: 190px; font-weight: bold;justify-content: center;">
						</div>
              		</div>
             	</div>
             	
             	<img id=jetView3 style="width: 490px; height: 370px; padding-left: 0px; padding-right: 0px; margin-left: 30px; margin-top: 0px"/>

		      	<section class="no-padding-top no-padding-bottom" style="top:115px; position: absolute">
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
		                    <div id="jet3Battery" role="progressbar" style="width: 100%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-1"></div>
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
		        
		        <div id=showView style="margin-top: 10px; margin-left: 30px">
             		<div id="title" style="background-color: #864DD9; width: 490px; color: white; font-weight: bold;justify-content: center;">Driving Situation</div>
             		<div id="vacant" style="background-color: transparent; width: 5px"></div>
             		<div id="title" style="background-color: #864DD9; width: 380px; color: white; font-weight: bold;justify-content: center;">Manual Control</div>
             	</div>

				
					<div id="tire_control" align="center" style="margin-top: 10px; margin-left: 70px">
						<a class="btn btn-outline-warning btn-lg" id="up" onmousedown="tire_button_down('up')" onmouseup="tire_button_up('up')" onclick="click_up()"style="margin-bottom: 5px; border-color:#864DD9; border-width: medium; ">↑</a><br/>
						<a class="btn btn-outline-warning btn-lg" id="left" onmousedown="tire_button_down('left')" onmouseup="tire_button_up('left')" onclick="click_left()" style="border-color:#864DD9; border-width: medium">←</a>
						<a class="btn btn-outline-warning btn-lg" id="down" onmousedown="tire_button_down('down')" onmouseup="tire_button_up('down')" onclick="click_down()" style="border-color:#864DD9; border-width: medium">↓</a>
						<a class="btn btn-outline-warning btn-lg" id="right" onmousedown="tire_button_down('right')" onmouseup="tire_button_up('right')" onclick="click_right()" style="border-color:#864DD9; border-width: medium">→</a>
					</div><br/>
		  </div>
		
			
		<!--  Template 관련 설정 파일들 -->
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/bootstrap/css/bootstrap.min.css">
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/font-awesome/css/font-awesome.min.css">
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/css/font.css">
	    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Muli:300,400,700">
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/css/style.default.css" id="theme-stylesheet">
	    
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/popper.js/umd/popper.min.js"> </script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/bootstrap/js/bootstrap.min.js"></script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/jquery.cookie/jquery.cookie.js"> </script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/jquery-validation/jquery.validate.min.js"></script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/js/front.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js"></script>
	    
	    <link rel=icon href="${pageContext.request.contextPath}/resource/img/jetracer.png">



	</body>
</html>
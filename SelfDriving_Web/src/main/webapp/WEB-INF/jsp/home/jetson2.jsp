<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Jetson</title>
	<link rel=icon href="${pageContext.request.contextPath}/resource/img/jetracer.png">
   <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
   <script src="${pageContext.request.contextPath}/resource/jquery/jquery-3.4.1.min.js" crossorigin="anonymous"></script>
   <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/css/font.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Muli:300,400,700">
	<link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/css/style.default.css" id="theme-stylesheet">
	
		
	<script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/bootstrap/js/bootstrap.min.js"></script>
   <script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
   <script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
   <script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
   <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
   <script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
   <!-- MQTT -->   
   <script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
   
   <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/popper.js/umd/popper.min.js"> </script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/bootstrap/js/bootstrap.min.js"></script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/jquery.cookie/jquery.cookie.js"> </script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/jquery-validation/jquery.validate.min.js"></script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/js/front.js"></script>
   <!-- 탐지 css -->   
   <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/jetson2.css">

</head>
<body id="jet-racer2">
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
            <div class="list-inline-item logout"><a id="logout" href="${pageContext.request.contextPath}/home/intro.do" class="nav-link"> <span class="d-none d-sm-inline">to INTRO </span><i class="icon-logout"></i></a></div>
          </div>
        </div>
      </nav>
    </header>
    
    <div class="d-flex align-items-stretch" style="height: 875px;">
    
      <nav id="sidebar" style="height: 1030px;">
        <div class="sidebar-header d-flex align-items-center">
          <div class="avatar" style="width: 100px; height: 100px; align-itself: center; "><img src="${pageContext.request.contextPath}/resource/img/milk.jpg" class="img-fluid rounded-circle"></div>
          <div class="title">
            <h1 class="h5" style="color: lightgray">AIoT</h1>
            <p style="color: lightgray">관리자</p>
          </div>
        </div>
        <span class="heading" style="color: #DB6574">CATEGORIES</span>
        <ul class="list-unstyled">
          <li><a href="${pageContext.request.contextPath}/home/main.do" style="color: lightgray"> <i class="icon-home"></i>메인 페이지</a></li>
	          <li class="active"><a href="${pageContext.request.contextPath}/home/jetracer.do" style="color: lightgray"> <i class="icon-writing-whiteboard"></i>탐지봇 현황 </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/jetson1.do" style="color: lightgray;text-align: right;">   1번탐지봇 현황 </a></li>
	      	  <li class="active"><a href="${pageContext.request.contextPath}/home/jetson2.do" style="color: lightgray;text-align: right;">   2번탐지봇 현황 </a></li>
	      	  <li><a href="${pageContext.request.contextPath}/home/jetson3.do" style="color: lightgray;text-align: right;">   3번탐지봇 현황 </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/history.do" style="color: lightgray"> <i class="icon-grid"></i>탐지 히스토리 조회 </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/status.do" style="color: lightgray"> <i class="icon-padnote"></i>실시간 탐지 | 대응 현황</a></li>
	      	  <li><a href="${pageContext.request.contextPath}/home/analysis.do" style="color: lightgray"> <i class="icon-chart"></i>탐지 결과 분석  </a></li>
	      	  
	      	  
        </ul>
      </nav>    
	      <div class="page-content" style="top: -50px; height: 1080px; padding-bottom: 0px; " >

<div class="hoverbox location" id="hoverbox">
    <div class="screen">
       <img   class="hud01" src="${pageContext.request.contextPath}/resource/img/hud3/hover01.png">
       <img   class="hud02" src="${pageContext.request.contextPath}/resource/img/hud3/hover02.png">         
       <img   class="hud03" src="${pageContext.request.contextPath}/resource/img/hud3/hover03.png">
       <img   class="hud04" src="${pageContext.request.contextPath}/resource/img/hud3/hover04.png">
       <img   class="hud05" src="${pageContext.request.contextPath}/resource/img/hud3/hover05.png">              
    </div>
</div>
<!-- canvas 드로잉 판 -->
<div id = "total">
  <!-- 카메라 캔버스 -->
   <canvas id="cameraLayer"></canvas>
   
   <!-- 탐지 css 설명 캔버스 -->
   <div class="catchlist" id="catchlist">    	
   </div>     
 </div>

<!-- ------------------------------------------------------------------------------------------------------------- -->

<!-- Left Menu -->

<div id="leftmenu">
<div id="date_time">
    <div id="date" class="semi_arc e4">
      <div class="semi_arc_2 e4_1">
        <div class="counterspin4"></div>
      </div>
        <div style="font-size: 40px; margin-top: 15px;" id="monthbox">04</div>
        <div style="margin-top:-80px ;font-size: 25px;" id="monthboxEK">January</div>
    </div>  
  
    
    <div id="time" class="arc e1">
        <div style="margin-top:40px;font-size: 23px; margin-left: 3px;" id="nowtime">23:41</div>
        <div style="margin-top:20px;font-size: 17px;" id="nowday">Tuesday</div>
    </div>
  </div>
  
  
  <span class="menuitem entypo-gauge">
    <p id="cpu" class="caption" >Speed: --km/h</p>
  </span> <br/>
  
  <span class="menuitem entypo-chart-area">
    <p id="ram" class="caption" >MQTT: Wifi</p>
  </span> <br/>
  
  <span class="menuitem entypo-chart-pie">
    <p id="proc" class="caption">Battery: --%</p>
  </span>
  
  

  
   
</div>


<!-- Right Menu -->
<article>
<div id="rightmenu">
    <p id="headline" class="title" style="text-align: left; margin-left: 10px;display: none;">Detection Object List</p>
    
  
	<div id="text">
		<div id="checkelement">
			<img id="textboximg" src="${pageContext.request.contextPath}/resource/img/도로사진/admin2.png">
			 <div id="textboxline">List Name : --</div>
		</div>
	</div>
</div>
</article>
				
  				<input value="Motion Detection" readonly="readonly" style="border-color: transparent ; background-color: #864DD9 ; text-align: center; color: white;  font-weight: bold;justify-content: center;width: 320px; position: absolute; top: 325px; left: 1260px; height: 30px;">
  				<img id=motionView style="width: 320px; height: 280px; position: absolute; top: 355px; left: 1260px"/>
				
				<section class="no-padding-top no-padding-bottom" style="top:640px; left: 1260px; position: absolute;padding: 0px">
		          <div class="container-fluid">
		            <div class="row" style="width: 320px; height: 200px" >
		              <div class="col-md-3 col-sm-6" style="padding: 0px; height: 170px">
		                <div class="statistic-block block" style="justify-content: center; padding: 0px; width: 320px; margin-bottom: 10px">
		                  <div class="progress-details d-flex align-items-end justify-content-between" style="justify-content: center;height: 80px; padding: 0px">
		                    <div class="title" style="justify-content: center; margin: 15px">
		                      <div class="icon"><i class="icon-info"></i></div><strong style="color: white">Detected Motion</strong>
		                    </div>
		                    <div id="motionName2" style="color: #864DD9; font-size: x-large;  font-weight:bold; ; margin-right: 15px; margin-bottom: 15px">
		                    	---
		                    </div>
		                 </div>
		                </div>
 		                <div class="statistic-block block" style="justify-content: center; padding: 0px; width: 320px">
		                  <div class="progress-details d-flex align-items-end justify-content-between" style="justify-content: center; height: 80px">
		                    <div class="title" style="justify-content: center; margin: 15px">
		                      <div class="icon"><i class="icon-info"></i></div><strong style="color: white">Target Action</strong>
		                    </div>
		                    <div id="targetSpeed2" style="color: #864DD9; font-size: x-large;  font-weight:bold; ; margin-right: 15px; margin-bottom: 15px">
		                    	Speed : ---
		                    </div>
		                 </div>
		                </div>
		              </div>
		            </div>
		          </div>
		        </section>
				<input value="Driving Mode" readonly="readonly" style="border-color: transparent ; background-color: #864DD9 ; text-align: center; color: white;font-weight: bold;justify-content: center; width: 320px; position: absolute; top: 820px; left: 1260px; height: 30px">
		        <div id=batteryMode style="background-color: #864DD9; width:320px; color: white; font-weight: bold;justify-content: center; position: absolute; left: 1260px; top:820px">
           			<div style="width:320px">
             			<input id="modeOn2" onclick="manual2('On')" value="Manual Driving" readonly="readonly" style="border-color: transparent; width: 140px; background-color: dimgray; text-align: center; color: white; font-weight: bold;justify-content: center;">
             			<input id="modeOff2" onclick="manual2('Off')" value="Auto Driving" readonly="readonly" style="border-color: transparent; width: 140px; background-color: #ADFF2F; text-align: center; color: black; font-weight: bold;justify-content: center;margin-left:35px ">
             		</div>
           		</div>
				
				<div id="manual_control2" style="display:none ; width: 380px; height: 200px; position: absolute; top: 840px;">
					<div style="margin-left: 1170px; width: 320px; height:200px; position: absolute" align="center">
						<input value="Motor Ctrl" style="background-color: transparent; border-color: transparent; font-weight: bold; font-size: large; color: white; text-align: center; width: 160px; display: none;"></br>
						<a class="btn btn-outline-warning btn-lg" id="up" onmousedown="tire_button_down('up')" onmouseup="tire_button_up('up')" onclick="click_up()"style=" margin-bottom:5px ;border-color:#ADFF2F; border-width: medium; font-weight: bold;">↑</a><br/>
						<a class="btn btn-outline-warning btn-lg" id="left" onmousedown="tire_button_down('left')" onmouseup="tire_button_up('left')" onclick="click_left()" style="border-color:#ADFF2F; border-width: medium; font-weight: bold;">←</a>
						<a class="btn btn-outline-warning btn-lg" id="down" onmousedown="tire_button_down('down')" onmouseup="tire_button_up('down')" onclick="click_down()" style="border-color:#ADFF2F; border-width: medium; font-weight: bold;">□</a>
						<a class="btn btn-outline-warning btn-lg" id="right" onmousedown="tire_button_down('right')" onmouseup="tire_button_up('right')" onclick="click_right()" style="border-color:#ADFF2F; border-width: medium; font-weight: bold;">→</a></br>
 						<a class="btn btn-outline-warning btn-sm manual-line" onclick="manual('W')" style="color: black">L Line</a>
						<a class="btn btn-outline-warning btn-sm manual-line" onclick="manual('W')" style="color: black">R Line</a>
					</div>
					</div>
<!-- Map canvas box -->
<div class="mapcanvasbox">
	<canvas class="map"></canvas>
    <canvas class="car" style="border: 1px solid black;"></canvas>
</div>

<!-- MINI Map canvas box -->
<canvas class="hud"></canvas>
<canvas class="hud"></canvas>

<!-- Radar box -->
<div class="Radarbox">
	<div class="radar">
	  <div class="pointer"></div>
	  <div class="shadow"></div>
	</div>
</div>

<canvas id="arrowcanvas" width="1200" height="400"></canvas>

<div id="backgroundbox"class="backgroundbox"></div>
<div class="backgroundbox2"></div>
</div>
</div>
<!-- ------------------------------------------------------------------------------------------------------------- -->
<!-- Jarvis Canvas Script -->
<script>

function manual2(value){
	console.log("메뉴얼 2 실행해보자");
	console.log(value);

	if (value == 'On'){
		document.getElementById('modeOn2').style.backgroundColor = '#ADFF2F';
		document.getElementById('modeOn2').style.color = 'black';
		document.getElementById('modeOff2').style.backgroundColor = 'dimgray';
		document.getElementById('modeOff2').style.color = 'white';
		document.getElementById('manual_control2').style.display = 'block';
		
		alert("Converting to Manual Driving Mode-2");
		
		$("#jet-racer2").keydown(function(event) {
			if (event.keyCode == '38'){
			  	console.log("달리자2");
				message = new Paho.MQTT.Message("speed");
				message.destinationName = "/2manual/go";
				message.qos = 0;
				client.send(message);
				console.log(message);
			}
			if (event.keyCode == '40'){ 	
				console.log("멈추자2");
				  	message = new Paho.MQTT.Message("speed");
				message.destinationName = "/2manual/stop";
				message.qos = 0;
				client.send(message);
			}
			if (event.keyCode == '37'){
			  	console.log("toL2");
				  	message = new Paho.MQTT.Message("lineChangeToL");
				message.destinationName = "/2manual/toL";
				message.qos = 0;
				client.send(message);
				console.log(message);
			}
			if (event.keyCode == '39'){ 	
				console.log("toR2");
				  	message = new Paho.MQTT.Message("lineChangeToR");
				message.destinationName = "/2manual/toR";
				message.qos = 0;
				client.send(message);
			}
		});
	}

	else if (value == 'Off'){
		console.log("메뉴얼 2 종료");
		console.log(value);
		
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


</script>


 

<script>
// MQTT 통신 Script ----------------------------------------------------------------------------
var   centerx = 0;
var   centery = 0;
var   x1 = 0;
var   y1 = 0;
var   x2 = 0;
var   y2 = 0;
var   totalnum = 0;
var leftx;
var rightx;
var middlex;
//--------------------------------------------------------------------------------------------
//MQTT new client
let ipid;
var lastSendtimearr = [Date.now(), Date.now(), Date.now()];
var subList=["1jetracer", "2jetracer","3jetracer"];
$(function(){
	ipid=new Date().getTime().toString()
   client = new Paho.MQTT.Client("192.168.3.105", 61614, ipid);
   client.onMessageArrived = onMessageArrived;
   client.connect({onSuccess:onConnect});
});

//MQTT onConnect
function onConnect() {
   client.subscribe("/req/2jetracer");
   client.subscribe("/mirror");
}

$(document).ready(function() {
    setInterval(getinterval, 750);
});  
 
 var lastSendtime=Date.now();
 
 function getinterval(){
	nowtime= Date.now();
	lastSendtimearr.forEach(function(element, index, array){
		interval=nowtime-element
		if(interval>750){
			//console.log("연결이 끊긴다음"+subList[index]+ "몇초가 흘렀는지를 보여주는 console.log의 시간:"+interval);
			response(index);
		}
	});
}
 function response(index){
		//console.log(subList[index]+"에게 답장을 보내쥬");
		message = new Paho.MQTT.Message(ipid);
		message.destinationName = "/res/"+subList[index];
		client.send(message);
	}
//MQTT onMessageArrived
function onMessageArrived(message) {
/////////////////////////////////////////////////////mirror//////////////////////////////////////
	if(message.destinationName =="/mirror") {
		const json = message.payloadString;
			const obj = JSON.parse(json);
		$("#motionView").attr("src", "data:image/jpg;base64,"+ obj.Cam);
		
		handMotion = obj.hands;
		console.log(handMotion);
		
		if(handMotion=='rock'){
			$("#motionName2").text('STOP');
			$("#targetSpeed2").text("Speed : 0");
			
			message = new Paho.MQTT.Message("speed:"+ 0);
			message.destinationName = "/2motion/stop";
			message.qos = 0;
			client.send(message);
		}
		
		else if(handMotion=='5fingers'){
			$("#motionName2").text('GO');
			$("#targetSpeed2").text("Speed : 60");
			
			message = new Paho.MQTT.Message("speed:"+ 60);
			message.destinationName = "/2motion/go";
			message.qos = 0;
			client.send(message);
		}
		
		else if(handMotion=='unlabeled'){
			$("#motionName2").text('---');
			$("#targetSpeed2").text("Speed : ---");
		}

		if(obj.direction=="left"){
			location.href="main.do";
		}
		
		else if (obj.direction=="right"){
			location.href="history.do";
		}

	}
	////////////////////////////////////////////////////////racer//////////////////////////////////////
	  if (message.destinationName == "/req/2jetracer") {
		  	
			//console.log(message.payloadString);
			const json = message.payloadString;
			const obj = JSON.parse(json);
			image.src= "data:image/jpg;base64,"+ obj.Cam;

			console.log("3jet:뱉"+obj.battery);
			console.log("3jet:섭"+obj.servo);
			console.log("3jet:슾"+obj.speed);
			console.log("3jet:랍"+obj.Class);
			console.log("3jet:밗"+obj.boxes);
			console.log("3jet:렢"+obj.line_left);
			console.log("3jet:뢑"+obj.line_right);
			 var speed=obj.speed;
			 realspeed = speed;
	          realspeed = realspeed.toFixed(0); //소수점 제거
	          //speed
	          $("#cpu").text("Speed: " + String(realspeed) + "km/h");
	          
	          if(obj.line_left){
	        	  leftx=obj.line_left;
	          }else{
	        	  leftx=0;
	          }
	          if(obj.line_right){
	        	  rightx=obj.line_right;
	          }else{
	        	  rightx=300;
	          }
	          
	          
	        //갯지렁이
	          var pointx = 160;
		      var pointy = 160;
		      var pointX = (leftx+rightx)/2;
		      var pointY = 160;
		      pointx1 = parseInt(Number(pointx) * 4);
				 pointy1 = parseInt(Number(pointy) * 3);
				 //파란 좌표
			 	 pointX1 = parseInt(Number(pointX) * 4 );
			 	 pointY1 = parseInt(Number(pointY) * 3);  		 	 
			 	 
			 	var arrowline = document.querySelector('#arrowcanvas');

			 	function arrowmap () {
			 		var arrowctx = arrowline.getContext('2d');
			 		arrowctx.clearRect(0, 0, arrowline.width, arrowline.height);
			 		
			 		arrowctx.beginPath();
			 		arrowctx.moveTo(600, 400);
			 		arrowctx.quadraticCurveTo(600, 200, pointX1, 120);
			 		
			 		arrowctx.strokeStyle = "#FF3535";    // 선색 변경
			 		arrowctx.lineWidth = 10;             // 선 두깨 설정
			 		arrowctx.shadowOffsetX = 0;
			 		arrowctx.shadowOffsetY = 0;
			 		arrowctx.shadowBlur = 20;
			 		arrowctx.shadowColor = "#FF3535";
			 		
			 		arrowctx.stroke();
			 	}
			 	setInterval(arrowmap, 20)
			//배터리
			//var batterylog
			$("#proc").text("Battery: " + Math.round(obj.battery/10)*10 + "%");
			 	
			 //객체	
		     	
		        var messageKey = obj.Class.length;
				console.log(messageKey);
		        if (messageKey == 0){
		        	$("#total").children().remove(".hoverbox");
		        }
		    	
		        var hoverone = document.getElementById("hoverbox");   
		        var textboxlineone = document.getElementById("textboxline");

		        if(obj.Class.length == 0){
					console.log("----");	
					$("#textboxline").css("color","#FE2E2E");
					document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/admin2.png";
					$("#textboximg").css("box-shadow","0 0 0px #FF3535, 0 0 0px #FF3535");
					$("#textboximg").css("border","3px solid #FE2E2E");
					$("#textboxline").text("List Name : --");	
				}
		        
				for (var i = 0; i < messageKey; i++) {	
					if (totalnum > messageKey) {
						for (var j = messageKey; j < totalnum; j++) {
							$("#hoverbox" + j).remove();
						}
					}		
					
					totalnum = messageKey
					var chk = document.getElementById("hoverbox" + i);
					var textboxlinechk = document.getElementById("textboxline");
					
					if (chk == null) {
						var hoverchild = hoverone.cloneNode(true);
						hoverchild.setAttribute("id", "hoverbox" + i);
						$("#total").append(hoverchild);
					}
					console.log("박스를 그린다.");
					var Num = obj.boxes[i];
					var x1 = obj.boxes[i][0];
					var y1 = obj.boxes[i][1];
					var x2 = obj.boxes[i][2];
					var y2 = obj.boxes[i][3];
					console.log("하이영"+x1+","+y1+","+x2+","+y2);
					
					var name = obj.Class[i];											
					console.log("하이영2:"+name);
					if(name.length != 0){								
						$("#textboxline").remove();
						var textboxlinechild = textboxlineone.cloneNode(true);
						textboxlinechild.setAttribute("id", "textboxline");
						$("#checkelement").append(textboxlinechild);	
						
						if(changenum != name){
							if(name.length == 1){
								console.log("지점 감지");
								$("#textboxline").text("Current Location : " + "[" + name + "]");	
								$("#textboxline").css("color","#FE2E2E");
								$("#textboximg").css("box-shadow","0 0 10px #FF3535, 0 0 10px #FF3535");
								$("#textboximg").css("border","3px solid #FF3535");
								if(name == "A"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/a.jpg";
								}else if(name == "B"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/b.jpg";
								}else if(name == "C"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/c.jpg";
								}else if(name == "D"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/d.jpg";
								}else if(name == "E"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/e.jpg";
								}else if(name == "F"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/f.jpg";
								}else if(name == "H"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/h.jpg";
								}else if(name == "I"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/i.jpg";
								}else if(name == "J"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/j.jpg";
								}else if(name == "K"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/k.jpg";
								}else if(name == "M"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/m.jpg";
								}else if(name == "N"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/n.jpg";
								}else if(name == "P"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/p.jpg";
								}else if(name == "S"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/s.jpg";
								}else if(name == "T"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/t.jpg";
								}
							}else if(name.length > 1){				
								console.log("객체 감지");
								$("#textboxline").text("Object Detection : " + "[" + name + "]");
								$("#textboxline").css("color","#FE2E2E");
								$("#textboximg").css("box-shadow","0 0 10px #FF3535, 0 0 10px #FF3535");
								$("#textboximg").css("border","3px solid #FF3535");
								if(name == "unlabeled"){
									document.getElementById("textboximg").src="";
								}else if(name == "red"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/traficlight.jpg";
								}else if(name == "green"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/traficlight.jpg";
								}else if(name == "yellow"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/traficlight.jpg";
								}else if(name == "crosswalk"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/crosswalk.jpg";
								}else if(name == "schoolzone"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/schoolzone.jpg";
								}else if(name == "stop"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/stop.jpg";
								}else if(name == "60"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/60.jpg";
								}else if(name == "100"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/100.jpg";
								}else if(name == "speed"){
									document.getElementById("textboximg").src="";
								}else if(name == "car"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/jetson.png";
								}else if(name == "cone"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/cone.jpg";
								}else if(name == "bump"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/bump.jpg";
								}else if(name == "curve"){
									document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/curve.jpg";
								}
							}				
						}
					var changenum = name;							
					}
					
					x1 = parseInt(Number(x1) * 4 );
					y1 = parseInt(Number(y1) * 3 );
					x2 = parseInt(Number(x2) * 4 );
					y2 = parseInt(Number(y2) * 3 );

					centerx = parseInt((x2 - x1) / 2 + x1);
					centery = parseInt((y2 - y1) / 2 + y1);

					$("#hoverbox" + i).css("margin-top", centery + "px");
					$("#hoverbox" + i).css("margin-left", centerx + "px");

					image.onload(centerx, centery, messageKey);
						
						
		            var location = name;
		            var x;
		            var y;
		            if(location == "A") {
		               x = carLocation.A[0];
		               y = carLocation.A[1];
		            }else if(location == "B") {
		               x = carLocation.B[0];
		               y = carLocation.B[1];
		            }else if(location == "C") {
		               x = carLocation.C[0];
		               y = carLocation.C[1];
		            }else if(location == "D") {
		               x = carLocation.D[0];
		               y = carLocation.D[1];
		            }else if(location == "E") {
		               x = carLocation.E[0];
		               y = carLocation.E[1];
		            }else if(location == "F") {
		               x = carLocation.F[0];
		               y = carLocation.F[1];
		            }else if(location == "H") {
		               x = carLocation.H[0];
		               y = carLocation.H[1];
		            }else if(location == "I") {
		               x = carLocation.I[0];
		               y = carLocation.I[1];
		            }else if(location == "J") {
		               x = carLocation.J[0];
		               y = carLocation.J[1];
		            }else if(location == "K") {
		               x = carLocation.K[0];
		               y = carLocation.K[1];
		            }else if(location == "M") {
		               x = carLocation.M[0];
		               y = carLocation.M[1];
		            }else if(location == "N") {
		               x = carLocation.N[0];
		               y = carLocation.N[1];
		            }else if(location == "P") {
		               x = carLocation.P[0];
		               y = carLocation.P[1];
		            }else if(location == "S") {
		               x = carLocation.S[0];
		               y = carLocation.S[1];
		            }else if(location == "T") {
		               x = carLocation.T[0];
		               y = carLocation.T[1];
		            }
		            mapArea.setCarLocation(x, y);
		            mapArea.drawCar();
		            
		            imgMap.src = canvasMap.toDataURL();
		            imgCar.src = canvasCar.toDataURL();
		            
		           carLocX = mapArea.getCarLocX();
		           carLocY = mapArea.getCarLocY();
					//map 추가2 end
				}// for문 
				
				response(1);
				lastSendtimearr[1] = Date.now();
	  }//jetracer 읽을때
	/* 
	  if (message.destinationName == "/speed") {		 
		  var speed = JSON.parse(message.payloadString);
		  
          realspeed = speed * 100 * -1;
          realspeed = realspeed.toFixed(0); //소수점 제거
          
          $("#cpu").text("Speed: " + String(realspeed) + "km/h");       
      }
	 */
	  /* if (message.destinationName == "/curr_dir") {
	         var dir = JSON.parse(message.payloadString);
// 	         console.log(dir);
	         var arrowNum = JSON.parse(message.payloadString);
	         var pointx = arrowNum.center_x;
	         var pointy = arrowNum.center_y;
	         var pointX = arrowNum.val_centerX;
	         var pointY = arrowNum.val_centerY;

	         //초록 좌표
			 pointx1 = parseInt(Number(pointx) * 4);
			 pointy1 = parseInt(Number(pointy) * 3);
			 //파란 좌표
		 	 pointX1 = parseInt(Number(pointX) * 4 );
		 	 pointY1 = parseInt(Number(pointY) * 3);  		 	 
		 	 
		 	var arrowline = document.querySelector('#arrowcanvas');

		 	function arrowmap () {
		 		var arrowctx = arrowline.getContext('2d');
		 		arrowctx.clearRect(0, 0, arrowline.width, arrowline.height);
		 		
		 		arrowctx.beginPath();
		 		arrowctx.moveTo(600, 400);
		 		arrowctx.quadraticCurveTo(600, 200, pointX1, 120);
		 		
		 		arrowctx.strokeStyle = "#FF3535";    // 선색 변경
		 		arrowctx.lineWidth = 10;             // 선 두깨 설정
		 		arrowctx.shadowOffsetX = 0;
		 		arrowctx.shadowOffsetY = 0;
		 		arrowctx.shadowBlur = 20;
		 		arrowctx.shadowColor = "#FF3535";
		 		
		 		arrowctx.stroke();
		 	}
		 	setInterval(arrowmap, 20) 	 
	  } */
	/* 
      if(message.destinationName =="/Camera") {
         image.src="data:image/jpg;base64,"+ message.payloadString;          
      } */
	  
      /* if (message.destinationName == "/CurrentP") {
          var batterylog = JSON.parse(message.payloadString);     
          $("#proc").text("Battery: " + String(message.payloadString) + "%");          
       }
       */
      /* if (message.destinationName == "/Message") {        
//     	console.log("Message type : "+ JSON.parse(message.payloadString)); 
    	console.log("Message length : "+ Object.keys(JSON.parse(message.payloadString)).length); 
    	
        var messageKey = Object.keys(JSON.parse(message.payloadString)).length;

        if (messageKey == 0){
        	$("#total").children().remove(".hoverbox");
        }
    	
        var hoverone = document.getElementById("hoverbox");   
        var textboxlineone = document.getElementById("textboxline");

        if(Object.keys(JSON.parse(message.payloadString)).length == 0){
			console.log("----");	
			$("#textboxline").css("color","#FE2E2E");
			document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/admin2.png";
			$("#textboximg").css("box-shadow","0 0 0px #FF3535, 0 0 0px #FF3535");
			$("#textboximg").css("border","3px solid #FE2E2E");
			$("#textboxline").text("List Name : --");	
		}
        
		for (var i = 0; i < messageKey; i++) {	
			if (totalnum > messageKey) {
				for (var j = messageKey; j < totalnum; j++) {
					$("#hoverbox" + j).remove();
				}
			}		
			
			totalnum = messageKey
			var chk = document.getElementById("hoverbox" + i);
			var textboxlinechk = document.getElementById("textboxline");
			
			if (chk == null) {
				var hoverchild = hoverone.cloneNode(true);
				hoverchild.setAttribute("id", "hoverbox" + i);
				$("#total").append(hoverchild);
			}
			
			var Num = JSON.parse(message.payloadString)[i];
			var x1 = Num.x1;
			var y1 = Num.y1;
			var x2 = Num.x2;
			var y2 = Num.y2;
			var name = Num.name;											
			
			if(name.length != 0){								
				$("#textboxline").remove();
				var textboxlinechild = textboxlineone.cloneNode(true);
				textboxlinechild.setAttribute("id", "textboxline");
				$("#checkelement").append(textboxlinechild);	
				
				if(changenum != name){
					if(name.length == 1){
						console.log("지점 감지");
						$("#textboxline").text("Current Location : " + "[" + name + "]");	
						$("#textboxline").css("color","#FE2E2E");
						$("#textboximg").css("box-shadow","0 0 10px #FF3535, 0 0 10px #FF3535");
						$("#textboximg").css("border","3px solid #FF3535");
						if(name == "A"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/a.jpg";
						}else if(name == "B"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/b.jpg";
						}else if(name == "C"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/c.jpg";
						}else if(name == "D"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/d.jpg";
						}else if(name == "E"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/e.jpg";
						}else if(name == "F"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/f.jpg";
						}else if(name == "H"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/h.jpg";
						}else if(name == "I"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/i.jpg";
						}else if(name == "J"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/j.jpg";
						}else if(name == "K"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/k.jpg";
						}else if(name == "M"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/m.jpg";
						}else if(name == "N"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/n.jpg";
						}else if(name == "P"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/p.jpg";
						}else if(name == "S"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/s.jpg";
						}else if(name == "T"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/t.jpg";
						}
					}else if(name.length > 1){				
						console.log("객체 감지");
						$("#textboxline").text("Object Detection : " + "[" + name + "]");
						$("#textboxline").css("color","#FE2E2E");
						$("#textboximg").css("box-shadow","0 0 10px #FF3535, 0 0 10px #FF3535");
						$("#textboximg").css("border","3px solid #FF3535");
						if(name == "unlabeled"){
							document.getElementById("textboximg").src="";
						}else if(name == "red"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/traficlight.jpg";
						}else if(name == "green"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/traficlight.jpg";
						}else if(name == "yellow"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/traficlight.jpg";
						}else if(name == "crosswalk"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/crosswalk.jpg";
						}else if(name == "schoolzone"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/schoolzone.jpg";
						}else if(name == "stop"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/stop.jpg";
						}else if(name == "60"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/60.jpg";
						}else if(name == "100"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/100.jpg";
						}else if(name == "speed"){
							document.getElementById("textboximg").src="";
						}else if(name == "car"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/jetson.png";
						}else if(name == "cone"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/cone.jpg";
						}else if(name == "bump"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/bump.jpg";
						}else if(name == "curve"){
							document.getElementById("textboximg").src="${pageContext.request.contextPath}/resource/img/도로사진/curve.jpg";
						}
					}				
				}
			var changenum = name;							
			}
			
			x1 = parseInt(Number(x1) * 4 + 320);
			y1 = parseInt(Number(y1) * 3 + 0);
			x2 = parseInt(Number(x2) * 4 + 320);
			y2 = parseInt(Number(y2) * 3 + 0);

			centerx = parseInt((x2 - x1) / 2 + x1);
			centery = parseInt((y2 - y1) / 2 + y1);

			$("#hoverbox" + i).css("margin-top", centery + "px");
			$("#hoverbox" + i).css("margin-left", centerx + "px");

			image.onload(centerx, centery, messageKey);
				
				
            var location = name;
            var x;
            var y;
            if(location == "A") {
               x = carLocation.A[0];
               y = carLocation.A[1];
            }else if(location == "B") {
               x = carLocation.B[0];
               y = carLocation.B[1];
            }else if(location == "C") {
               x = carLocation.C[0];
               y = carLocation.C[1];
            }else if(location == "D") {
               x = carLocation.D[0];
               y = carLocation.D[1];
            }else if(location == "E") {
               x = carLocation.E[0];
               y = carLocation.E[1];
            }else if(location == "F") {
               x = carLocation.F[0];
               y = carLocation.F[1];
            }else if(location == "H") {
               x = carLocation.H[0];
               y = carLocation.H[1];
            }else if(location == "I") {
               x = carLocation.I[0];
               y = carLocation.I[1];
            }else if(location == "J") {
               x = carLocation.J[0];
               y = carLocation.J[1];
            }else if(location == "K") {
               x = carLocation.K[0];
               y = carLocation.K[1];
            }else if(location == "M") {
               x = carLocation.M[0];
               y = carLocation.M[1];
            }else if(location == "N") {
               x = carLocation.N[0];
               y = carLocation.N[1];
            }else if(location == "P") {
               x = carLocation.P[0];
               y = carLocation.P[1];
            }else if(location == "S") {
               x = carLocation.S[0];
               y = carLocation.S[1];
            }else if(location == "T") {
               x = carLocation.T[0];
               y = carLocation.T[1];
            }
            mapArea.setCarLocation(x, y);
            mapArea.drawCar();
            
            imgMap.src = canvasMap.toDataURL();
            imgCar.src = canvasCar.toDataURL();
            
           carLocX = mapArea.getCarLocX();
           carLocY = mapArea.getCarLocY();
			//map 추가2 end
		}// for문

	}//message publish end		 */
}

var canvas1stfloor;
var ctx;	

$(function() {
	canvas1stfloor = document.createElement("canvas")
	canvas1stfloor.width = "1200";
	canvas1stfloor.height = "900";
	ctx1stfloor = canvas1stfloor.getContext("2d");
	document.getElementById("backgroundbox").appendChild(canvas1stfloor);
});	

var image = new Image();

image.onload = function(centerx, centery, messageKey) {	
	ctx1stfloor.drawImage(image, 0, 0, 1200, 900);			
};
image.src = "";
// -------------------------------------------------------------------------------------------------------------
/* Note Matrics Script */	
function WordShuffler(holder,opt){
  var that = this;
  var time = 0;
  
  this.now;
  this.then = Date.now();
  this.delta;
  this.currentTimeOffset = 0;
  this.word = null;
  this.currentWord = null;
  this.currentCharacter = 0;
  this.currentWordLength = 0;
  
  var options = {
    fps : 20,
    timeOffset : 5,
    textColor : '#FF3535',
    fontSize : "50px",
    useCanvas : false,
    mixCapital : false,
    mixSpecialCharacters : false,
    needUpdate : true,
    colors : [
      '#FF3535'
    ]
  }

  if(typeof opt != "undefined"){
    for(key in opt){
      options[key] = opt[key];
    }
  }

  this.needUpdate = true;
  this.fps = options.fps;
  this.interval = 1000/this.fps;
  this.timeOffset = options.timeOffset;
  this.textColor = options.textColor;
  this.fontSize = options.fontSize;
  this.mixCapital = options.mixCapital;
  this.mixSpecialCharacters = options.mixSpecialCharacters;
  this.colors = options.colors;

   this.useCanvas = options.useCanvas;
  
  this.chars = [
    'A','B','C','D',
    'E','F','G','H',
    'I','J','K','L',
    'M','N','O','P',
    'Q','R','S','T',
    'U','V','W','X',
    'Y','Z'
  ];
  this.specialCharacters = [
    '!','§','$','%',
    '&','/','(',')',
    '=','?','_','<',
    '>','^','°','*',
    '#','-',':',';',
    'a','b','c','d',
    'e','f','g','h',
    'I','j','K','l',
    'm','n','o','p',
    'q','r','s','t',
    'u','v','w','x',
    'y','z'
  ]

  if(this.mixSpecialCharacters){
    this.chars = this.chars.concat(this.specialCharacters);
  }

  this.getRandomColor = function () {
    var randNum = Math.floor( Math.random() * this.colors.length );
    return this.colors[randNum];
  }

  //if Canvas
 
  this.position = {
    x : 0,
    y : 50
  }

  //if DOM
  if(typeof holder != "undefined"){
    this.holder = holder;
  }

  if(!this.useCanvas && typeof this.holder == "undefined"){
    console.warn('Holder must be defined in DOM Mode. Use Canvas or define Holder');
  }


  this.getRandCharacter = function(characterToReplace){    
    if(characterToReplace == " "){
      return ' ';
    }
    var randNum = Math.floor(Math.random() * this.chars.length);
    var lowChoice =  -.5 + Math.random();
    var picketCharacter = this.chars[randNum];
    var choosen = picketCharacter.toLowerCase();
    if(this.mixCapital){
      choosen = lowChoice < 0 ? picketCharacter.toLowerCase() : picketCharacter;
    }
    return choosen;
    
  }

  this.writeWord = function(word){
    this.word = word;
    this.currentWord = word.split('');
    this.currentWordLength = this.currentWord.length;

  }

  this.generateSingleCharacter = function (color,character) {
    var span = document.createElement('span');
    span.style.color = color;
    span.innerHTML = character;
    return span;
  }

  this.updateCharacter = function (time) {
    
      this.now = Date.now();
      this.delta = this.now - this.then;

       

      if (this.delta > this.interval) {
        this.currentTimeOffset++;
      
        var word = [];

        if(this.currentTimeOffset === this.timeOffset && this.currentCharacter !== this.currentWordLength){
          this.currentCharacter++;
          this.currentTimeOffset = 0;
        }
        for(var k=0;k<this.currentCharacter;k++){
          word.push(this.currentWord[k]);
        }

        for(var i=0;i<this.currentWordLength - this.currentCharacter;i++){
          word.push(this.getRandCharacter(this.currentWord[this.currentCharacter+i]));
        }


        if(that.useCanvas){
          c.clearRect(0,0,stage.x * stage.dpr , stage.y * stage.dpr);
          c.font = that.fontSize + " sans-serif";
          var spacing = 0;
          word.forEach(function (w,index) {
            if(index > that.currentCharacter){
              c.fillStyle = that.getRandomColor();
            }else{
              c.fillStyle = that.textColor;
            }
            c.fillText(w, that.position.x + spacing, that.position.y);
            spacing += c.measureText(w).width;
          });
        }else{

          if(that.currentCharacter === that.currentWordLength){
            that.needUpdate = false;
          }
          this.holder.innerHTML = '';
          word.forEach(function (w,index) {
            var color = null
            if(index > that.currentCharacter){
              color = that.getRandomColor();
            }else{
              color = that.textColor;
            }
            that.holder.appendChild(that.generateSingleCharacter(color, w));
          }); 
        }
        this.then = this.now - (this.delta % this.interval);
      }
  }

  this.restart = function () {
    this.currentCharacter = 0;
    this.needUpdate = true;
  }

  function update(time) {
    time++;
    if(that.needUpdate){
      that.updateCharacter(time);
    }
    requestAnimationFrame(update);
  }

  this.writeWord(this.holder.innerHTML);
  update(time);
}

var headline = document.getElementById('headline');

var headText = new WordShuffler(headline,{
  textColor : '#FF3535',
  timeOffset : 5,
  mixCapital : true,
  mixSpecialCharacters : true
});
// -------------------------------------------------------------------------------------------------------------
/* 오늘 날짜 및 변환  */
var nowDate = new Date();
var nowYear = nowDate.getFullYear();
var nowMonth = nowDate.getMonth() +1;
var nowDay = nowDate.getDate();
var week = new Array('일','월','화','수','목','금','토');
var totaynow = week[nowDate.getDay()]
var hournow = nowDate.getHours();
var minutenow = nowDate.getMinutes();
if(nowMonth < 10) { nowMonth = "0" + nowMonth; }
if(nowDay < 10) { nowDay = "0" + nowDay; }

//현재 달(숫자)
$('#monthbox').text(String(nowMonth));	

//현재 달(영문)
if(String(nowMonth) == "01"){
	$('#monthboxEK').text("January");
}else  if(String(nowMonth) == "02"){
	$('#monthboxEK').text("February");
}else  if(String(nowMonth) == "03"){
	$('#monthboxEK').text("March");
}else  if(String(nowMonth) == "04"){
	$('#monthboxEK').text("April");
}else  if(String(nowMonth) == "05"){
	$('#monthboxEK').text("May");
}else  if(String(nowMonth) == "06"){
	$('#monthboxEK').text("June");
}else  if(String(nowMonth) == "07"){
	$('#monthboxEK').text("July");
}else  if(String(nowMonth) == "08"){
	$('#monthboxEK').text("August");
}else  if(String(nowMonth) == "09"){
	$('#monthboxEK').text("September");
}else  if(String(nowMonth) == "10"){
	$('#monthboxEK').text("October");
}else  if(String(nowMonth) == "11"){
	$('#monthboxEK').text("November");
}else  if(String(nowMonth) == "12"){
	$('#monthboxEK').text("December");
}; 
	
//현재 시각(숫자)	
$('#nowtime').text(String(hournow + ":" + minutenow));

//현재 날짜(숫자)		
if(String(nowDay) == "01"){
	$('#nowday').text("January");
}else  if(String(totaynow) == "일"){
	$('#nowday').text("Sunsay");
}else  if(String(totaynow) == "월"){
	$('#nowday').text("Monday");
}else  if(String(totaynow) == "화"){
	$('#nowday').text("Tuesday");
}else  if(String(totaynow) == "수"){
	$('#nowday').text("Wednesday");
}else  if(String(totaynow) == "목"){
	$('#nowday').text("Thursday");
}else  if(String(totaynow) == "금"){
	$('#nowday').text("Friday");
}else  if(String(totaynow) == "토"){
	$('#nowday').text("Saturday");
};

//-------------------------------------------------------------------------------------------------------------
//map 추가3 start
var imgMap = new Image();
var imgCar = new Image();
    
var carLocX;
var carLocY;      

/* 지도와 자동차 위치 그리기 */
var canvasMap = document.querySelector(".map");
var canvasCar = document.querySelector(".car");
   
canvasMap.width = 330;
canvasMap.height = 330;
canvasMap.style.position = "absolute";
canvasCar.width = 330;
canvasCar.height = 330;
canvasCar.style.position = "absolute";  
   
var carLocation = {
         A: [270, 20],
         B: [205, 20],
         C: [140, 20],
         D: [75, 20],
         E: [50, 50],
         F: [50, 90],
         H: [35, 170],
         I: [30, 250],
         J: [60, 280],
         K: [105, 305],
         M: [180, 310],
         N: [270, 310],
         P: [310, 250],
         S: [310, 160],
         T: [310, 70]
      };

var ctxMap = canvasMap.getContext("2d");
var ctxCar = canvasCar.getContext("2d");

var mapArea = new mapArea(ctxMap, ctxCar, 0, 0);
mapArea.readyDrawCar("#FF3535", 7);

mapArea.drawTrack(); 

function mapArea(ctxMap, ctxCar, x, y) {
   this.ctxMap = ctxMap;   // 맵 그리기용 ctx
   this.ctxCar = ctxCar;   // 자동차 위치 그리기용 ctx
     this.x = x;
     this.y = y;
     
     this.mapWidth = 330;
     this.mapHeight = 330;   
     
     this.carLocX;   // 자동차위치 x좌표
     this.carLocY;   // 자동차위치 y좌표
     this.carColor;
     this.carRadius;
     
     // 맵을 그리는 메소드
     this.drawTrack = function() {
        var lineWidthList = ["30", "27", "3"];
        var strokeStyleList = ["#FF3535", "black", "#FF3535"];

        for(i=0; i<=2; i++) {
            this.ctxMap.beginPath();
            this.ctxMap.lineWidth = lineWidthList[i];
            this.ctxMap.strokeStyle = strokeStyleList[i];
            if(i==2) {
              this.ctxMap.setLineDash([20, 10]);
            }//x y
            this.ctxMap.moveTo(70, 20);	//상부 직선 도로1
            this.ctxMap.lineTo(280, 20);  //상부 직선도로2
            this.ctxMap.arcTo(310, 20, 310, 90, 20); //상부 우측 곡선 도로
           
            this.ctxMap.lineTo(310, 250); //우측 직선 도로1
            this.ctxMap.arcTo(310, 310, 250, 310, 20); //우측 하단 곡선 도로

            this.ctxMap.lineTo(120, 310);//하부 직선도로 1
            this.ctxMap.bezierCurveTo(90, 310, 110, 280, 80, 280);//S자
            this.ctxMap.arcTo(30, 280, 30, 250, 30);

            this.ctxMap.lineTo(30, 190);//좌측 직선1
            this.ctxMap.lineTo(50, 100);//좌측 직선2
            this.ctxMap.lineTo(50, 50);//좌측 직선3
            this.ctxMap.arcTo(50, 20, 100, 20, 20);//상부 좌측 곡선
             
            this.ctxMap.stroke();
        }
        this.ctxMap.setLineDash([]);
     }
        
    // 자동차 색깔과 크기 설정
    this.readyDrawCar = function(color, radius) {
       this.carColor = color;
       this.carRadius = radius;
    }

    // 자동차 위치 얻기
    this.setCarLocation = function(carLocX, carLocY) {
       this.carLocX = carLocX;
       this.carLocY = carLocY;
    }
   
    // 자동차 그리기
    this.drawCar = function() {
       this.ctxCar.clearRect(this.x, this.y, this.mapWidth, this.mapHeight);
       this.ctxCar.beginPath();
       this.ctxCar.fillStyle = this.carColor;
       this.ctxCar.arc(this.carLocX, this.carLocY, this.carRadius, 0, 2*Math.PI);
       this.ctxCar.fill();
       this.ctxCar.stroke();
    }
   
    this.getCarLocX = function() {
       return this.carLocX;
    }
   
    this.getCarLocY = function() {
       return this.carLocY;
    }        

}
   
var hud = document.querySelectorAll(".hud");

for(i=0; i<hud.length; i++) {
    hud[i].width = 104;
    hud[i].height = 104;
    hud[i].style.position = "absolute";
    hud[i].style.zIndex  = i+6000;
}

var canvas1 = hud[0];
var canvas2 = hud[1];

// HUD에 맵의 일부분을 그리기
function minimap () {
 ctx1map = canvas1.getContext("2d");
  ctx2map = canvas2.getContext("2d");
 
  ctx1map.clearRect(0, 0, canvas1.width, canvas1.height);
    ctx2map.clearRect(0, 0, canvas2.width, canvas2.height);
    
    ctx1map.drawImage(imgMap, carLocX-50, carLocY-50, 100, 100, 2, 2, 100, 100);
    ctx2map.drawImage(imgCar, carLocX-50, carLocY-50, 100, 100, 2, 2, 100, 100);
}

setInterval(minimap, 20)
//map 추가3 end
//-----------------------------------------------------------------------------------
//  function reload1(){
// 	location.reload();
// } 
// setInterval(reload1(),5000);
<!-- </script> -->
<!-- MQTT Jetson 조작 시 필요 js 소환 -->
<script src="${pageContext.request.contextPath}/resource/script/restaurant_car_control.js"></script>
</body>
</html>
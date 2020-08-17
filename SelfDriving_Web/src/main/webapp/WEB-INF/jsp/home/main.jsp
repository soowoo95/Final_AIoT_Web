﻿<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
  <head> 
	    <meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <title>AIOT FINAL PROJECT | TEAM 2</title>
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>

	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/bootstrap/css/bootstrap.min.css">
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/font-awesome/css/font-awesome.min.css">
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/css/font.css">
	    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Muli:300,400,700">
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/css/style.default.css" id="theme-stylesheet">
	    <link rel=icon href="${pageContext.request.contextPath}/resource/img/jetracer.png">

		<script src="${pageContext.request.contextPath}/resource/jquery/jquery-3.4.1.min.js" crossorigin="anonymous"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>

		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/popper.js/umd/popper.min.js"> </script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/bootstrap/js/bootstrap.min.js"></script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/jquery.cookie/jquery.cookie.js"> </script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/jquery-validation/jquery.validate.min.js"></script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/js/front.js"></script>
		
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/yunjis.css">
			
	</head>
	<script>
	var jetracer1connectedflag= false;
	var jetracer2connectedflag= false;
	var jetracer3connectedflag= false;
	$(function(){
		client = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime().toString());
		client.onMessageArrived = onMessageArrived;
		client.connect({onSuccess:onConnect});
	});
	
	function onConnect() {
		console.log("mqtt broker connected")
		client.subscribe("/1jetracer");
		client.subscribe("/2jetracer");
		client.subscribe("/3jetracer");
		client.subscribe("/mirror");
	}
function onMessageArrived(message) {
		if(message.destinationName =="/mirror") {
			const json = message.payloadString;
				const obj = JSON.parse(json);
			//$("#mirrorView").attr("src", "data:image/jpg;base64,"+ obj.Cam);
			if(obj.direction=="left"){
				alert("최상단 페이지입니다.")
			}else if (obj.direction=="right"){
				location.href="jetracer.do";
			}
			if(message.destinationName =="/1jetracer") {
				console.log("연결됬음.")
				jetracer1connectedflag= true;
				const json = message.payloadString;
				const obj = JSON.parse(json);
				
				carposition = car1;
				if(obj.label.includes("A")){
					carposition.x= 400;
		        	carposition.y= 50;
		        	carposition.angle= -Math.PI/2;
				}
				if(obj.label.includes("B")){
		        	carposition.x= 315;
		        	carposition.y= 50;
		        	carposition.angle= -Math.PI/2;
		        }
				if(obj.label.includes("C")){
		        	carposition.x= 230;
		        	carposition.y= 50;
		        	carposition.angle= -Math.PI/2;
		        }
				if(obj.label.includes("D")){
		        	carposition.x= 151;
		        	carposition.y= 50;
		        	carposition.angle= -Math.PI/2;
		        }
				if(obj.label.includes("E")){
		        	carposition.x= 100;
		        	carposition.y= 100;
		        	carposition.angle= -Math.PI;
		        }
				if(obj.label.includes("F")){
		        	carposition.x= 100;
		        	carposition.y= 149;
		        	carposition.angle= -Math.PI;
		        }
				if(obj.label.includes("H")){
		        	carposition.x= 50;
		        	carposition.y= 300;
		        	carposition.angle= -Math.PI;
		        }
				if(obj.label.includes("I")){
		        	carposition.x= 50;
		        	carposition.y= 349;
		        	carposition.angle= -Math.PI;
		        }
				if(obj.label.includes("J")){
		        	carposition.x= 100;
		        	carposition.y= 400;
		        	carposition.angle= Math.PI/2;
		        }
				if(obj.label.includes("K")){
		        	carposition.x= 150;
		        	carposition.y= 450;
		        	carposition.angle= Math.PI/2;
		        }
				if(obj.label.includes("M")){
		        	carposition.x= 275;
		        	carposition.y= 450;
		        	carposition.angle= Math.PI/2;
		        }
				if(obj.label.includes("N")){
		        	carposition.x= 400;
		        	carposition.y= 450;
		        	carposition.angle= Math.PI/2;
		        }
				if(obj.label.includes("P")){
		        	carposition.x= 450;
		        	carposition.y= 310;
		        	carposition.angle= 0;
		        }
				if(obj.label.includes("S")){
		        	carposition.x= 450;
		        	carposition.y= 205;
		        	carposition.angle= 0;
		        }
				if(obj.label.includes("T")){
					carposition.x= 450;
		        	carposition.y= 101;
		        	carposition.angle= 0;
		        }
			}
			if(message.destinationName =="/2jetracer") {
				console.log("연결됬음.")
				jetracer2connectedflag= true;
				const json = message.payloadString;
				const obj = JSON.parse(json);
				
				carposition = car2;
				if(obj.label.includes("A")){
					carposition.x= 400;
		        	carposition.y= 50;
		        	carposition.angle= -Math.PI/2;
				}
				if(obj.label.includes("B")){
		        	carposition.x= 315;
		        	carposition.y= 50;
		        	carposition.angle= -Math.PI/2;
		        }
				if(obj.label.includes("C")){
		        	carposition.x= 230;
		        	carposition.y= 50;
		        	carposition.angle= -Math.PI/2;
		        }
				if(obj.label.includes("D")){
		        	carposition.x= 151;
		        	carposition.y= 50;
		        	carposition.angle= -Math.PI/2;
		        }
				if(obj.label.includes("E")){
		        	carposition.x= 100;
		        	carposition.y= 100;
		        	carposition.angle= -Math.PI;
		        }
				if(obj.label.includes("F")){
		        	carposition.x= 100;
		        	carposition.y= 149;
		        	carposition.angle= -Math.PI;
		        }
				if(obj.label.includes("H")){
		        	carposition.x= 50;
		        	carposition.y= 300;
		        	carposition.angle= -Math.PI;
		        }
				if(obj.label.includes("I")){
		        	carposition.x= 50;
		        	carposition.y= 349;
		        	carposition.angle= -Math.PI;
		        }
				if(obj.label.includes("J")){
		        	carposition.x= 100;
		        	carposition.y= 400;
		        	carposition.angle= Math.PI/2;
		        }
				if(obj.label.includes("K")){
		        	carposition.x= 150;
		        	carposition.y= 450;
		        	carposition.angle= Math.PI/2;
		        }
				if(obj.label.includes("M")){
		        	carposition.x= 275;
		        	carposition.y= 450;
		        	carposition.angle= Math.PI/2;
		        }
				if(obj.label.includes("N")){
		        	carposition.x= 400;
		        	carposition.y= 450;
		        	carposition.angle= Math.PI/2;
		        }
				if(obj.label.includes("P")){
		        	carposition.x= 450;
		        	carposition.y= 310;
		        	carposition.angle= 0;
		        }
				if(obj.label.includes("S")){
		        	carposition.x= 450;
		        	carposition.y= 205;
		        	carposition.angle= 0;
		        }
				if(obj.label.includes("T")){
					carposition.x= 450;
		        	carposition.y= 101;
		        	carposition.angle= 0;
		        }
				
			}
			if(message.destinationName =="/3jetracer") {
				console.log("연결됬음.")
				jetracer3connectedflag= true;
				const json = message.payloadString;
				const obj = JSON.parse(json);
				
				carposition = car3;
				if(obj.label.includes("A")){
					carposition.x= 400;
		        	carposition.y= 50;
		        	carposition.angle= -Math.PI/2;
				}
				if(obj.label.includes("B")){
		        	carposition.x= 315;
		        	carposition.y= 50;
		        	carposition.angle= -Math.PI/2;
		        }
				if(obj.label.includes("C")){
		        	carposition.x= 230;
		        	carposition.y= 50;
		        	carposition.angle= -Math.PI/2;
		        }
				if(obj.label.includes("D")){
		        	carposition.x= 151;
		        	carposition.y= 50;
		        	carposition.angle= -Math.PI/2;
		        }
				if(obj.label.includes("E")){
		        	carposition.x= 100;
		        	carposition.y= 100;
		        	carposition.angle= -Math.PI;
		        }
				if(obj.label.includes("F")){
		        	carposition.x= 100;
		        	carposition.y= 149;
		        	carposition.angle= -Math.PI;
		        }
				if(obj.label.includes("H")){
		        	carposition.x= 50;
		        	carposition.y= 300;
		        	carposition.angle= -Math.PI;
		        }
				if(obj.label.includes("I")){
		        	carposition.x= 50;
		        	carposition.y= 349;
		        	carposition.angle= -Math.PI;
		        }
				if(obj.label.includes("J")){
		        	carposition.x= 100;
		        	carposition.y= 400;
		        	carposition.angle= Math.PI/2;
		        }
				if(obj.label.includes("K")){
		        	carposition.x= 150;
		        	carposition.y= 450;
		        	carposition.angle= Math.PI/2;
		        }
				if(obj.label.includes("M")){
		        	carposition.x= 275;
		        	carposition.y= 450;
		        	carposition.angle= Math.PI/2;
		        }
				if(obj.label.includes("N")){
		        	carposition.x= 400;
		        	carposition.y= 450;
		        	carposition.angle= Math.PI/2;
		        }
				if(obj.label.includes("P")){
		        	carposition.x= 450;
		        	carposition.y= 310;
		        	carposition.angle= 0;
		        }
				if(obj.label.includes("S")){
		        	carposition.x= 450;
		        	carposition.y= 205;
		        	carposition.angle= 0;
		        }
				if(obj.label.includes("T")){
					carposition.x= 450;
		        	carposition.y= 101;
		        	carposition.angle= 0;
		        }
			}
		}
}
	</script>
	<body onload="startGame()">
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
	    
		<div class="d-flex align-items-stretch" style="height: 855px;">
	      <nav id="sidebar" style="height: 1030px">
	        <div class="sidebar-header d-flex align-items-center">
	          <div class="avatar" style="width: 100px; height: 100px; align-itself: center; "><img src="${pageContext.request.contextPath}/resource/img/milk.jpg" class="img-fluid rounded-circle"></div>
	          <div class="title">
	            <h1 class="h5" style="color: lightgray">AIoT Project</h1>
	            <p style="color: lightgray">Team 2</p>
	          </div>
	        </div>
	        <!-- Sidebar Navidation Menus--><span class="heading" style="color:lightgray ;">MENU</span>
	        <ul class="list-unstyled">
	          <li class="active"><a href="${pageContext.request.contextPath}/home/main.do" style="color: lightgray"> <i class="icon-home"></i>MAIN DASHBOARD </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/jetracer.do" style="color: lightgray"> <i class="icon-writing-whiteboard"></i>JET-RACERS </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/history.do" style="color: lightgray"> <i class="icon-grid"></i>HISTORY </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/status.do" style="color: lightgray"> <i class="icon-padnote"></i>REAL-TIME STATUS </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/analysis.do" style="color: lightgray"> <i class="icon-chart"></i>ANALYSIS </a></li>
	      </nav>
	      
	       <div class="page-content" style="top: -50px; height: 1080px; padding-bottom: 0px; ">
			<div class="row">
			<div class="col-md-4">
	      <section class="no-padding-top">
	          <div class="container-fluid">
	        	<div class="container" style="position:relative; margin-right: 0px; margin-left:0px; width: 100%; height:auto; margin-top: 20px;border: 1px solid gold; margin-top: 100px">
	            <div class="row row-cols-2">	            
	                  <div class="col-12" style="border: 1px solid gold">
	                  	<img id="faceimg" src= "${pageContext.request.contextPath}/resource/img/face_good.png"style="width: 100%; height:auto;padding-left: 0px; padding-right: 0px;"/>
	                  	</div>
	                  	<div class="col-12" style="border: 1px solid gold">
	                  		<p id="notice" style="font-size: 2em;">안전합니다 여러분!</p>
	                  		<p id="daynotice" style="font-size: 2em;"></p>
	                  	</div>
	                  </div>
	             </div>
	             </div>
	       </section>
	       </div>
	       <div class="col-md-4">
	       <section class="no-padding-top">
	          <div class="container-fluid">
	        	<div class="container" style="position:relative; margin-right: 0px; margin-left:0px; width: 100%; height:auto; margin-top: 20px;border: 1px solid gold; margin-top: 100px">
	            <div class="row row-cols-5">
	            <div class="col-12" style="border: 1px solid gold">
	            <p>데이터베이스에 현재 시간을 기준으로 1시간 전에서부터 탐지한 동물들의 위험등급의 최고 값을 나타냅니다. </p>
	            </div>
	                  <div class="col-2" style="border: 1px solid red;background-color:rgba(255,0,0,0.5);text-align:center">
	                  	<br>
	                  	<p style="color:white;">A등급</p>
	                  </div>
	                  <div class="col-10" style="border: 1px solid red">
	                  	<p>인명피해를 발생시킬 수 있는 맹수</p>
	                  	<p>ex)멧돼지, 곰, 호랑이, 늑대</p>
	                  </div>
	                  <div class="col-2" style="border: 1px solid orange;background-color:rgba(255,128,0,0.5);text-align:center">
	                  <br>
	                  	<p style="color:white;">B등급</p>
	                  </div>
	                  <div class="col-10" style="border: 1px solid orange">
	                  	<p>가축피해를 발생시킬 수 있는 맹수</p>
	                  	<p>ex)살쾡이, 스라소니, 여우, 너구리</p>
	                  </div>
	                  <div class="col-2" style="border: 1px solid gold;background-color:rgba(255,255,0,0.5);text-align:center">
	                  <br>
	                  	<p style="color:white;">C등급</p>
	                  </div>
	                  <div class="col-10" style="border: 1px solid gold">
	                  	<p>농작물피해를 발생시킬 수 있는 동물</p> 
	                  	<p>ex)고라니, 노루, 꿩</p>
	                  </div>
	                  <div class="col-2" style="border: 1px solid green;background-color:rgba(0,255,0,0.5);">
	                  <br>
	                  	<p style="color:white;">D등급</p>
	                  </div>
	                  <div class="col-10" style="border: 1px solid green">
	                  	<p>아무런 해를 끼치지 않는 동물</p>
	                  	<p>ex)고양이</p>
	                  </div>
	            </div>
	            </div>
	       </div>
	       </section>
	       </div>
	       <div class="col-md-4" id="canvashere" >
        </div>
        </div>
        <section class="no-padding-top">
	          <div class="container-fluid">
	        	<div class="container">
	        	<button id="btn_A">버튼A</button>
	        	<button id="btn_B">버튼B</button>
	        	<button id="btn_C">버튼C</button>
	        	<button id="btn_D">버튼D</button>
	        	<button id="btn_E">버튼E</button>
	        	<button id="btn_F">버튼F</button>
	        	<button id="btn_H">버튼H</button>
	        	<button id="btn_I">버튼I</button>
	        	<button id="btn_J">버튼J</button>
	        	<button id="btn_K">버튼K</button>
	        	<button id="btn_M">버튼M</button>
	        	<button id="btn_N">버튼N</button>
	        	<button id="btn_P">버튼P</button>
	        	<button id="btn_S">버튼S</button>
	        	<button id="btn_T">버튼T</button>
	        	<p>저희 팀은 인공지능 딥러닝과 사물인터넷 기술을 활용해서 야생동물탐지 및 긴급 대응을 위한 웹페이지를 제작했습니다.</p>
	        	<p>팀장: 이정민  팀원: 장윤지, 김원준, 정성윤, 정택만, 진상우</p>
				<p>후원문의: 진상우 010-5095-4197 후원계좌: 국민 664602-02-177425 진상우</p>
				<p>익명후원 희망시 익명후원 가능하며 후원은 최소 만원부터 가능합니다.</p>
	        	</div>
	        	</div>
	    </section>
        
     	</div>
     	
        <script>
        $("#btn_A").click(function() {
        	car1.x= 400;
        	car1.y= 50;
        	car1.angle= -Math.PI/2;
        });
        $("#btn_B").click(function() {
        	car1.x= 315;
        	car1.y= 50;
        	car1.angle= -Math.PI/2;
        });
        $("#btn_C").click(function() {
        	car1.x= 230;
        	car1.y= 50;
        	car1.angle= -Math.PI/2;
        });
        $("#btn_D").click(function() {
        	car1.x= 151;
        	car1.y= 50;
        	car1.angle= -Math.PI/2;
        });
        $("#btn_E").click(function() {
        	car1.x= 100;
        	car1.y= 100;
        	car1.angle= -Math.PI;
        });
        $("#btn_F").click(function() {
        	car1.x= 100;
        	car1.y= 149;
        	car1.angle= -Math.PI;
        });
        $("#btn_H").click(function() {
        	car1.x= 50;
        	car1.y= 300;
        	car1.angle= -Math.PI;
        });
        $("#btn_I").click(function() {
        	car1.x= 50;
        	car1.y= 349;
        	car1.angle= -Math.PI;
        });
        $("#btn_J").click(function() {
        	car1.x= 100;
        	car1.y= 400;
        	car1.angle= Math.PI/2;
        });
        $("#btn_K").click(function() {
        	car1.x= 150;
        	car1.y= 450;
        	car1.angle= Math.PI/2;
        });
        $("#btn_M").click(function() {
        	car1.x= 275;
        	car1.y= 450;
        	car1.angle= Math.PI/2;
        });
        $("#btn_N").click(function() {
        	car1.x= 400;
        	car1.y= 450;
        	car1.angle= Math.PI/2;
        });
        $("#btn_P").click(function() {
        	car1.x= 450;
        	car1.y= 310;
        	car1.angle= 0;
        });
        $("#btn_S").click(function() {
        	car1.x= 450;
        	car1.y= 205;
        	car1.angle= 0;
        });
        $("#btn_T").click(function() {
        	car1.x= 450;
        	car1.y= 101;
        	car1.angle= 0;
        });
        var flagarr=[];
        function startGame() {
            car1 = new component(15, 20, "red", 50, 350, Math.PI); // component 생성
            car2 = new component(15, 20, "green", 300, 50, Math.PI / 2);
            car3 = new component(15, 20, "blue", 350, 50, Math.PI / 2);
            flagA = new component(15, 20, "A", 400, 50, Math.PI / 2);
            flagB = new component(15, 20, "B", 315, 50, Math.PI / 2);
            flagC = new component(15, 20, "C", 230, 50, Math.PI / 2);
            flagD = new component(15, 20, "D", 150, 50, Math.PI / 2);
            flagE = new component(15, 20, "E", 100, 100, Math.PI / 2);
            flagF = new component(15, 20, "F", 100, 150, Math.PI / 2);
            flagH = new component(15, 20, "H", 50, 300, Math.PI / 2);
            flagI = new component(15, 20, "I", 50, 350, Math.PI / 2);
            flagJ = new component(15, 20, "J", 100, 400, Math.PI / 2);
            flagK = new component(15, 20, "K", 150, 450, Math.PI / 2);
            flagM = new component(15, 20, "M", 275, 450, Math.PI / 2);
            flagN = new component(15, 20, "N", 400, 450, Math.PI / 2);
            flagP = new component(15, 20, "P", 450, 310, Math.PI / 2);
            flagS = new component(15, 20, "S", 450, 205, Math.PI / 2);
            flagT = new component(15, 20, "T", 450, 100, Math.PI / 2);
            flagarr=[flagA,flagB,flagC,flagD,flagE,flagF,flagH,flagI,flagJ,flagK,flagM,flagN,flagP,flagS,flagT]
            myGameArea.start(); 
        }

        function stop() { // 테스트 용
           clearInterval(myGameArea.interval);
        }

        //var scale = myGameArea.canvas.width / 500;

        var myGameArea = {
            canvas : document.createElement("canvas"), // 캔버스 태그 생성
            start : function() {
                this.canvas.width = 900/2; // 캔버스 크기 설정
                this.canvas.height = 900/2;
        		this.canvas.style.position = "absolute";
                this.canvas.style.left= "0";
                this.canvas.style.bottom= "0";
                this.scale = this.canvas.width / 500;
                this.context = this.canvas.getContext("2d"); // 캔버스에서 그리기 도구 객체 얻기
                this.context.scale(this.scale, this.scale);
                var canvashere=document.getElementById("canvashere")
                canvashere.insertBefore(this.canvas, canvashere.childNodes[0]); // 캔버스 태그를 body 태그 안에 넣기
                this.interval = setInterval(updateGameArea, 20); // 20ms마다 updateGameArea 함수를 실행
            },
            stop : function() {
                clearInterval(this.interval);
            },    
            clear : function() {
                this.context.clearRect(0, 0, this.canvas.width, this.canvas.height);
            }
        }

        function component(width, height, color, x, y, angle) {
            this.width = width;
            this.height = height;
            this.speed = 0;
            this.angle = angle; // 현대 각도
            this.moveAngle = 0; // 변화 각도
            this.x = x; // component 좌표
            this.y = y;
            this.color= color;
            this.update = function() {
                   ctx = myGameArea.context; // 그리기 객체 도구 얻기
                   
                   // component rotation에 필요
                   ctx.save();
                   ctx.translate(this.x, this.y);
                   ctx.rotate(this.angle);
                   
                   
                   //ctx.fillStyle = color; // 직사각형 색 설정
                   var image= document.createElement("img");
                   image.src="${pageContext.request.contextPath}/resource/img/myjetracer.png";
                   ctx.drawImage(image, -20, -20);
                   //ctx.fillRect(this.width / -2, this.height / -2, this.width, this.height); // 직사각형 그리기
                   
                   // component rotation을 위해 바꾼 설정을 복구
                   ctx.restore();
            }

            this.update2 = function() {
                ctx = myGameArea.context;
                ctx.save();
                ctx.translate(this.x, this.y);
                ctx.fillStyle = "rgba(255, 255, 0, 0.8)";
                ctx.fillRect(this.width / -2, this.height / -2, 5, 10);
     			ctx.fillStyle = "rgba(0, 128, 0, 1)";
     			ctx.fillRect(this.width / -2, this.height / -2-30, 40, 30);
     			ctx.font = "30px Arial";
     			ctx.fillStyle = "white";
     			ctx.fillText(this.color, this.width /-2+10, this.height / -2-5);
                 ctx.restore();
         }
           
            this.fixPosition2 = function() {
               if(this.x > 150 && this.x <= 400 && this.y == 50) {
                   this.moveLeft();}
               if(this.x <= 150 && this.y >= 50 && this.y <100) {
                     this.turnLeft2();}
               if(this.x == 100 && this.y >= 100 && this.y <150) {
                     this.moveDown();}
               if(this.y >= 150 && this.y <300 && this.angle >= Math.PI && this.angle <= Math.PI + 0.62 * Math.PI / 6) {
                     this.moveDown2();}
               if(this.x == 50 && this.y >= 300 && this.y < 350) {
                     this.moveDown();}
               if(this.x >= 50 && this.x < 100 && this.y >= 350 && this.angle >= Math.PI / 2 && this.angle <= Math.PI) {
                     this.turnLeft3();}
               if(this.x >= 100 && this.x < 125 && this.y >= 400 && this.y < 425 && this.angle >= Math.PI / 2 && this.angle <= Math.PI) {
                     this.turnRight6();}
               if(this.x >= 125 && this.x < 150 && this.y >= 425 && this.y < 450 && this.angle >= Math.PI / 2 && this.angle <= Math.PI) {
                   this.turnLeft4();}
               if(this.x >= 150 && this.x < 400 && this.y == 450) {
                   this.moveRight();}
               if(this.x >= 400 && this.angle > 0 && this.angle <= 3 * Math.PI / 2) {
                   this.turnLeft5();}
               
               if(this.x == 450 && this.y > 100 && this.y <= 400) {
                   this.moveUp1();}
               if(this.x > 400 && this.x <= 450 && this.y <= 100 && this.angle >= 2 * Math.PI / 2 && this.angle <= 5 * Math.PI / 2) { 
                   this.turnLeft6();}
            }
            
            this.moveRight = function() {
               this.speed = 1;
                this.angle = Math.PI / 2;
                this.x += this.speed * Math.sin(this.angle);
                this.y -= this.speed * Math.cos(this.angle);
            }
            
            this.turnRight1 = function() {
               this.speed = 1;
               this.moveAngle = 1.145;
                this.angle +=  this.moveAngle * Math.PI / 180;
                if (this.angle >= Math.PI) { this.x = 450; this.y = 100; return;}
                this.x += this.speed * Math.sin(this.angle);
                this.y -= this.speed * Math.cos(this.angle);
            }
            
            this.moveDown = function() {
               this.speed = 1;
                this.angle = Math.PI;
                this.x += this.speed * Math.sin(this.angle);
                this.y -= this.speed * Math.cos(this.angle);
            }
            
            this.turnRight2 = function() {
               this.speed = 1;
               this.moveAngle =  1.145;
                this.angle +=  this.moveAngle * Math.PI / 180;
                if (this.angle >= 3 * Math.PI / 2) { this.x = 400; this.y = 450; return;}
                this.x += this.speed * Math.sin(this.angle);
                this.y -= this.speed * Math.cos(this.angle);
            }
            
            this.moveLeft = function() {
               this.speed = 1;
                this.angle = 3 * Math.PI / 2;
                this.x += this.speed * Math.sin(this.angle);
                this.y -= this.speed * Math.cos(this.angle);
            }
            
            this.turnRight3 = function() {
               this.speed = 1;
               this.moveAngle = 2;
                this.angle +=  this.moveAngle * Math.PI / 180;
                if (this.angle >= 11 * Math.PI / 6) {this.x = 135; this.y = 435; return;} //this.x = 135; this.y = 435; return;
                this.x += this.speed * Math.sin(this.angle);
                this.y -= this.speed * Math.cos(this.angle);
            }
            
            this.turnLeft = function() {
               this.speed = 1;
               this.moveAngle = -0.7;
                this.angle +=  this.moveAngle * Math.PI / 180;
                if (this.x < 101) {this.x = 100; this.y = 400; this.angle = 3 * Math.PI / 2; return;} // this.x = 100; this.y = 400; return
                this.x += this.speed * Math.sin(this.angle);
                this.y -= this.speed * Math.cos(this.angle);
            }
            
            this.turnRight4 = function() {
               this.speed = 1;
               this.moveAngle = 1.145;
                this.angle +=  this.moveAngle * Math.PI / 180;
                if (this.angle >= 2 * Math.PI) {this.x = 50; this.y = 350; return;}
                this.x += this.speed * Math.sin(this.angle);
                this.y -= this.speed * Math.cos(this.angle);
            }
            
            this.moveUp1 = function() {
               this.speed = 1;
                this.angle =  2 * Math.PI;
                this.x += this.speed * Math.sin(this.angle);
                this.y -= this.speed * Math.cos(this.angle);
            }
            
            this.moveUp2 = function() {
               this.speed = 1;
                this.angle = 12.62 * Math.PI / 6;
                this.x += this.speed * Math.sin(this.angle);
                this.y -= this.speed * Math.cos(this.angle);
                if(this.y <= 150) {this.x = 100; this.y = 150; return;} //this.x = 100; this.y = 150; return
            }
            
            this.turnRight5 = function() {
               this.speed = 1;
               this.moveAngle = 1.145;
                this.angle +=  this.moveAngle * Math.PI / 180;
                if (this.angle >= 5 * Math.PI / 2) { this.x = 150; this.y = 50; return}
                this.x += this.speed * Math.sin(this.angle);
                this.y -= this.speed * Math.cos(this.angle);
            }
            
            this.turnLeft2 = function() {
                this.speed = 1;
                this.moveAngle = -1.145;
                 this.angle +=  this.moveAngle * Math.PI / 180;
                 if (this.angle <= Math.PI) { this.x = 100; this.y = 100; return}
                 this.x += this.speed * Math.sin(this.angle);
                 this.y -= this.speed * Math.cos(this.angle);
             }
            
            this.moveDown2 = function() {
                this.speed = 1;
                 this.angle = Math.PI + 0.62 * Math.PI / 6;
                 this.x += this.speed * Math.sin(this.angle);
                 this.y -= this.speed * Math.cos(this.angle);
                 if(this.y >= 300) {this.x = 50; this.y = 300; return;} //this.x = 100; this.y = 150; return
             }
            
            this.turnLeft3 = function() {
                this.speed = 1;
                this.moveAngle = -1.145;
                 this.angle +=  this.moveAngle * Math.PI / 180;
                 if (this.angle <= Math.PI / 2) {this.x = 100; this.y = 400; this.angle = Math.PI / 2; return;}
                 this.x += this.speed * Math.sin(this.angle);
                 this.y -= this.speed * Math.cos(this.angle);
             }
            
            this.turnRight6 = function() {
                this.speed = 1;
                this.moveAngle = 2.25;
                 this.angle +=  this.moveAngle * Math.PI / 180;
                 if (this.angle >= Math.PI) {this.x = 125; this.y = 425; this.angle = Math.PI; return;} // this.x = 100; this.y = 400; return
                 this.x += this.speed * Math.sin(this.angle);
                 this.y -= this.speed * Math.cos(this.angle);
             }
            
            this.turnLeft4 = function() {
               this.speed = 1;
               this.moveAngle = -2.25;
                this.angle +=  this.moveAngle * Math.PI / 180;
                if (this.angle <= Math.PI / 2) {this.x = 150; this.y = 450; this.angle = Math.PI / 2; return;} //this.x = 135; this.y = 435; return;
                this.x += this.speed * Math.sin(this.angle);
                this.y -= this.speed * Math.cos(this.angle);
            }
            
            this.turnLeft5 = function() {
                this.speed = 1;
                this.moveAngle = -1.145;
                 this.angle +=  this.moveAngle * Math.PI / 180;
                 if (this.angle <= 0) {this.x = 450; this.y = 400; this.angle = 0; return;}
                 this.x += this.speed * Math.sin(this.angle);
                 this.y -= this.speed * Math.cos(this.angle);
             }
            
            this.turnLeft6 = function() {
                this.speed = 1;
                this.moveAngle = -1.145;
                 this.angle +=  this.moveAngle * Math.PI / 180;
                 if (this.angle <= 3 * Math.PI / 2) {this.x = 400; this.y = 50; this.angle = 3 * Math.PI / 2; return;}
                 this.x += this.speed * Math.sin(this.angle);
                 this.y -= this.speed * Math.cos(this.angle);
             }
            this.crashWith = function(otherobj) {
        		var myx = this.x;
        		var myy = this.y;
        		var otherx = otherobj.x;
        		var othery = otherobj.y;
                var interx= Math.abs(myx-otherx);
                var intery= Math.abs(myy-othery);
                var interrad = 5;
        		var crash = true;
        		if (((interx*interx)+(intery*intery))>(interrad*interrad)) {
            		crash = false;
        		}
        		return crash;
			}
			            
            this.crashWitharr = function(otherobjarr) {
        		var myx = this.x;
        		var myy = this.y;
        		var crash = true;
        		function checkoth(otherobj) {
            		var otherx = otherobj.x;
            		var othery = otherobj.y;
                    var interx= Math.abs(myx-otherx);
                    var intery= Math.abs(myy-othery);
                    var interrad = 5;
            		return ((interx*interx)+(intery*intery))<(interrad*interrad);
                }
        		crash = otherobjarr.some(checkoth)
        		return crash;
			}
            
        }
        
        function updateGameArea() {
           myGameArea.clear(); // 캔버스 지우기
            drawMap(); //지도 그리기
            
            car1.moveAngle = 0; // 변화 각도 초기화
            car1.speed = 0; // 속도 초기화
            car2.moveAngle = 0;
            car2.speed = 0;
            car3.moveAngle = 0;
            car3.speed = 0;
            
            // component 위치 조정
            // 움직임 통제, 방향 통제 flag를 만족하면 위치 조정
            console.log(car1.crashWitharr(flagarr));
			/* if (car1.crashWitharr(flagarr)) {
			car1.fixPosition2();
            } else {
			car1.fixPosition2();
            } */
            car1.fixPosition2();
            car2.fixPosition2();
            car3.fixPosition2();
                
            car1.update(); // component 그리기
            car2.update();
            car3.update();
                
            flagA.update2();
            flagB.update2();
            flagC.update2();
            flagD.update2();
            flagE.update2();
            flagF.update2();
            flagH.update2();
            flagI.update2();
            flagJ.update2();
            flagK.update2();
            flagM.update2();
            flagN.update2();
            flagP.update2();
            flagS.update2();
            flagT.update2();
            //console.log(car1.x, car1.y, car1.angle * 180 / Math.PI);
        }

        function drawMap() {
             var ctx = myGameArea.context; // 캔버스에서 그리기 도구 객체 얻기
             
             // 도로 테두리 그리기
             ctx.beginPath(); // path 시작 함수, path를 초기화 또는 재설정
             ctx.lineWidth = ' 52' // path의 굴기 설정
             ctx.strokeStyle = "white"; // path의 색 설정
             ctx.moveTo(150, 50); // path의 시작점
             ctx.lineTo(400, 50); // 해당 좌표로 직선 이어주기
             ctx.arcTo(450, 50, 450, 100, 50); // 해당 좌표로 곡선 이어주기

             ctx.lineTo(450, 400);
             ctx.arcTo(450, 450, 400, 450, 50);

             ctx.lineTo(150, 450);
             ctx.bezierCurveTo(130, 450, 130, 400, 100, 400); // 해당 좌표로 bezier curve 이어주기
             ctx.arcTo(50, 400, 50, 350, 50);

             ctx.lineTo(50, 300);
             ctx.lineTo(100, 150);
             ctx.lineTo(100, 100);
             ctx.arcTo(100, 50, 150, 50, 50);

             ctx.stroke(); // 위에서 이어준 좌표 실제로 그리기
             
             // 도로 내부 그리기
             ctx.beginPath();
             ctx.lineWidth = "50";
             ctx.strokeStyle = "rgb(128,128,128)";
             ctx.moveTo(150, 50);
             ctx.lineTo(400, 50);
             ctx.arcTo(450, 50, 450, 100, 50);

             ctx.lineTo(450, 400);
             ctx.arcTo(450, 450, 400, 450, 50);

             ctx.lineTo(150, 450);
             ctx.bezierCurveTo(130, 450, 130, 400, 100, 400);
             ctx.arcTo(50, 400, 50, 350, 50);

             ctx.lineTo(50, 300);
             ctx.lineTo(100, 150);
             ctx.lineTo(100, 100);
             ctx.arcTo(100, 50, 150, 50, 50);

             ctx.stroke();

             // 도로 중앙선 그리기
             ctx.beginPath();
             ctx.lineWidth = "1";
             ctx.strokeStyle = "white";
             ctx.setLineDash([15, 20]) // path를 점선으로 설정, 길이 15, 간격 20
             ctx.moveTo(150, 50);
             ctx.lineTo(400, 50);
             ctx.arcTo(450, 50, 450, 100, 50);

             ctx.lineTo(450, 400);
             ctx.arcTo(450, 450, 400, 450, 50);

             ctx.lineTo(150, 450);
             ctx.bezierCurveTo(130, 450, 130, 400, 100, 400);
             ctx.arcTo(50, 400, 50, 350, 50);

             ctx.lineTo(50, 300);
             ctx.lineTo(100, 150);
             ctx.lineTo(100, 100);
             ctx.arcTo(100, 50, 150, 50, 50);

             ctx.stroke();
             ctx.setLineDash([]); // path를 실선으로 초기화, 이렇게 해야 다음에 또 그릴 때 위의 코드가 점선으로 시작 안함
        }
        count = 0;
        x = 0;
        $(document).ready(function() {
		    setInterval(move,100)
        });
        function move() {
        	$("#position"+x).css("visibility","hidden");
        	count++;
        	x= count%19+1;
			$("#position"+x).css("visibility","visible");
		}
        $.ajax({
				type: "POST",
				async: false,
				url: "${pageContext.request.contextPath}/home/mainDangerLevel.do",
				success: 
   			function(howdanger){
					//DB에서 지금부터 1시간 내에 가장 위험한 등급을 반환한다.
					var d =new Date()
					if (howdanger == "" || howdanger == "D"){
						$("#faceimg").attr("src","${pageContext.request.contextPath}/resource/img/face_good.png")
						$("#notice").css("color", "green");
						$("#notice").html("D등급: 안전");
						$("#daynotice").html(d.getFullYear()+"년"+(d.getMonth()+1)+"월"+d.getDate()+"일"+d.getHours()+"시");
					}
					else if (howdanger == "C"){
						$("#faceimg").attr("src","${pageContext.request.contextPath}/resource/img/face_good.png")
						$("#notice").css("color", "yellow");
						$("#notice").html("C등급: 주의");
						$("#daynotice").html(d.getFullYear()+"년"+(d.getMonth()+1)+"월"+d.getDate()+"일"+d.getHours()+"시");
					}
					else if (howdanger == "B"){
						$("#faceimg").attr("src","${pageContext.request.contextPath}/resource/img/face_soso.png")
						$("#notice").css("color", "orange");
						$("#notice").html("B등급: 위험");
						$("#daynotice").html(d.getFullYear()+"년"+(d.getMonth()+1)+"월"+d.getDate()+"일"+d.getHours()+"시");
					}
					else if (howdanger == "A"){
						$("#faceimg").attr("src","${pageContext.request.contextPath}/resource/img/face_bad.png")
						$("#notice").css("color", "red");
						$("#notice").html("A등급: 매우위험");
						$("#daynotice").html(d.getFullYear()+"년"+(d.getMonth()+1)+"월"+d.getDate()+"일"+d.getHours()+"시");
					}
				}
  		});
        </script>

</body>
</html>
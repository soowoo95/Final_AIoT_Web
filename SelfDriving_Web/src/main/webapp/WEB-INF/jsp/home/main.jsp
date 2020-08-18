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

	$(function(){
		client = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime().toString());
		client.onMessageArrived = onMessageArrived;
		client.connect({onSuccess:onConnect});
	});
	
	function onConnect() {
		console.log("mqtt broker connected")
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
			}
}
	</script>
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
	    
		<div class="d-flex align-items-stretch" style="height: 100%;">
	      <nav id="sidebar" style="height: 100%">
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
	          </ul>
	      </nav>
	     
	       <div class="page-content" style="top: 0px; height: 100%;                                                                             ">
			<div class="row">
			<div class="col-md-2 col-sm-12">
	          <div class="container">
	        	<div class="container" style="position:relative; margin-right: 0px; margin-left:0px; width: 100%; height:auto;border: 1px solid gold;">
	            <div class="row row-cols-2">	            
	                  <div class="col-12" style="border: 1px solid gold">
	                  	<img id="faceimg" src= "${pageContext.request.contextPath}/resource/img/face_good.png"style="width: 100%; height:auto;padding-left: 0px; padding-right: 0px;"/>
	                  	</div>
	                  	<div class="col-12" style="border: 1px solid gold">
	                  		<p id="notice" style="font-size: 1em;">데이터베이스에 연결하지 못했습니다.</p>
	                  		<p id="daynotice" style="font-size: 1em;"></p>
	                  	</div>
	                  </div>
	             </div>
	             </div>
	       </div>
	       <div class="col-md-4 col-sm-12">
	          <div class="container">
	        	<div class="container" style="position:relative; margin-right: 0px; margin-left:0px; width: 100%; height:auto;border: 1px solid gold;">
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
	       </div>
	       <div class="container-fluid col-md-4 col-sm-12" id="canvashere" >
        </div>
        </div>
        <div class="col-12">
	          <div class="container-fluid">
	        	<div class="container">
	        	
	        	<p>저희 팀은 인공지능 딥러닝과 사물인터넷 기술을 활용해서 야생동물탐지 및 긴급 대응을 위한 웹페이지를 제작했습니다.</p>
	        	<p>팀장: 이정민  팀원: 장윤지, 김원준, 정성윤, 정택만, 진상우</p>
				<p>후원문의: 진상우 010-5095-4197 후원계좌: 국민 664602-02-177425 진상우</p>
				<p>익명후원 희망시 익명후원 가능하며 후원은 최소 만원부터 가능합니다.</p>
	        	</div>
	        	</div>
        </div>
        </div>
     	</div>
     	
        <script>
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
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
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>

	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/bootstrap/css/bootstrap.min.css">
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/font-awesome/css/font-awesome.min.css">
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/css/font.css">
	    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Muli:300,400,700">
	    <link rel="stylesheet" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/css/style.default.css" id="theme-stylesheet">
	    <link rel=icon href="${pageContext.request.contextPath}/resource/img/jetracer.png">
		
		<script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/bootstrap/js/bootstrap.min.js"></script>

		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/popper.js/umd/popper.min.js"> </script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/bootstrap/js/bootstrap.min.js"></script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/jquery.cookie/jquery.cookie.js"> </script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/vendor/jquery-validation/jquery.validate.min.js"></script>
	    <script src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/js/front.js"></script>
	    
	    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/yunjis.css">

		<script>
		let ipid;
		var lastSendtimearr = [Date.now(), Date.now(), Date.now(),Date.now(),Date.now(),Date.now(),Date.now()];
		var subList=["1jetracer", "2jetracer","3jetracer","1cctv","2cctv","3cctv","4cctv"];
		
			$(function(){
				ipid = new Date().getTime().toString()
				client = new Paho.MQTT.Client("192.168.3.105", 61614, ipid);
				client.onMessageArrived = onMessageArrived;
				client.connect({onSuccess:onConnect});
			});
			
			function onConnect() {
				console.log("mqtt broker connected")
				
				client.subscribe("/req/1cctv");
				client.subscribe("/req/2cctv");
				client.subscribe("/req/3cctv");
				client.subscribe("/req/4cctv");
				
				client.subscribe("/req/1jetracer");
				client.subscribe("/req/2jetracer");
				client.subscribe("/req/3jetracer");
			}
			$(document).ready(function() {
				
			    setInterval(getinterval, 750);
			    setInterval(animalTable, 30000);
			});  
			 
			 var lastSendtime=Date.now();
			 
			 function getinterval(){
				nowtime= Date.now();
				lastSendtimearr.forEach(function(element, index, array){
					interval=nowtime-element
					if(interval>750){
						console.log("연결이 끊긴다음"+subList[index]+ "몇초가 흘렀는지를 보여주는 console.log의 시간:"+interval);
						response(index);
					}
				});
			}
			function animalTable(){
				var currentLocation = window.location;
				$("#animalTable").load(currentLocation + ' #animalTable');
			}
			
			function response(index){
				console.log(subList[index]+"에게 답장을 보내요.");
				message = new Paho.MQTT.Message(ipid);
				message.destinationName = "/res/"+subList[index];
				client.send(message);
			}

			function onMessageArrived(message) {
				if(message.destinationName =="/req/1jetracer") {
 					//const json = message.payloadString;
					//const obj = JSON.parse(json);
					//obj["witness"]= message.destinationName;
					
					$("#jrView1").attr("src", "data:image/jpg;base64,"+ message.payloadString);
/* 					
					if (obj.Class.length != 0){
						$("#j1Obj").attr("value", obj.Class);
						document.getElementById('j1Obj').style.color = '#DB6574';
						document.getElementById('j1Obj').style.fontWeight = 'bold';
						$("#j1Lev").attr("value", "등급이 몰까");
						document.getElementById('j1Lev').style.color = '#DB6574';
						document.getElementById('j1Lev').style.fontWeight = 'bold';
						$("#j1Loc").attr("value", "Jet 1 촬영 구간");
						document.getElementById('j1Loc').style.color = '#DB6574';
						document.getElementById('j1Loc').style.fontWeight = 'bold';
				
						if (obj["witness"].replace("/","") == "1jetracer"){
							document.getElementById('jrView1').style.border = '8px solid red';
						}
					}

					if (obj.Class.length == 0){
						
						$("#j1Obj").attr("value","*****  탐지대상 없음  *****");
						document.getElementById('j1Obj').style.color = 'white';
						$("#j1Lev").attr("value","*****  해당사항 없음  *****");
						document.getElementById('j1Lev').style.color = 'white';
						$("#j1Loc").attr("value","*****  해당사항 없음  *****");
						document.getElementById('j1Loc').style.color = 'white';
						document.getElementById('jrView1').style.border = 'inactiveborder';
					}
					 */
				}
				
				if(message.destinationName =="/req/2jetracer") {
 					//const json = message.payloadString;
					//const obj = JSON.parse(json);
					//obj["witness"]= message.destinationName;
					
					$("#jrView2").attr("src", "data:image/jpg;base64,"+ message.payloadString);
/* 					
					if (obj.Class.length != 0){
						$("#j2Obj").attr("value", obj.Class);
						document.getElementById('j2Obj').style.color = '#DB6574';
						document.getElementById('j2Obj').style.fontWeight = 'bold';
						$("#j2Lev").attr("value", "등급이 몰까");
						document.getElementById('j2Lev').style.color = '#DB6574';
						document.getElementById('j2Lev').style.fontWeight = 'bold';
						$("#j2Loc").attr("value", "Jet 1 촬영 구간");
						document.getElementById('j2Loc').style.color = '#DB6574';
						document.getElementById('j2Loc').style.fontWeight = 'bold';
				
						if (obj["witness"].replace("/","") == "1jetracer"){
							document.getElementById('jrView2').style.border = '8px solid red';
						}
					}

					if (obj.Class.length == 0){
						
						$("#j2Obj").attr("value","*****  탐지대상 없음  *****");
						document.getElementById('j2Obj').style.color = 'white';
						$("#j2Lev").attr("value","*****  해당사항 없음  *****");
						document.getElementById('j2Lev').style.color = 'white';
						$("#j2Loc").attr("value","*****  해당사항 없음  *****");
						document.getElementById('j2Loc').style.color = 'white';
						document.getElementById('jrView2').style.border = 'inactiveborder';
					}
					 */
				}
				
				if(message.destinationName =="/req/3jetracer") {
 					//const json = message.payloadString;
					//const obj = JSON.parse(json);
					//obj["witness"]= message.destinationName;
					
					$("#jrView3").attr("src", "data:image/jpg;base64,"+ message.payloadString);
/* 					
					if (obj.Class.length != 0){
						$("#j2Obj").attr("value", obj.Class);
						document.getElementById('j2Obj').style.color = '#DB6574';
						document.getElementById('j2Obj').style.fontWeight = 'bold';
						$("#j2Lev").attr("value", "등급이 몰까");
						document.getElementById('j2Lev').style.color = '#DB6574';
						document.getElementById('j2Lev').style.fontWeight = 'bold';
						$("#j2Loc").attr("value", "Jet 1 촬영 구간");
						document.getElementById('j2Loc').style.color = '#DB6574';
						document.getElementById('j2Loc').style.fontWeight = 'bold';
				
						if (obj["witness"].replace("/","") == "1jetracer"){
							document.getElementById('jrView2').style.border = '8px solid red';
						}
					}

					if (obj.Class.length == 0){
						
						$("#j2Obj").attr("value","*****  탐지대상 없음  *****");
						document.getElementById('j2Obj').style.color = 'white';
						$("#j2Lev").attr("value","*****  해당사항 없음  *****");
						document.getElementById('j2Lev').style.color = 'white';
						$("#j2Loc").attr("value","*****  해당사항 없음  *****");
						document.getElementById('j2Loc').style.color = 'white';
						document.getElementById('jrView2').style.border = 'inactiveborder';
					}
					 */
				}
				
 				if(message.destinationName =="/req/1cctv") {
 					response(3);
					lastSendtimearr[3] = Date.now();
 					
 					const json = message.payloadString;
					const obj = JSON.parse(json);
					obj["witness"]= message.destinationName;
					
					$("#cameraView1").attr("src", "data:image/jpg;base64,"+ obj.Cam);
					
					if (obj.Class.length != 0){
						
						$("#c1Obj").attr("value", obj.Class);
						document.getElementById('c1Obj').style.color = '#DB6574';
						document.getElementById('c1Col1').style.color = '#DB6574';
						document.getElementById('c1Obj').style.fontWeight = 'bold';
						$("#c1Lev").attr("value", "등급이 몰까");
						document.getElementById('c1Lev').style.color = '#DB6574';
						document.getElementById('c1Lev').style.fontWeight = 'bold';
						$("#c1Loc").attr("value", "1번 CCTV 촬영 구간");
						document.getElementById('c1Loc').style.color = '#DB6574';
						document.getElementById('c1Loc').style.fontWeight = 'bold';
				
						if (obj["witness"].replace("/","") == "req1cctv"){
							document.getElementById('cameraView1').style.border = '8px solid red';
						}
					}

					if (obj.Class.length == 0){
						
						$("#c1Obj").attr("value","*****  탐지대상 없음  *****");
						document.getElementById('c1Col1').style.color = 'white';
						document.getElementById('c1Obj').style.color = 'white';
						$("#c1Lev").attr("value","*****  해당사항 없음  *****");
						document.getElementById('c1Lev').style.color = 'white';
						$("#c1Loc").attr("value","*****  해당사항 없음  *****");
						document.getElementById('c1Loc').style.color = 'white';
						document.getElementById('cameraView1').style.border = 'inactiveborder';
					}
				}
 				
				if(message.destinationName =="/req/2cctv") {
					response(4);
					lastSendtimearr[4] = Date.now();
					
					const json = message.payloadString;
					const obj = JSON.parse(json);
					obj["witness"]= message.destinationName;

					$("#cameraView2").attr("src", "data:image/jpg;base64,"+ obj.Cam);
					
					if (obj.Class.length != 0){
						
						$("#c2Obj").attr("value", obj.Class);
						document.getElementById('c2Col1').style.color = '#DB6574';
						document.getElementById('c2Obj').style.color = '#DB6574';
						document.getElementById('c2Obj').style.fontWeight = 'bold';
						$("#c2Lev").attr("value", "등급이 몰까");
						document.getElementById('c2Lev').style.color = '#DB6574';
						document.getElementById('c2Lev').style.fontWeight = 'bold';
						$("#c2Loc").attr("value", "2번 CCTV 촬영 구간");
						document.getElementById('c2Loc').style.color = '#DB6574';
						document.getElementById('c2Loc').style.fontWeight = 'bold';
						document.getElementById('cameraView2').style.border = '8px solid red';
					}
					
					if (obj.Class.length == 0){
						document.getElementById('c2Col1').style.color = 'white';
						$("#c2Obj").attr("value","*****  탐지대상 없음  *****");
						document.getElementById('c2Obj').style.color = 'white';
						$("#c2Lev").attr("value","*****  해당사항 없음  *****");
						document.getElementById('c2Lev').style.color = 'white';
						$("#c2Loc").attr("value","*****  해당사항 없음  *****");
						document.getElementById('c2Loc').style.color = 'white';
						document.getElementById('cameraView2').style.border = 'inactiveborder';
					}
				}

				if(message.destinationName =="/req/3cctv") {
					response(5);
					lastSendtimearr[5] = Date.now();
					
					const json = message.payloadString;
					const obj = JSON.parse(json);
					obj["witness"]= message.destinationName;
					
					$("#cameraView3").attr("src", "data:image/jpg;base64,"+ obj.Cam);
					
					if (obj.Class.length != 0){
						$("#c3Obj").attr("value", obj.Class);
						document.getElementById('c3Col1').style.color = '#DB6574';
						document.getElementById('c3Obj').style.color = '#DB6574';
						document.getElementById('c3Obj').style.fontWeight = 'bold';
						$("#c3Lev").attr("value", "등급이 몰까");
						document.getElementById('c3Lev').style.color = '#DB6574';
						document.getElementById('c3Lev').style.fontWeight = 'bold';
						$("#c3Loc").attr("value", "3번 CCTV 촬영 구간");
						document.getElementById('c3Loc').style.color = '#DB6574';
						document.getElementById('c3Loc').style.fontWeight = 'bold';
						document.getElementById('cameraView3').style.border = '8px solid red';
					}

					if (obj.Class.length == 0){
						document.getElementById('c3Col1').style.color = 'white';
						$("#c3Obj").attr("value","*****  탐지대상 없음  *****");
						document.getElementById('c3Obj').style.color = 'white';
						$("#c3Lev").attr("value","*****  해당사항 없음  *****");
						document.getElementById('c3Lev').style.color = 'white';	
						$("#c3Loc").attr("value","*****  해당사항 없음  *****");
						document.getElementById('c3Loc').style.color = 'white';
						document.getElementById('cameraView3').style.border = 'inactiveborder';
					}
				}

				if(message.destinationName =="/req/4cctv") {
					response(6);
					lastSendtimearr[6] = Date.now();
					
					const json = message.payloadString;
					const obj = JSON.parse(json);
					obj["witness"]= message.destinationName;

					$("#cameraView4").attr("src", "data:image/jpg;base64,"+ obj.Cam);
					
					if (obj.Class.length != 0){
						$("#c4Obj").attr("value", obj.Class);
						document.getElementById('c4Col1').style.color = '#DB6574';
						document.getElementById('c4Obj').style.color = '#DB6574';
						document.getElementById('c4Obj').style.fontWeight = 'bold';
						$("#c4Lev").attr("value", "등급이 몰까");
						document.getElementById('c4Lev').style.color = '#DB6574';
						document.getElementById('c4Lev').style.fontWeight = 'bold';
						$("#c4Loc").attr("value", "4번 CCTV 촬영 구간");
						document.getElementById('c4Loc').style.color = '#DB6574';
						document.getElementById('c4Loc').style.fontWeight = 'bold';
						document.getElementById('cameraView4').style.border = '8px solid red';
					}
					
					if (obj.Class.length == 0){
						$("#c4Obj").attr("value","*****  탐지대상 없음  *****");
						document.getElementById('c4Col1').style.color = 'white';
						document.getElementById('c4Obj').style.color = 'white';
						document.getElementById('c4Obj').style.fontWeight = 'normal';
						document.getElementById('c4Obj').style.opacity = '0.9';
						$("#c4Lev").attr("value","*****  해당사항 없음  *****");
						document.getElementById('c4Lev').style.color = 'white';
						document.getElementById('c4Lev').style.fontWeight = 'normal';
						$("#c4Loc").attr("value","*****  해당사항 없음  *****");
						document.getElementById('c4Loc').style.color = 'white';
						document.getElementById('c4Loc').style.fontWeight = 'normal';
						document.getElementById('cameraView4').style.border = 'inactiveborder'; 
					}
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
	        <div class="sidebar-header d-flex align-items-center">
	          <div class="avatar" style="width: 100px; height: 100px; align-itself: center; "><img src="${pageContext.request.contextPath}/resource/img/milk.jpg" class="img-fluid rounded-circle"></div>
	          <div class="title">
	            <h1 class="h5" style="color: lightgray">AIoT Project</h1>
	            <p style="color: lightgray">Team 2</p>
	          </div>
	        </div>
	        <span class="heading" style="color:lightgray ;">MENU</span>
	        <ul class="list-unstyled">
	          <li><a href="${pageContext.request.contextPath}/home/main.do" style="color: lightgray"> <i class="icon-home"></i>MAIN DASHBOARD </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/jetracer.do" style="color: lightgray"> <i class="icon-writing-whiteboard"></i>JET-RACERS </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/history.do" style="color: lightgray"> <i class="icon-grid"></i>HISTORY </a></li>
	          <li class="active"><a href="${pageContext.request.contextPath}/home/status.do" style="color: lightgray"> <i class="icon-padnote"></i>REAL-TIME STATUS </a></li>
	      	  <li><a href="${pageContext.request.contextPath}/home/analysis.do" style="color: lightgray"> <i class="icon-chart"></i>ANALYSIS </a></li>
	      	 </ul>
	      </nav>
	   
	      
	     <div class="page-content" style="top: -50px;height: 1080px; padding-bottom: 0px; ">
	     	<div style="margin-bottom: 10px; margin-top: 80px; color: dimgray; font-weight: bold; font-size: xx-large; height: 50px; margin-left: 600px">실시간 유해동물 탐지 현황</div>
		     
		     <section style="padding-right: 0px">
	          <div class="container-fluid">
	         	<div class="container" style="position:absolute; margin-right: 0px; margin-left: 0px; width: 520px; height: 468px; top: 140px">
	         	  <input value="JetRacer 탐지 현황" style="background-color: transparent; color: white; font-weight: 500; font-size:20px; margin-left: 200px ;border-color: transparent; font-weight: bold;"/>
				  <div class="row row-cols-2">
				    <div class="col" style="padding-left: 0px; padding-right: 0px; width: 260px; height: 220px"><img id=jrView1 style="width: 260px; height: 220px; padding-left: 0px; padding-right: 0px"/></div>
				    <div class="col" style="padding-left: 0px; padding-right: 0px; width: 260px; height: 220px"><img id=jrView2 style="width: 260px; height: 220px; padding-left: 0px; padding-right: 0px"/></div>
				    <div class="col" style="padding-left: 0px; padding-right: 0px; width: 260px; height: 220px"><img id=jrView3 style="width: 260px; height: 220px; padding-left: 0px; padding-right: 0px"/></div>
				    <div class="col" style="padding-left: 0px; padding-right: 0px; width: 260px; height: 220px"><img src="${pageContext.request.contextPath}/resource/img/jetracer.jpg" style="width: 260px; height: 220px; opacity: 0.5; margin-left: 0px; margin-right: 0px"/></div>
				  </div>
				</div>
	          </div>
	        </section>
	        
	        <section style="padding-right: 0px">
	          <div class="container-fluid">
	         	<div class="container" style="position:absolute; margin-right: 0px; margin-left: 520px; width: 520px; height: 468px; top: 140px">
	         	  <input value="CCTV 탐지 현황" style="background-color: transparent; color: white; font-weight: 500; font-size:20px; margin-left: 170px ;border-color: transparent; font-weight: bold;"/>
				  <div class="row row-cols-2">
				    <div class="col" style="padding-left: 0px; padding-right: 0px; width: 260px; height: 220px"><img id=cameraView1 style="width: 260px; height: 220px; padding-left: 0px; padding-right: 0px; border:inactiveborder; "/></div>
				    <div class="col" style="padding-left: 0px; padding-right: 0px; width: 260px; height: 220px"><img id=cameraView2 style="width: 260px; height: 220px; padding-left: 0px; padding-right: 0px; borderstyle: none; bordercolor: transparent; borderwidth: inherit"/></div>
				    <div class="col" style="padding-left: 0px; padding-right: 0px; width: 260px; height: 220px"><img id=cameraView3 style="width: 260px; height: 220px; padding-left: 0px; padding-right: 0px; borderstyle: none; bordercolor: transparent; borderwidth: inherit"/></div>
				    <div class="col" style="padding-left: 0px; padding-right: 0px; width: 260px; height: 220px"><img id=cameraView4 style="width: 260px; height: 220px; padding-left: 0px; padding-right: 0px; borderstyle: none; bordercolor: transparent; borderwidth: inherit"/></div>
				  </div>
				</div>
	          </div>
	        </section>
	        
	       <!--  <div style="background-color: dimgray; color: white ;position: absolute; top: 150px; left: 1000px; width: 440px; height: 440px">여기에 미니 맵</div> -->
	        
	        <section style="padding-right: 0px">
	          <div class="container-fluid">
	         	<div class="container" style="position:absolute; margin-right: 0px; margin-left: 1040px; width: 520px; height: 468px; top: 140px">
	         	  <input value="여기에 미니맵" style="background-color: transparent; color: white; font-weight: 500; font-size:20px; margin-left: 170px ;border-color: transparent; font-weight: bold;"/>
				  <div style="background-color: dimgray; width: 520px; height: 440px;"></div>
				</div>
	          </div>
	        </section>
	        
       		<div style="background-color: dimgray; height: 405px; width: 520px; margin-top:490px;  margin-left:1085px; padding:0px ;text-align: center; font-weight: bolder; font-size: 30px; position: absolute;">
       				
     			<div class="table-responsive" style="height: 350px">
     			  <div id="animalTable">
                   <table class="table table-striped table-sm" style="color: white; text-align: center">
                     <thead style="border-style:double ; border-left: hidden; border-right: hidden; border-top: hidden; border-color: white; font-size: xx-small;">
                       <tr>
                         <th>CCTV #</th>
                         <th>Animal Name</th>
                         <th>Animal Level</th>
                         <th>Area</th>
                         <th>Detected Time</th>
                       </tr>
                     </thead>
                     <tbody style="font-size: xx-small;">
                      <c:forEach var="animal" items="${animal}">
                      	<tr>
                      	  <td>${animal.dfinder}</td>
                          <td>${animal.dname}</td>
                          <td>${animal.dlevel}</td>
                          <td>${animal.dfinder}</td>
                          <td><fmt:formatDate value="${animal.dtime}" pattern="YYYY-MM-dd HH:mm:ss"/></td>
                        </tr>
                     </c:forEach>
                    </tbody>
                   </table>
                </div>
              </div> 
       		</div>
	       	
	       	<div style="border-color: transparent; margin-top: 500px; width: 1070px; padding-left: 5px">
		       <div class="container" style="background-color: #22252a;  margin-left: 25px; border-color: dimgray; border-style:solid; border-width:medium; width: 1043px ">         
				  <table class="table hover" style="margin-bottom: 0px; margin-left: 0px">
				    <thead style="font-size: medium;">
				      <tr>
				        <th style="color: white; text-align: center; font-weight: bold; color: #DB6574">Detector</th>
				        <th style="color: white; text-align: center; font-weight: bold; color: #DB6574">Detected Animal</th>
				        <th style="color: white; text-align: center; font-weight: bold; color: #DB6574">Level of Animal</th>
				        <th style="color: white; text-align: center; font-weight: bold; color: #DB6574">Detected Area</th>
				      </tr>
				    </thead>
				    <tbody style="color: white; font-size:small;">
				      <tr id="jet1">
				        <td id="j1Col1" style="text-align: center; ">JetRacer 1</td>
				        <td><input id="j1Obj" value="*****  탐지대상 없음  *****" class="detectContent" readonly="readonly"></td>
				        <td><input id="j1Lev" value="*****  해당사항 없음  *****" class="detectContent" readonly="readonly"></td>
				        <td><input id="j1Loc" value="*****  해당사항 없음  *****" class="detectContent" readonly="readonly"></td>
				      </tr> 
				      <tr id="jet2">
				        <td id="j2Col1" style="text-align: center; ">JetRacer 2</td>
				        <td><input id="j2Obj" value="*****  탐지대상 없음  *****" class="detectContent" readonly="readonly"></td>
				        <td><input id="j2Lev" value="*****  해당사항 없음  *****" class="detectContent" readonly="readonly"></td>
				        <td><input id="j2Loc" value="*****  해당사항 없음  *****" class="detectContent" readonly="readonly"></td>
				      </tr>
				      <tr id="jet3">
				        <td id="j3Col1" style="text-align: center; ">JetRacer 3</td>
				        <td><input id="j3Obj" value="*****  탐지대상 없음  *****" class="detectContent" readonly="readonly"></td>
				        <td><input id="j3Lev" value="*****  해당사항 없음  *****" class="detectContent" readonly="readonly"></td>
				        <td><input id="j3Loc" value="*****  해당사항 없음  *****" class="detectContent" readonly="readonly"></td>
				      </tr>
				      <tr id="cctv1">
				        <td id="c1Col1" style="text-align: center; ">CCTV 1</td>
				        <td><input id="c1Obj" value="*****  탐지대상 없음  *****" class="detectContent" readonly="readonly"></td>
				        <td><input id="c1Lev" value="*****  해당사항 없음  *****" class="detectContent" readonly="readonly"></td>
				        <td><input id="c1Loc" value="*****  해당사항 없음  *****" class="detectContent" readonly="readonly"></td>
				      </tr>
				      <tr id="cctv2">
				        <td id="c2Col1" style="text-align: center; ">CCTV 2</td>
				        <td><input id="c2Obj" value="*****  탐지대상 없음  *****" class="detectContent" readonly="readonly"></td>
				        <td><input id="c2Lev" value="*****  해당사항 없음  *****" class="detectContent" readonly="readonly"></td>
				        <td><input id="c2Loc" value="*****  해당사항 없음  *****" class="detectContent" readonly="readonly"></td>
				      </tr>
				      <tr id="cctv3">
				        <td id="c3Col1" style="text-align: center;">CCTV 3</td>
						<td><input id="c3Obj" value="*****  탐지대상 없음  *****" class="detectContent" readonly="readonly"></td>
				        <td><input id="c3Lev" value="*****  해당사항 없음  *****" class="detectContent" readonly="readonly"></td>
				        <td><input id="c3Loc" value="*****  해당사항 없음  *****" class="detectContent" readonly="readonly"></td>
				      </tr>
				      <tr id="cctv4">
				        <td id="c4Col1" style="text-align: center;">CCTV 4</td>
				        <td><input id="c4Obj" value="*****  탐지대상 없음  *****" class="detectContent" readonly="readonly"></td>
				        <td><input id="c4Lev" value="*****  해당사항 없음  *****" class="detectContent" readonly="readonly"></td>
				        <td><input id="c4Loc" value="*****  해당사항 없음  *****" class="detectContent" readonly="readonly"></td>
				      </tr>
				    </tbody>
				  </table>
				</div>
	   		</div>
	   		
	   		
	   		
     
	   		
   		</div>
   	</div>
    </body>
</html>
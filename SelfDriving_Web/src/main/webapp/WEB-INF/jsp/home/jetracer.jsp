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
		
		<!-- highchart 관련 -->
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script src="https://code.highcharts.com/highcharts-more.js"></script>
		<script src="https://code.highcharts.com/modules/exporting.js"></script>
		<script src="https://code.highcharts.com/modules/export-data.js"></script>
		<script src="https://code.highcharts.com/modules/accessibility.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/speedHighChart.js"></script>

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
			  width: 760px;
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
				console.log("mqtt broker connected");
				
				//line tracing 프레임 띄우기
 				if(message.destinationName =="/1jetracer") {
					$("#jetView1").attr("src", "data:image/jpg;base64,"+ message.payloadString);
				}
 				
 				if(message.destinationName =="/1jr") {
 					const json = message.payloadString;
 					const obj = JSON.parse(json);
 					
 					//배터리 상태 표시
					console.log("battery:",obj.battery, "%");
					bat1 = obj.battery;
					$("#jetRacerText1").text(bat1 + "%");
			      	document.getElementById('jet1Battery').style.width = bat1 + '%';
			      	
			      	if (bat1 >= 100){
			      		document.getElementById('batMode').style.backgroundColor = 'dimgray';
			      		document.getElementById('adtMode').style.backgroundColor = '#864DD9';
			      	}
			      	else if (20 < bat1 < 100){
			      		document.getElementById('batMode').style.backgroundColor = '#864DD9';
			      		document.getElementById('adtMode').style.backgroundColor = 'dimgray';
			      	}
			      	else if (bat1 < 20){
			      		document.getElementById('batMode').style.backgroundColor = '#8B0000';
			      		document.getElementById('adtMode').style.backgroundColor = 'dimgray';
			      		$("#batt").attr("value", "Charge NOW");
			      	}
			      

			      	//angle은 60과 120사이의 값이고 핸들은 320에서 40도 사이에서 회전
			      	//angle = parseInt(Math.random() * 60 + 60);
			      	
			      	//servo 가도 조절
			      	angle = obj.servo;
					console.log("servo:",angle);
					
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
					
			      	//dc speed 표시
					speed = obj.speed;
			      	console.log("speed:", speed);
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
		      	<section class="no-padding-top no-padding-bottom" style="margin-top: 30px">
		          <div class="container-fluid" style="height: 260px">
		            
		            <div class="row" style="height: 30px; width: 760px">
		              <div class="col-md-3 col-sm-6">
		              
		              	<div id=showView>
			              	<div id=batteryMode>
			              		<div id="batMode" style="background-color: dimgray">
			              			<input id="batt" value="Battery" style="border-color: transparent; background-color:transparent; text-align: center; color: white;">
			              		</div>
								<div id="adtMode" style="background-color: dimgray">
									<input value="Adapter" style="border-color: transparent; background-color:transparent; text-align: center; color: white;">
								</div>
			              	</div>
			              	<div style="background-color: transparent; width: 5px"></div>
		              		<div style="background-color: dimgray; width: 350px;  color: white">Line Tracing Situation</div>
		              	</div>
		              	
		                <div class="statistic-block block" style="width: 380px; margin-bottom: 10px; padding-bottom: 0px; height: 120px">
		                  <div class="progress-details d-flex align-items-end justify-content-between">
		                    <div class="title">
		                      <div class="icon"><i class="icon-writing-whiteboard"></i></div><strong style="color: white">Battery Status</strong>
		                    </div> 
		                    <div class="number dashtext-1" id="jetRacerText1">
		                    	99%
		                    </div>
		                  </div>
		                  <div class="progress progress-template">
		                    <div id="jet1Battery" role="progressbar" style="width: 99%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-1"></div>
		                  </div>
		                </div>

		                <div class="statistic-block block" style="width: 380px; height: 120px">
		                  <div class="progress-details d-flex align-items-end justify-content-between">
		                    <div class="title">
		                      <div class="icon"><i class="icon-writing-whiteboard"></i></div><strong style="color: white">현재 위치</strong>
		                    </div> 
		                    <div class="number dashtext-1" id="jetRacerText1">
		                    	5구간
		                    </div>
		                  </div>
		                  <div class="progress progress-template">
		                    <div id="jet1Battery" role="progressbar" style="width: 99%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-1"></div>
		                  </div>
		                </div>
		              </div>
		            </div>
		           	<img id=jetView1 style="width: 350px; height: 250px; padding-left: 0px; padding-right: 0px; margin-left: 385px; margin-top: 0px"/>
		          </div>
		        </section>
		        
	            <section>
		          <div class="container-fluid">
		         	<div class="container">
					  <div class="row row-cols-2">
					  	<img id=image_steering src="${pageContext.request.contextPath}/resource/img/steering.png" style="position: absolute ; margin-top: 60px; margin-left: 305px; width: 150px; height: 150px"/>
					  </div>
					</div>
		          </div>
		        </section>
		        <img src="${pageContext.request.contextPath}/resource/img/driverseat.jpg" style="width: 350px; height: 240px; margin-left: 415px; margin-top: 30px"/>
<!-- 				
		        <figure class="highcharts-figure">
				  <div id="chart-container" style="position: absolute; top: 375px; left: 50px"></div>
				</figure>
			 	 -->
			 	
			 	
			 	
			  </div>
			  
			  <!-- jet racer # 2 -->
			  <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
		      	<section class="no-padding-top no-padding-bottom" style="margin-top: 30px">
		          <div class="container-fluid">
		            <div class="row" style="height: 100px">
		              <div class="col-md-3 col-sm-6">
		                <div class="statistic-block block" style="width: 350px">
		                  <div class="progress-details d-flex align-items-end justify-content-between">
		                    <div class="title">
		                      <div class="icon"><i class="icon-writing-whiteboard"></i></div><strong style="color: white">Battery Status</strong>
		                    </div>
		                    <div class="number dashtext-3" id="jetRacerText2">
		                    	99%
		                    </div>
		                  </div>
		                  <div class="progress progress-template">
		                    <div id="jet2Battery" role="progressbar" style="width: 99%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-3"></div>
		                  </div>
		                </div>
		              </div>
		              
		              <div class="col-md-3 col-sm-6">
		                <div class="statistic-block block" style="width: 350px">
		                  <div class="progress-details d-flex align-items-end justify-content-between">
		                    <div class="title">
		                      <div class="icon"><i class="icon-writing-whiteboard"></i></div><strong style="color: white">현재 위치</strong>
		                    </div> 
		                    <div class="number dashtext-3" id="jetRacerText2">
		                    	B구간
		                    </div>
		                  </div>
		                  <div class="progress progress-template">
		                    <div id="jet2Battery" role="progressbar" style="width: 99%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-3"></div>
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
		        </section>
		        
		       <section>
		          <div class="container-fluid">
		         	<div class="container" style="margin-right: 0px; margin-left: 0px; width: 350px; margin-top:20px">
					  <div class="row row-cols-2">
					    <div class="col" style="padding-left: 0px; padding-right: 0px; width: 350px; height: 380px">
					    	<img id=jetView2 style="width: 400px; height: 250px; padding-left: 0px; padding-right: 0px"/>
					    </div>
					  	<img id=image_steering src="${pageContext.request.contextPath}/resource/img/steering.png" style="position: absolute ; margin-top: 405px; margin-left: 90px; width: 150px; height: 150px"/>
					  </div>
					</div>
		          </div>
		        </section>
		       <img src="${pageContext.request.contextPath}/resource/img/driverseat.jpg" style="width: 400px; height: 210px; margin-left: 30px"/>
		       
			  </div>
			  
			  <!-- jet racer # 3 -->
			  <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
		        <section class="no-padding-top no-padding-bottom" style="margin-top: 30px">
		          <div class="container-fluid">
		            <div class="row" style="height: 100px">
		              <div class="col-md-3 col-sm-6">
		                <div class="statistic-block block" style="width: 350px">
		                  <div class="progress-details d-flex align-items-end justify-content-between">
		                    <div class="title">
		                      <div class="icon"><i class="icon-writing-whiteboard"></i></div><strong style="color: white">Battery Status</strong>
		                    </div> 
		                    <div class="number dashtext-2" id="jetRacerText3">
		                    	99%
		                    </div>
		                  </div>
		                  <div class="progress progress-template">
		                    <div id="jet3Battery" role="progressbar" style="width: 99%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-2"></div>
		                  </div>
		                </div>
		              </div>
		              
		              <div class="col-md-3 col-sm-6">
		                <div class="statistic-block block" style="width: 350px">
		                  <div class="progress-details d-flex align-items-end justify-content-between">
		                    <div class="title">
		                      <div class="icon"><i class="icon-writing-whiteboard"></i></div><strong style="color: white">현재 위치</strong>
		                    </div>
		                    <div class="number dashtext-2" id="jetRacerText3">
		                    	C구간
		                    </div>
		                  </div>
		                  <div class="progress progress-template">
		                    <div id="jet3Battery" role="progressbar" style="width: 99%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-2"></div>
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
		        </section>
		        
		    	<section>
		          <div class="container-fluid">
		         	<div class="container" style="margin-right: 0px; margin-left: 0px; width: 350px; margin-top:20px">
					  <div class="row row-cols-2">
					    <div class="col" style="padding-left: 0px; padding-right: 0px; width: 350px; height: 380px">
					    	<img id=jetView3 style="width: 350px; height: 380px; padding-left: 0px; padding-right: 0px"/>
					    </div>
					  	<img id=image_steering src="${pageContext.request.contextPath}/resource/img/steering.png" style="position: absolute ; margin-top: 405px; margin-left: 90px; width: 150px; height: 150px"/>
					  </div>
					</div>
		          </div>
		        </section>
		        
		       <img src="${pageContext.request.contextPath}/resource/img/driverseat.jpg" style="width: 353px; height: 210px; margin-left: 30px"/>
		       
			  </div>
			</div>
		  </div>
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
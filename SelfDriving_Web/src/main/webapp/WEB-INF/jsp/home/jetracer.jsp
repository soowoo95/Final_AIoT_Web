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
	    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
		
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

		<script src="${pageContext.request.contextPath}/resource/jquery/jquery-3.4.1.min.js" crossorigin="anonymous"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>

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
				if(message.destinationName =="/sensor") {
					console.log(message.destinationName)
					const json = message.payloadString;
					const obj = JSON.parse(json);
					console.log(obj.Battery);
					battery = obj.Battery;
					
					$("#battery1").attr("value", obj.Battery);
					$("#jetRacerText1").text(obj.Battery + "%");
			      	document.getElementById('jet1Battery').style.width = obj.Battery + '%';
			      	
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
	        <!-- Sidebar Navidation Menus--><span class="heading" style="color:lightgray ;">MENU</span>
	        <ul class="list-unstyled">
	          <li><a href="${pageContext.request.contextPath}/home/main.do" style="color: lightgray"> <i class="icon-home"></i>MAIN DASHBOARD </a></li>
	          <li class="active"><a href="${pageContext.request.contextPath}/home/jetracer.do" style="color: lightgray"> <i class="icon-writing-whiteboard"></i>JET-RACERS </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/history.do" style="color: lightgray"> <i class="icon-grid"></i>HISTORY </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/status.do" style="color: lightgray"> <i class="icon-padnote"></i>REAL-TIME STATUS </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/analysis.do" style="color: lightgray"> <i class="icon-chart"></i>ANALYSIS </a></li>
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
			  <!-- jet racer # 1 의 상태보기 -->
			  <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
			  	<div style="color: white; margin-bottom: 10px ;margin-left:20px; font-weight: bold; font-size: large; padding-top: 30px">
	  		      Random Battery Status : <input id="battery1" value="99" style="background-color: transparent; border-color: transparent; color: white"/>
	  			</div>
	  			
		      	<section class="no-padding-top no-padding-bottom">
		          <div class="container-fluid">
		            <div class="row">
		              <div class="col-md-3 col-sm-6">
		                <div class="statistic-block block" style="width: 350px">
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
		              </div>
		              
		              <div class="col-md-3 col-sm-6">
		                <div class="statistic-block block" style="width: 350px">
		                  <div class="progress-details d-flex align-items-end justify-content-between">
		                    <div class="title">
		                      <div class="icon"><i class="icon-writing-whiteboard"></i></div><strong style="color: white">현재 위치</strong>
		                    </div> 
		                    <div class="number dashtext-1" id="jetRacerText1">
		                    	A구간
		                    </div>
		                  </div>
		                  <div class="progress progress-template">
		                    <div id="jet1Battery" role="progressbar" style="width: 99%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-1"></div>
		                  </div>
		                </div>
		              </div>
		            </div>
		          </div>
		        </section>
		        
		        <div style="margin-left: 30px; color: white">Line Tracing Situation</div>
	        
	            <section style="padding-right: 0px">
		          <div class="container-fluid">
		         	<div class="container" style="position:absolute; margin-right: 0px; margin-left: 0px; width: 800px">
					  <div class="row row-cols-2">
					    <div class="col" style="padding-left: 0px; padding-right: 0px; width: 730px; height: 450px"><img id=jetbotView1 style="width: 730px; height: 450px; padding-left: 0px; padding-right: 0px"/></div>
					  </div>
					</div>
		          </div>
		        </section>
			  </div>
			  
			  <!-- jet racer # 2 의 상태보기 -->
			  <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
			  	<div style="color: white; margin-bottom: 10px ;margin-left:20px; font-weight: bold; font-size: large; padding-top: 30px">
	  		      Random Battery Status : <input id="battery2" value="99" style="background-color: transparent; border-color: transparent; color: white"/>
	  			</div>
	  			
		      	<section class="no-padding-top no-padding-bottom">
		          <div class="container-fluid">
		            <div class="row">
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
		        
		       <div style="margin-left: 30px; color: white">Line Tracing Situation</div>
	        
	            <section style="padding-right: 0px">
		          <div class="container-fluid">
		         	<div class="container" style="position:absolute; margin-right: 0px; margin-left: 0px; width: 800px">
					  <div class="row row-cols-2">
					    <div class="col" style="padding-left: 0px; padding-right: 0px; width: 730px; height: 450px"><img id=jetbotView2 style="width: 730px; height: 450px; padding-left: 0px; padding-right: 0px"/></div>
					  </div>
					</div>
		          </div>
		        </section>
			  </div>
			  
			  <!-- jet racer # 3 의 상태보기 -->
			  <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">
			  	<div style="color: white; margin-bottom: 10px ;margin-left:20px; font-weight: bold; font-size: large; padding-top: 30px">
	  		      Random Battery Status : <input id="battery3" value="99" style="background-color: transparent; border-color: transparent; color: white"/>
	  			</div>

		        <section class="no-padding-top no-padding-bottom">
		          <div class="container-fluid">
		            <div class="row">
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
		        
		    	<div style="margin-left: 30px; color: white">Line Tracing Situation</div>
	        
	            <section style="padding-right: 0px">
		          <div class="container-fluid">
		         	<div class="container" style="position:absolute; margin-right: 0px; margin-left: 0px; width: 800px">
					  <div class="row row-cols-2">
					    <div class="col" style="padding-left: 0px; padding-right: 0px; width: 730px; height: 450px"><img id=jetbotView3 style="width: 730px; height: 450px; padding-left: 0px; padding-right: 0px"/></div>
					  </div>
					</div>
		          </div>
		        </section>
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
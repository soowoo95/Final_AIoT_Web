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
		    
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/resource/jquery-ui/jQueryRotate.js"></script>
		
		<link href="${pageContext.request.contextPath}/resource/bootstrap/css/change.css" rel="stylesheet">
		
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		 
		 <style>
			#div1 {font-size:48px;}
		 </style>
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
	              <div class="brand-text brand-big visible text-uppercase"><strong class="text-primary">AIOT</strong><strong>Admin</strong></div>
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
	          <div class="avatar"><img src="${pageContext.request.contextPath}/resource/img/cotton.jpg"class="img-fluid rounded-circle"></div>
	          <div class="title">
	            <h1 class="h5">AIoT Final Project</h1>
	            <p>Team 2</p>
	          </div>
	        </div>
	        <!-- Sidebar Navidation Menus--><span class="heading">Main</span>
	        <ul class="list-unstyled">
	          <li><a href="${pageContext.request.contextPath}/home/main.do"> <i class="icon-home"></i>MAIN DASHBOARD </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/jetbot.do"> <i class="fa fa-bar-chart"></i>JETBOTS </a></li>
	          <li class="active"><a href="${pageContext.request.contextPath}/home/history.do"> <i class="icon-grid"></i>HISTORY </a></li>
	          <li><a href="${pageContext.request.contextPath}/home/status.do"> <i class="icon-padnote"></i>REAL-TIME STATUS </a></li>
			  <li><a href="login.html"> <i class="icon-logout"></i>Login page </a></li>
	      </nav>
	      
	      <div class="page-content">
	        <!-- Page Header-->
	        <div class="page-header no-margin-bottom">
	          <div class="container-fluid">
	            <h2 class="h5 no-margin-bottom">Tables</h2>
	          </div>
	        </div>
	        <!-- Breadcrumb-->
	        <div class="container-fluid">
	          <ul class="breadcrumb" style="background-color:transparent;">
	            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home/main.do" style="font-size: large; margin-top: 10px; color: cornflowerblue; font-weight: 600;">Home</a></li>
	            
	            <li class="breadcrumb-item active" style="font-size: large; margin-top: 10px">Tables        </li>
	          </ul>
	        </div>
	        
	        <section class="no-padding-top">
	          <div class="container-fluid">
	            <div class="row">
	            
	              <div class="col-lg-6">
	                <div class="block">
	                  <div class="title"><strong>Animal Detected | History</strong></div>
	                  <div class="table-responsive"> 
	                    <table class="table table-striped table-sm" style="color: white;">
	                      <thead>
	                        <tr>
	                          <th>#</th>
	                          <th>Object</th>
	                          <th>Num</th>
	                          <th>Detector</th>
	                          <th>Area</th>
	                          <th>Timestamp</th>
	                        </tr>
	                      </thead>
	                      <tbody>
	                      	<c:forEach var="animal" items="${animal}">
		                      	<tr style="align-self: center;">
		                          <td scope="row" style="width: 15px">${animal.dno}</td>
		                          <td><a href="${pageContext.request.contextPath}/home/imageView.do?dno=${animal.dno}" style="color: lightskyblue; font-weight: 500">${animal.dname}</td>
		                          <td>${animal.dnum}</td>
		                          <td>${animal.dfinder}</td>
		                          <td>${animal.dfinder}</td>
		                          <td>${animal.dtimeconv}</td>
		                        </tr>
	                      	</c:forEach>
	                      </tbody>
	                    </table>
	                  </div>
	                </div>
	              </div>
	              
	              <div class="col-lg-6">
	                <div class="block">
	                  <div class="title"><strong>Animal Detected | Image</strong></div>
	                  <div class="table-responsive"> 
	                    <div style="height: 385px">${animalView.dimagesname}</div>
	                  </div>
	                </div>
	              </div>

	              <div class="col-lg-6">
	                <div class="block">
	                  <div class="title"><strong>Driving Situation | History</strong></div>
	                  <div class="table-responsive"> 
	                    <table class="table table-striped table-sm" style="color: white;">
	                      <thead>
	                        <tr>
	                          <th>#</th>
	                          <th>Object</th>
	                          <th>Num</th>
	                          <th>Detector</th>
	                          <th>Area</th>
	                          <th>Timestamp</th>
	                        </tr>
	                      </thead>
	                      <tbody>
	                      	<c:forEach var="animal" items="${animal}">
		                      	<tr style="align-self: center;">
		                          <td scope="row" style="width: 15px">${animal.dno}</td>
		                          <td><a href="${pageContext.request.contextPath}/home/imageView.do?dno=${animal.dno}" style="color: lightskyblue; font-weight: 500">${animal.dname}</td>
		                          <td>${animal.dnum}</td>
		                          <td>${animal.dfinder}</td>
		                          <td>${animal.dfinder}</td>
		                          <td>${animal.dtime}</td>
		                        </tr>
	                      	</c:forEach>
	                      </tbody>
	                    </table>
	                  </div>
	                </div>
	              </div>
	              
	              <div class="col-lg-6">
	                <div class="block">
	                  <div class="title"><strong>Driving Situation | Image</strong></div>
	                  <div class="table-responsive"> 
	                    <div style="height: 385px"></div>
	                  </div>
	                </div>
	              </div>
	              
	             </div>
	            </div>
	        </section>
		
<!-- 
 		<div class="row row-cols-2" style="width: 640px; height:480px">
			<div class="col"  id="show1"><img id=cameraView1 style="width: 320px;height:240px"/></div>
			<div class="col"  id="show2"><img id=cameraView2 style="width: 320px;height:240px"/></div>
			<div class="col"  id="show3"><img id=cameraView3 style="width: 320px;height:240px"/></div>
			<div class="col"  id="show4"><img id=cameraView4 style="width: 320px;height:240px"/></div>
		</div>
 -->		
<!-- 		
		<div style="margin-left: 300px">
			<input id="Battery" value="">
		</div>
 -->
</body>
</html>
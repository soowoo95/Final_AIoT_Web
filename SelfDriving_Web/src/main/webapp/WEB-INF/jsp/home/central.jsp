<!DOCTYPE html>
<html>
  <head> 
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>AIOT FINAL PROJECT | TEAM 2</title>
<!--     <meta name="description" content=""> -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
<!--     <meta name="robots" content="all,follow"> -->
    
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
    <link rel="shortcut icon" href="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/img/favicon.ico">
    
     <!-- JavaScript files-->
     <script src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
 	 <script src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
 	 <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
<%--     <script src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script> --%>
<%--     <script src="${pageContext.request.contextPath}/resource/js/popper.min.js"> </script> --%>
<%--     <script src="${pageContext.request.contextPath}/resource/js/bootstrap.min.js"></script> --%>
<%--     <script src="${pageContext.request.contextPath}/resource/js/jquery.cookie.js"> </script>
    <script src="${pageContext.request.contextPath}/resource/js/Chart.min.js"></script>
    <script src="${pageContext.request.contextPath}/resource/js/jquery.validate.min.js"></script>
    <script src="${pageContext.request.contextPath}/resource/js/charts-home.js"></script>
    <script src="${pageContext.request.contextPath}/resource/js/front.js"></script> --%>
    
    <script>
		$(function(){
		client = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime().toString());
		client.onMessageArrived = onMessageArrived;
		client.connect({onSuccess:onConnect});
		});
	
		function onConnect() {
			//console.log("mqtt broker connected")
			client.subscribe("/1cctv");
			client.subscribe("/2cctv");
			client.subscribe("/3cctv");
			client.subscribe("/4cctv");
			client.subscribe("/sensor");
		}
		
		function onMessageArrived(message) {
			if(message.destinationName =="/1cctv") {
				$("#cameraView1").attr("src", "data:image/jpg;base64,"+ message.payloadString);
			}
			if(message.destinationName =="/2cctv") {
				$("#cameraView2").attr("src", "data:image/jpg;base64,"+ message.payloadString);
			}
			if(message.destinationName =="/3cctv") {
				$("#cameraView3").attr("src", "data:image/jpg;base64,"+ message.payloadString);
			}
			if(message.destinationName =="/4cctv") {
				const json = message.payloadString;
				const obj = JSON.parse(json);
	
				$("#cameraView4").attr("src", "data:image/jpg;base64,"+ obj.Cam);
				console.log(obj.Class)
				
				obj["witness"]= message.destinationName;
				console.log(obj);
				var jsonData = JSON.stringify(obj);
				//console.log(typeof(jsonData));
				
				if ( obj.Class.length != 0){
					$.ajax({
						type:"POST",
						url:"${pageContext.request.contextPath}/animal/saveImage.do",
						contentType: "application/json;charset=UTF-8",
						dataType: "json",
						data: jsonData
					});
				}
			}
			if(message.destinationName =="/sensor") {
				const json = message.payloadString;
				const obj = JSON.parse(json);
				$("#Battery").attr("value", obj.Battery);
			}
		}
    </script>
  
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
            <!-- Navbar Header--><a href="index.html" class="navbar-brand">
              <div class="brand-text brand-big visible text-uppercase"><strong class="text-primary">Master</strong><strong>Admin</strong></div>
              <div class="brand-text brand-sm"><strong class="text-primary">M</strong><strong>A</strong></div></a>
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
          <li class="active"><a href="${pageContext.request.contextPath}/home/main.do"> <i class="icon-home"></i>Home </a></li>
          <li><a href="${pageContext.request.contextPath}/home/history.do"> <i class="icon-grid"></i>Detect History </a></li>
          <li><a href="${pageContext.request.contextPath}/home/chart.do"> <i class="fa fa-bar-chart"></i>Charts </a></li>
          <li><a href="${pageContext.request.contextPath}/home/status.do"> <i class="icon-padnote"></i>Jetbot Status </a></li>
<!--           
          <li><a href="#exampledropdownDropdown" aria-expanded="false" data-toggle="collapse"> <i class="icon-windows"></i>Example dropdown </a>
            <ul id="exampledropdownDropdown" class="collapse list-unstyled ">
              <li><a href="#">Page</a></li>
              <li><a href="#">Page</a></li>
              <li><a href="#">Page</a></li>
            </ul>
          </li>
           -->
          <li><a href="login.html"> <i class="icon-logout"></i>Login page </a></li>
      </nav>
      <!-- Sidebar Navigation end-->
      
      <div class="page-content">
        <div class="page-header">
          <div class="container-fluid">
            <h2 class="h5 no-margin-bottom">Master Dashboard</h2>
          </div>
        </div>
        <section class="no-padding-top no-padding-bottom">
          <div class="container-fluid">
            <div class="row">
              <div class="col-md-3 col-sm-6">
                <div class="statistic-block block">
                  <div class="progress-details d-flex align-items-end justify-content-between">
                    <div class="title">
                      <div class="icon"><i class="icon-user-1"></i></div><strong>Total Detect #</strong>
                    </div>
                    <div class="number dashtext-1">85</div>
                  </div>
                  <div class="progress progress-template">
                    <div role="progressbar" style="width: 85%" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-1"></div>
                  </div>
                </div>
              </div>
              <div class="col-md-3 col-sm-6">
                <div class="statistic-block block">
                  <div class="progress-details d-flex align-items-end justify-content-between">
                    <div class="title">
                      <div class="icon"><i class="icon-writing-whiteboard"></i></div><strong>Detect Lev.1</strong>
                    </div>
                    <div class="number dashtext-2">35</div>
                  </div>
                  <div class="progress progress-template">
                    <div role="progressbar" style="width: 35%" aria-valuenow="35" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-2"></div>
                  </div>
                </div>
              </div>
              <div class="col-md-3 col-sm-6">
                <div class="statistic-block block">
                  <div class="progress-details d-flex align-items-end justify-content-between">
                    <div class="title">
                      <div class="icon"><i class="icon-writing-whiteboard"></i></div><strong>Detect Lev.2</strong>
                    </div>
                    <div class="number dashtext-3">10</div>
                  </div>
                  <div class="progress progress-template">
                    <div role="progressbar" style="width: 10%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-3"></div>
                  </div>
                </div>
              </div>
              <div class="col-md-3 col-sm-6">
                <div class="statistic-block block">
                  <div class="progress-details d-flex align-items-end justify-content-between">
                    <div class="title">
                      <div class="icon"><i class="icon-writing-whiteboard"></i></div><strong>Detect Lev.3</strong>
                    </div>
                    <div class="number dashtext-4">40</div>
                  </div>
                  <div class="progress progress-template">
                    <div role="progressbar" style="width: 40%" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template dashbg-4"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section class="no-padding-bottom">
          <div class="container-fluid">
            <div class="row">
              <div class="col-lg-4">
                <div class="bar-chart block no-margin-bottom">
                  <canvas id="barChartExample1"></canvas>
                </div>
                <div class="bar-chart block">
                  <canvas id="barChartExample2"></canvas>
                </div>
              </div>
              <div class="col-lg-8">
                <div class="line-cahrt block">
                  <canvas id="lineCahrt"></canvas>
                </div>
              </div>
            </div>
          </div>
        </section>
        <section class="no-padding-bottom">
          <div class="container-fluid">
            <div class="row">
              <div class="col-lg-6"> 
                <div class="stats-2-block block d-flex">
                  <div class="stats-2 d-flex">
                    <div class="stats-2-arrow low"><i class="fa fa-caret-down"></i></div>
                    <div class="stats-2-content"><strong class="d-block">5.657</strong><span class="d-block">Standard Scans</span>
                      <div class="progress progress-template progress-small">
                        <div role="progressbar" style="width: 60%;" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template progress-bar-small dashbg-2"></div>
                      </div>
                    </div>
                  </div>
                  <div class="stats-2 d-flex">
                    <div class="stats-2-arrow height"><i class="fa fa-caret-up"></i></div>
                    <div class="stats-2-content"><strong class="d-block">3.1459</strong><span class="d-block">Team Scans</span>
                      <div class="progress progress-template progress-small">
                        <div role="progressbar" style="width: 35%;" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template progress-bar-small dashbg-3"></div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="stats-3-block block d-flex">
                  <div class="stats-3"><strong class="d-block">745</strong><span class="d-block">Total requests</span>
                    <div class="progress progress-template progress-small">
                      <div role="progressbar" style="width: 35%;" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" class="progress-bar progress-bar-template progress-bar-small dashbg-1"></div>
                    </div>
                  </div>
                  <div class="stats-3 d-flex justify-content-between text-center">
                    <div class="item"><strong class="d-block strong-sm">4.124</strong><span class="d-block span-sm">Threats</span>
                      <div class="line"></div><small>+246</small>
                    </div>
                    <div class="item"><strong class="d-block strong-sm">2.147</strong><span class="d-block span-sm">Neutral</span>
                      <div class="line"></div><small>+416</small>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-lg-6">
                <div class="drills-chart block">
                  <canvas id="lineChart1"></canvas> 
                </div>
              </div>
            </div>
          </div>
        </section>
        <section class="no-padding-bottom">
          <div class="container-fluid">
            <div class="row">
              <div class="col-lg-4">
                <div class="user-block block text-center">
                  <div class="avatar"><img src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/img/avatar-1.jpg" alt="..." class="img-fluid">
                  </div><a href="#" class="user-title">
                    <h3 class="h5">Richard Nevoreski</h3><span>@richardnevo</span></a>
                  <div class="contributions">950 Contributions</div>
                  <div class="details d-flex">
                    <div class="item"><i class="icon-info"></i><strong>150</strong></div>
                    <div class="item"><i class="fa fa-gg"></i><strong>340</strong></div>
                    <div class="item"><i class="icon-flow-branch"></i><strong>460</strong></div>
                  </div>
                </div>
              </div>
              <div class="col-lg-4">
                <div class="user-block block text-center">
                  <div class="avatar"><img src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/img/avatar-4.jpg" alt="..." class="img-fluid">
                  </div><a href="#" class="user-title">
                    <h3 class="h5">Samuel Watson</h3><span>@samwatson</span></a>
                  <div class="contributions">772 Contributions</div>
                  <div class="details d-flex">
                    <div class="item"><i class="icon-info"></i><strong>80</strong></div>
                    <div class="item"><i class="fa fa-gg"></i><strong>420</strong></div>
                    <div class="item"><i class="icon-flow-branch"></i><strong>272</strong></div>
                  </div>
                </div>
              </div>
              <div class="col-lg-4">
                <div class="user-block block text-center">
                  <div class="avatar"><img src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/img/avatar-6.jpg" alt="..." class="img-fluid">
                  </div><a href="#" class="user-title">
                    <h3 class="h5">Sebastian Wood</h3><span>@sebastian</span></a>
                  <div class="contributions">620 Contributions</div>
                  <div class="details d-flex">
                    <div class="item"><i class="icon-info"></i><strong>150</strong></div>
                    <div class="item"><i class="fa fa-gg"></i><strong>280</strong></div>
                    <div class="item"><i class="icon-flow-branch"></i><strong>190</strong></div>
                  </div>
                </div>
              </div>
            </div>
            <div class="public-user-block block">
              <div class="row d-flex align-items-center">                   
                <div class="col-lg-4 d-flex align-items-center">
                  <div class="order">4th</div>
                  <div class="avatar"> <img src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/img/avatar-1.jpg" alt="..." class="img-fluid"></div><a href="#" class="name"><strong class="d-block">Tomas Hecktor</strong><span class="d-block">@tomhecktor</span></a>
                </div>
                <div class="col-lg-4 text-center">
                  <div class="contributions">410 Contributions</div>
                </div>
                <div class="col-lg-4">
                  <div class="details d-flex">
                    <div class="item"><i class="icon-info"></i><strong>110</strong></div>
                    <div class="item"><i class="fa fa-gg"></i><strong>200</strong></div>
                    <div class="item"><i class="icon-flow-branch"></i><strong>100</strong></div>
                  </div>
                </div>
              </div>
            </div>
            <div class="public-user-block block">
              <div class="row d-flex align-items-center">                   
                <div class="col-lg-4 d-flex align-items-center">
                  <div class="order">5th</div>
                  <div class="avatar"> <img src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/img/avatar-2.jpg" alt="..." class="img-fluid"></div><a href="#" class="name"><strong class="d-block">Alexander Shelby</strong><span class="d-block">@alexshelby</span></a>
                </div>
                <div class="col-lg-4 text-center">
                  <div class="contributions">320 Contributions</div>
                </div>
                <div class="col-lg-4">
                  <div class="details d-flex">
                    <div class="item"><i class="icon-info"></i><strong>150</strong></div>
                    <div class="item"><i class="fa fa-gg"></i><strong>120</strong></div>
                    <div class="item"><i class="icon-flow-branch"></i><strong>50</strong></div>
                  </div>
                </div>
              </div>
            </div>
            <div class="public-user-block block">
              <div class="row d-flex align-items-center">                   
                <div class="col-lg-4 d-flex align-items-center">
                  <div class="order">6th</div>
                  <div class="avatar"> <img src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/img/avatar-6.jpg" alt="..." class="img-fluid"></div><a href="#" class="name"><strong class="d-block">Arther Kooper</strong><span class="d-block">@artherkooper</span></a>
                </div>
                <div class="col-lg-4 text-center">
                  <div class="contributions">170 Contributions</div>
                </div>
                <div class="col-lg-4">
                  <div class="details d-flex">
                    <div class="item"><i class="icon-info"></i><strong>60</strong></div>
                    <div class="item"><i class="fa fa-gg"></i><strong>70</strong></div>
                    <div class="item"><i class="icon-flow-branch"></i><strong>40</strong></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
        <section class="margin-bottom-sm">
          <div class="container-fluid">
            <div class="row d-flex align-items-stretch">
              <div class="col-lg-4">
                <div class="stats-with-chart-1 block">
                  <div class="title"> <strong class="d-block">Sales Difference</strong><span class="d-block">Lorem ipsum dolor sit</span></div>
                  <div class="row d-flex align-items-end justify-content-between">
                    <div class="col-5">
                      <div class="text"><strong class="d-block dashtext-3">$740</strong><span class="d-block">May 2017</span><small class="d-block">320 Sales</small></div>
                    </div>
                    <div class="col-7">
                      <div class="bar-chart chart">
                        <canvas id="salesBarChart1"></canvas>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-lg-4">   
                <div class="stats-with-chart-1 block">
                  <div class="title"> <strong class="d-block">Visit Statistics</strong><span class="d-block">Lorem ipsum dolor sit</span></div>
                  <div class="row d-flex align-items-end justify-content-between">
                    <div class="col-4">
                      <div class="text"><strong class="d-block dashtext-1">$457</strong><span class="d-block">May 2017</span><small class="d-block">210 Sales</small></div>
                    </div>
                    <div class="col-8">
                      <div class="bar-chart chart">
                        <canvas id="visitPieChart"></canvas>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-lg-4">
                <div class="stats-with-chart-1 block">
                  <div class="title"> <strong class="d-block">Sales Activities</strong><span class="d-block">Lorem ipsum dolor sit</span></div>
                  <div class="row d-flex align-items-end justify-content-between">
                    <div class="col-5">
                      <div class="text"><strong class="d-block dashtext-2">80%</strong><span class="d-block">May 2017</span><small class="d-block">+35 Sales</small></div>
                    </div>
                    <div class="col-7">
                      <div class="bar-chart chart">
                        <canvas id="salesBarChart2"></canvas>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
        <section class="no-padding-bottom">
          <div class="container-fluid">
            <div class="row">
              <div class="col-lg-6">
                <div class="checklist-block block">
                  <div class="title"><strong>To Do List</strong></div>
                  <div class="checklist">
                    <div class="item d-flex align-items-center">
                      <input type="checkbox" id="input-1" name="input-1" class="checkbox-template">
                      <label for="input-1">Lorem ipsum dolor sit amet, consectetur adipisicing elit.</label>
                    </div>
                    <div class="item d-flex align-items-center">
                      <input type="checkbox" id="input-2" name="input-2" checked class="checkbox-template">
                      <label for="input-2">Lorem ipsum dolor sit amet, consectetur adipisicing elit.</label>
                    </div>
                    <div class="item d-flex align-items-center">
                      <input type="checkbox" id="input-3" name="input-3" class="checkbox-template">
                      <label for="input-3">Lorem ipsum dolor sit amet, consectetur adipisicing elit.</label>
                    </div>
                    <div class="item d-flex align-items-center">
                      <input type="checkbox" id="input-4" name="input-4" class="checkbox-template">
                      <label for="input-4">Lorem ipsum dolor sit amet, consectetur adipisicing elit.</label>
                    </div>
                    <div class="item d-flex align-items-center">
                      <input type="checkbox" id="input-5" name="input-5" class="checkbox-template">
                      <label for="input-5">Lorem ipsum dolor sit amet, consectetur adipisicing elit.</label>
                    </div>
                    <div class="item d-flex align-items-center">
                      <input type="checkbox" id="input-6" name="input-6" class="checkbox-template">
                      <label for="input-6">Lorem ipsum dolor sit amet, consectetur adipisicing elit.</label>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-lg-6">                                           
                <div class="messages-block block">
                  <div class="title"><strong>New Messages</strong></div>
                  <div class="messages"><a href="#" class="message d-flex align-items-center">
                      <div class="profile"><img src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/img/avatar-3.jpg" alt="..." class="img-fluid">
                        <div class="status online"></div>
                      </div>
                      <div class="content">   <strong class="d-block">Nadia Halsey</strong><span class="d-block">lorem ipsum dolor sit amit</span><small class="date d-block">9:30am</small></div></a><a href="#" class="message d-flex align-items-center">
                      <div class="profile"><img src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/img/avatar-2.jpg" alt="..." class="img-fluid">
                        <div class="status away"></div>
                      </div>
                      <div class="content">   <strong class="d-block">Peter Ramsy</strong><span class="d-block">lorem ipsum dolor sit amit</span><small class="date d-block">7:40am</small></div></a><a href="#" class="message d-flex align-items-center">
                      <div class="profile"><img src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/img/avatar-1.jpg" alt="..." class="img-fluid">
                        <div class="status busy"></div>
                      </div>
                      <div class="content">   <strong class="d-block">Sam Kaheil</strong><span class="d-block">lorem ipsum dolor sit amit</span><small class="date d-block">6:55am</small></div></a><a href="#" class="message d-flex align-items-center">
                      <div class="profile"><img src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/img/avatar-5.jpg" alt="..." class="img-fluid">
                        <div class="status offline"></div>
                      </div>
                      <div class="content">   <strong class="d-block">Sara Wood</strong><span class="d-block">lorem ipsum dolor sit amit</span><small class="date d-block">10:30pm</small></div></a><a href="#" class="message d-flex align-items-center">
                      <div class="profile"><img src="https://d19m59y37dris4.cloudfront.net/dark-admin/1-4-6/img/avatar-1.jpg" alt="..." class="img-fluid">
                        <div class="status online"></div>
                      </div>
                      <div class="content">   <strong class="d-block">Nader Magdy</strong><span class="d-block">lorem ipsum dolor sit amit</span><small class="date d-block">9:47pm</small></div></a></div>
                </div>
              </div>
            </div>
          </div>
        </section>
        <section>
          <div class="container-fluid">
            <div class="row">
              <div class="col-lg-4">
                <div class="stats-with-chart-2 block">
                  <div class="title"><strong class="d-block">Credit Sales</strong><span class="d-block">Lorem ipsum dolor sit</span></div>
                  <div class="piechart chart">
                    <canvas id="pieChartHome1"></canvas>
                    <div class="text"><strong class="d-block">$2.145</strong><span class="d-block">Sales</span></div>
                  </div>
                </div>
              </div>
              <div class="col-lg-4">
                <div class="stats-with-chart-2 block">
                  <div class="title"><strong class="d-block">Channel Sales</strong><span class="d-block">Lorem ipsum dolor sit</span></div>
                  <div class="piechart chart">
                    <canvas id="pieChartHome2"></canvas>
                    <div class="text"><strong class="d-block">$7.784</strong><span class="d-block">Sales</span></div>
                  </div>
                </div>
              </div>
              <div class="col-lg-4">
                <div class="stats-with-chart-2 block">
                  <div class="title"><strong class="d-block">Direct Sales</strong><span class="d-block">Lorem ipsum dolor sit</span></div>
                  <div class="piechart chart">
                    <canvas id="pieChartHome3"></canvas>
                    <div class="text"><strong class="d-block">$4.957</strong><span class="d-block">Sales</span></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
        <footer class="footer">
          <div class="footer__block block no-margin-bottom">
            <div class="container-fluid text-center">
              <!-- Please do not remove the backlink to us unless you support us at https://bootstrapious.com/donate. It is part of the license conditions. Thank you for understanding :)-->
              <p class="no-margin-bottom">2020 &copy; Your company. Design by <a href="https://bootstrapious.com/p/bootstrap-4-dark-admin">Bootstrapious</a>.</p>
            </div>
          </div>
        </footer>
      </div>
    </div>
  </body>
</html>
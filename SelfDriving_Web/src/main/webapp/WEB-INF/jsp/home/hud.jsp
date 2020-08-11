<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>No. 10</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
<script src="${pageContext.request.contextPath}/resource/jquery/jquery-3.4.1.min.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
<script
	src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
<script
	src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>

<script>
var ipid
$(function(){
	ipid =new Date().getTime().toString()
	client = new Paho.MQTT.Client("192.168.3.184", 61614, ipid);
	client.onMessageArrived = onMessageArrived;
	client.connect({onSuccess:onConnect});
});
function onConnect() {
	client.subscribe("/2cctv");
	console.log("연결됐다고 알림!");
}
$(document).ready(function() {
    setInterval(getinterval, 750);
});  
    var lastSendtime=Date.now();
 function getinterval(){
	interval= Date.now()-lastSendtime;
		if(interval>750){
			console.log("연결이 끊긴다음 몇초가 흘렀는지를 보여주는 console.log의 시간:"+interval);
			response();
		}
}
function response(){
	console.log("답장을 보내요.")
	  message = new Paho.MQTT.Message(ipid);
	  message.destinationName = "/network";
	  client.send(message);
}

function onMessageArrived(message) {

	if(message.destinationName =="/2cctv") {
		response();
		lastSendtime=Date.now();
		const json = message.payloadString;
		const obj = JSON.parse(json);
		obj["witness"]= message.destinationName;
		txtcanvas2=obj.Class;
		image.src="data:image/jpg;base64,"+ obj.Cam;
	}
}
var canvas1stfloor;
var ctx1stfloor;
var canvas2ndfloor;
var ctx2ndfloor;

$(function() {
	canvas1stfloor =document.createElement("canvas")
	canvas1stfloor.width = window.innerWidth;
	canvas1stfloor.height = window.innerHeight;
	ctx1stfloor = canvas1stfloor.getContext("2d");
	document.body.appendChild(canvas1stfloor);
});
var image = new Image();
image.onload = function() {
  	ctx1stfloor.drawImage(image, 0, 0,window.innerWidth,window.innerHeight);
};
image.src = "";

$(function() {
	canvas2ndfloor =document.createElement("canvas")
	canvas2ndfloor.width = window.innerWidth/4;
	canvas2ndfloor.height = window.innerHeight/4;
	canvas2ndfloor.style.position= "absolute";
	
	ctx2ndfloor = canvas2ndfloor.getContext("2d");
	ctx2ndfloor.font = "150px Arial";
	setInterval(setText, 20);
	document.body.insertBefore(canvas2ndfloor, document.body.childNodes[0]);
});
function setText(){
	ctx2ndfloor.clearRect(0,0,window.innerWidth/4, window.innerHeight/4);
	ctx2ndfloor.fillText(txtcanvas2, 30, 100);
}
var txtcanvas2;
/* 
$(function() {
	canvas3rdfloor =document.createElement("canvas")
	canvas3rdfloor.width = window.innerWidth/4;
	canvas3rdfloor.height = window.innerHeight/4;
	canvas3rdfloor.style.position= "absolute";
	
	ctx3rdfloor = canvas2ndfloor.getContext("2d");
	ctx3rdfloor.font = "30px Arial";
	ctx3rdfloor.fillText("Hello World", 100, 100);
	document.body.insertBefore(canvas3rdfloor, document.body.childNodes[0]);
}); */


</script>
</head>
<body>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>No. 10</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css">
<script
	src="${pageContext.request.contextPath}/resource/jquery/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resource/popper/popper.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.css">
<script
	src="${pageContext.request.contextPath}/resource/jquery-ui/jquery-ui.min.js"></script>
<style>
canvas {
	border: 1px solid #d3d3d3;
	background-color: #272b30;
}
</style>
<script>
	      var p;
      
        var car2;
        var car3;
        
		var destinationK;
        var destinationL;
        var destinationM;
        var destinationN;
        var destinationO;
        var destinationP;
        var destinationMiddle;
        var destination;
        var flagalphabet={};
         function startMap() { //map이 초기화될 때 차 객체 생성
             mapArea.start();             
             destinationK = new component(p*150,p*450,"white",0," K");
             destinationL = new component(p*200,p*450,"white",0," L");
             destinationM = new component(p*300,p*450,"white",0," M");
             destinationN = new component(p*400,p*450,"white",0," N");
             destinationO = new component(p*450,p*400,"white",0," O");
             destinationP = new component(p*450,p*300,"white",0," P");
             destinationMiddle = new component(p*250,p*250,"white",0," MIDDLE");
             destination=destinationMiddle;
             car2 = new component(p*100, p*150, "yellow", p*10,"RACER2");
         }
         
         var mapArea = {
             canvas : document.createElement("canvas"),
             start : function() {
                 this.canvas.width = window.innerWidth/2;
                 this.canvas.height = this.canvas.width;
                 p=this.canvas.width/500;
                 this.context = this.canvas.getContext("2d");
                 document.body.insertBefore(this.canvas, document.body.childNodes[0]);
                 this.interval = setInterval(updateMapArea, 20); //interval which will fu nthe updateMapArea() every 20th millisecond
             },
             clear : function() {

                 p=this.canvas.width/500;
                this.context.clearRect(0, 0, this.canvas.width, this.canvas.height);
             },
             stop : function() {
            	 clearInterval(this.interval);
            }
         }
         function setdestination(text){
         		console.log(text);
                switch(text){
                	case 'K':
         				car2.initflag=true;
         				flagalphabet={x:p*150+car2.radius,y:p*450};
                        break;
                    case 'L':
                    	car2.initflag=true;
                    	flagalphabet={x:p*200+car2.radius,y:p*450};
                        break;
                    case 'M':
                    	car2.initflag=true;
                    	flagalphabet={x:p*300+car2.radius,y:p*450};
                        break;
                    case 'N':
                    	car2.initflag=true;
                    	flagalphabet={x:p*400+car2.radius,y:p*450};
                        break;
                    case 'O':
                    	car2.initflag=true;
                    	flagalphabet={x:p*450,y:p*400-car2.radius};
                        break;
                    case 'P':
                    	car2.initflag=true;
                    	flagalphabet={x:p*450,y:p*300-car2.radius};
                        break;
                    default:
         				destination= destinationMiddle;
                        break;
                 }
         	
         }
         function component(x, y, color, radius,text) {
             this.radius = radius;
             this.x = x;
             this.y = y;
             this.text=text;
    		 this.speed = 1;
			 this.angle = 0;
			 this.initflag = false;
             this.update = function() {                
                ctx = mapArea.context;
                ctx.beginPath();
                ctx.fillStyle = color;
                if(this.radius!=0){
                	ctx.arc(this.x, this.y, this.radius, 0, 2 * Math.PI);
                }
                else{
                	ctx.fillStyle = "rgba(255, 255, 0, 0.8)";
                	ctx.fillRect(this.x, this.y, p*5, p*10);
        			ctx.fillStyle = "rgba(0, 128, 0, 1)";
                    ctx.fillRect(this.x, this.y-p*20, p*30, p*20);
                }
                ctx.fill();
                ctx.fillStyle = "white";
				ctx.font = p*20+"px Arial Bold";
                if(this.text!=undefined){
                	ctx.fillText(this.text,this.x-this.radius/2,this.y+this.radius/2);
                }
                else{
                	ctx.fillText("언디파인드",this.x-this.radius/2,this.y+this.radius/2);
                }
             }
             this.ysinminus = function() {
        		this.y = this.y - p*Math.sin(this.angle);
                this.angle+=0.01;
                console.log(this.angle);
   			 }
             this.ycosminus = function() {
        		this.y = this.y - p*Math.cos(this.angle);
                this.angle+=0.01;
                console.log(this.angle);
   			 }
             this.ycosplus = function() {
        		this.y = this.y + p*Math.cos(this.angle);
                this.angle+=0.01;
                console.log(this.angle);
   			 }
             this.ysinplus = function() {
        		this.y = this.y + p*Math.sin(this.angle);
                this.angle+=0.02;
                console.log(this.angle);
   			 }
             this.setposition = function(x,y){
            	 this.x= x;
            	 this.y =y;
            	 this.initflag = false;
             }
             /*
             this.turnright= function() {
            	 this.x += this.speed * Math.sin(this.angle);
                 this.y -= this.speed * Math.cos(this.angle);
                 this.angle+=Math.PI/180;
       		 }
             this.turnleft= function() {
            	 this.x += this.speed * Math.sin(this.angle);
                 this.y -= this.speed * Math.cos(this.angle);
                 this.angle-=Math.PI/180;
       		 }
             this.turnright= function() {
            	 this.x += this.speed * Math.sin(this.angle);
                 this.y -= this.speed * Math.cos(this.angle);
                 this.angle-=Math.PI/180;
       		 }
             this.moverightstraight = function() {
              	this.y += this.y + 1;
             }*/
             this.crashWith = function(otherobj) {
            	var myx = this.x;
            	var myy = this.y;
                var myrad = this.radius;
            	var otherx = otherobj.x;
            	var othery = otherobj.y;
                var otherrad = otherobj.radius;
                var interx= Math.abs(myx-otherx);
                var intery= Math.abs(myy-othery);
                var interrad = myrad+otherrad;
            	var crash = true;
            	if (((interx*interx)+(intery*intery))>(interrad*interrad)) {
                	crash = false;
            	}
            		return crash;
    			}
            
         }
         //
         
         function updateMapArea() {
         	mapArea.clear();
         	if(car2.initflag){
         		car2.setposition(flagalphabet.x,flagalphabet.y);	
         	}
         	
         	if(car2.crashWith(destinationK)||car2.crashWith(destinationL)||
         			car2.crashWith(destinationM)||car2.crashWith(destinationN)||
         			car2.crashWith(destinationO)||car2.crashWith(destinationP)) {
				car2.flag=true;
            }else{
            	if(car2.x>=p*130&&car2.x<=p*420&&car2.y<=p*70){
              		console.log("역조건1");
                    car2.angle= 0;
              		car2.x -= p*1.5;
                    car2.y+=p*(p*50-car2.y)/100
               }
                else if(car2.x>=p*90 &&car2.x<=p*160 && car2.y>p*30 && car2.y<=p*100){
                	console.log("역조건11");
                	car2.x -= p*0.6;
                    car2.ycosplus();
				}
                
                else if(car2.x>=p*50 && car2.x<=p*120 && car2.y>=p*100 && car2.y<p*150){
                	console.log("역조건10");
                    car2.x+=p*(p*100-car2.x)/50
                	car2.y += p*1.5;
				}
                else if(car2.x<=p*200 &&car2.x>=p*50 && car2.y<=p*300 && car2.y>=p*150){
                	console.log("역조건9");
                	car2.y += p*1.5;
                    car2.x -= p*0.5;
				}
                else if(car2.x<p*60 && car2.y>p*280&& car2.y<=p*380){
                	console.log("역조건8");
                    car2.angle= 0.1;
                    car2.x+=p*0.1;
                    car2.x+=p*(p*50-car2.x)/10;
                	car2.y += p*1.5;
				}
                else if(car2.x>=p*50 &&car2.x<p*130 && car2.y>p*340){
                	console.log("역조건7");
                    car2.ysinplus();
                	car2.x += p*1.1;
				}
                else if(car2.x>p*130 &&car2.x<p*150 && car2.y>p*380){
                	console.log("역조건6");
                    car2.ysinplus();
                	car2.x += p*1.1;
				}
               else if(car2.x>=p*150 &&car2.x<=p*410 && car2.y>p*410){
                	console.log("역조건5");
                    car2.angle= 0.8;
                	car2.x += p*1.5;
                    car2.y+=p*(p*450-car2.y)/100
				}
               else if(car2.x<=p*450 && car2.x>p*400 && car2.y>=p*410 && car2.y<p*460){
               		console.log("역조건4");
                	car2.x += p*0.9;
                    car2.ycosminus();
				}
              else if(car2.x>p*400&&car2.y>p*90&&car2.y<p*450){
              		console.log("역조건3");
                    car2.angle= 0.3;
              		car2.y -=p*1.5;
               }
              else if(car2.x>p*410 && car2.x<=p*460 && car2.y<p*130){
              		console.log("역조건2");
              		car2.x -= p*0.7;
                	car2.ycosminus();
                }
            }
                
                drawMap();
              
              destinationK.update();
              destinationL.update();
              destinationM.update();
              destinationN.update();
              destinationO.update();
              destinationP.update();
              car2.update();
            }
         
         function drawMap() {
              var ctx = mapArea.context;//차이점 
              ctx.canvas.width  = window.innerWidth/2;
              ctx.canvas.height = ctx.canvas.width;
              var scaleValueWidth = mapArea.canvas.width / ctx.canvas.width
              var DivtensVW = scaleValueWidth*mapArea.canvas.width /10
              var scaleValueHeight = mapArea.canvas.height / ctx.canvas.height
              var DivtensVH = scaleValueHeight*mapArea.canvas.width /10
              //ctx.scale(scaleValueWidth, scaleValueHeight); // 브라우저 크기에 따른 크기 조정
              
                 // 지도의 흰색 테두리, 이 위에 검은색 지도를 덮어 씌움
                 
                 ctx.beginPath();
                 ctx.lineWidth = DivtensVW+2;
                 ctx.strokeStyle = "white";
                 ctx.moveTo(DivtensVW*3, DivtensVH);
                 ctx.lineTo(DivtensVW*8, DivtensVH);
                 ctx.quadraticCurveTo(DivtensVW*9, DivtensVH, DivtensVW*9, DivtensVH*2);

                 ctx.lineTo(DivtensVW*9, DivtensVH*8);
                 ctx.quadraticCurveTo(DivtensVW*9, DivtensVH*9, DivtensVW*8, DivtensVH*9);

                 ctx.lineTo(DivtensVW*3, DivtensVH*9);
                 ctx.bezierCurveTo(DivtensVW*13/5, DivtensVH*9, DivtensVW*13/5, DivtensVH*8, DivtensVW*2, DivtensVH*8);
                 ctx.quadraticCurveTo(DivtensVW, DivtensVH*8, DivtensVW, DivtensVH*7);

                 ctx.lineTo(DivtensVW, DivtensVH*6);
                 ctx.lineTo(DivtensVW*2, DivtensVH*3);
                 ctx.lineTo(DivtensVW*2, DivtensVH*2);
                 ctx.quadraticCurveTo(DivtensVW*2, DivtensVH, DivtensVW*3, DivtensVH);
			
                 ctx.stroke();
              
      
                 // 검정색 지도
                 ctx.beginPath();
                 ctx.lineWidth = DivtensVW;
                 ctx.strokeStyle = "black";
                 ctx.moveTo(DivtensVW*3, DivtensVH);
                 ctx.lineTo(DivtensVW*8, DivtensVH);
                 ctx.quadraticCurveTo(DivtensVW*9, DivtensVH, DivtensVW*9, DivtensVH*2);

                 ctx.lineTo(DivtensVW*9, DivtensVH*8);
                 ctx.quadraticCurveTo(DivtensVW*9, DivtensVH*9, DivtensVW*8, DivtensVH*9);

                 ctx.lineTo(DivtensVW*3, DivtensVH*9);
                 ctx.bezierCurveTo(DivtensVW*13/5, DivtensVH*9, DivtensVW*13/5, DivtensVH*8, DivtensVW*2, DivtensVH*8);
                 ctx.quadraticCurveTo(DivtensVW, DivtensVH*8, DivtensVW, DivtensVH*7);

                 ctx.lineTo(DivtensVW, DivtensVH*6);
                 ctx.lineTo(DivtensVW*2, DivtensVH*3);
                 ctx.lineTo(DivtensVW*2, DivtensVH*2);
                 ctx.quadraticCurveTo(DivtensVW*2, DivtensVH, DivtensVW*3, DivtensVH);

                 ctx.stroke();
      
                 //지도의 중간에 점선
                 ctx.beginPath();
                 ctx.lineWidth = "3";
                 ctx.strokeStyle = "white";
                 ctx.setLineDash([10, 20]) //점선 길이, 간격(15,20)
                 ctx.moveTo(DivtensVW*3, DivtensVH);
                 ctx.lineTo(DivtensVW*8, DivtensVH);
                 ctx.quadraticCurveTo(DivtensVW*9, DivtensVH, DivtensVW*9, DivtensVH*2);

                 ctx.lineTo(DivtensVW*9, DivtensVH*8);
                 ctx.quadraticCurveTo(DivtensVW*9, DivtensVH*9, DivtensVW*8, DivtensVH*9);

                 ctx.lineTo(DivtensVW*3, DivtensVH*9);
                 ctx.bezierCurveTo(DivtensVW*13/5, DivtensVH*9, DivtensVW*13/5, DivtensVH*8, DivtensVW*2, DivtensVH*8);
                 ctx.quadraticCurveTo(DivtensVW, DivtensVH*8, DivtensVW, DivtensVH*7);

                 ctx.lineTo(DivtensVW, DivtensVH*6);
                 ctx.lineTo(DivtensVW*2, DivtensVH*3);
                 ctx.lineTo(DivtensVW*2, DivtensVH*2);
                 ctx.quadraticCurveTo(DivtensVW*2, DivtensVH, DivtensVW*3, DivtensVH);

                 ctx.stroke();
                 ctx.setLineDash([]); //점선을 다시 실선으로 만들어야 다음에 호출될 때 실선으로 시작함.
         }
      </script>
</head>
<body onload="startMap()">
	<button onclick="setdestination('K')">K</button>
	<button onclick="setdestination('L')">L</button>
	<button onclick="setdestination('M')">M</button>
	<button onclick="setdestination('N')">N</button>
	<button onclick="setdestination('O')">O</button>
	<button onclick="setdestination('P')">P</button>
	<button onclick="setdestination('Middle')">안해</button>
</body>
</html>
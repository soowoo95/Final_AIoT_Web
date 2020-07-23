	<div id="chartHolder" style="width:100px; height:100px;"></div>
	<script>
		var chartVars = "KoolOnLoadCallFunction=chartReadyHandler";
		
		KoolChart.create("battery1", "chartHolder", chartVars, "100px", "50px");
		KoolChart.create("battery2", "chartHolder", chartVars, "100px", "50px");
		KoolChart.create("battery3", "chartHolder", chartVars, "100px", "50px");
		
		function chartReadyHandler(id) {
		  document.getElementById(id).setLayout(layoutStr);
		  document.getElementById(id).setData(chartData);
		}
		
		var layoutStr =
		  '<KoolChart>'+'<CurrencyFormatter id="cft" currencySymbol="%" alignSymbol="right" precision="0"/>'
		   +'<LinearGauge direction="horizontal" verticalRatio="0.5" fontSize="15" valueChangeFunction="changeFunction1" formatter="{cft}" foregroundColor="#20cbc2" color="#ffffff" fontWeight="bold" width="250" height="80">'
			    +'<backgroundStroke>'+'<Stroke color="#20cbc2" weight="3"/>'+'</backgroundStroke>'
		   +'</LinearGauge>'
		  +'</KoolChart>'; 
		  
		 var chartData = [75]
		</script>
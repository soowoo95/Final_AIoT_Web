			
		<script>„
			var curr_stat = true;
 			function view(cctv_num){
				if (cctv_num == '1'){
					if (curr_stat){
						$("#show1").css({"display":"none"})
						curr_stat = false
						//console.log(curr_stat)
					}
					else if (!curr_stat){
						$("#show1").css({"display":"block"})
						curr_stat = true
					}
				}
				
				if (cctv_num == '2'){
					if (curr_stat){
						$("#show2").css({"display":"none"})
						curr_stat = false
						//console.log(curr_stat)
					}
					else if (!curr_stat){
						$("#show2").css({"display":"block"})
						curr_stat = true
					}
				}
				
				if (cctv_num == '3'){
					if (curr_stat){
						$("#show3").css({"display":"none"})
						curr_stat = false
						//console.log(curr_stat)
					}
					else if (!curr_stat){
						$("#show3").css({"display":"block"})
						curr_stat = true
					}
				}
				
				if (cctv_num == '4'){
					if (curr_stat){
						$("#show4").css({"display":"none"})
						curr_stat = false
						//console.log(curr_stat)
					}
					else if (!curr_stat){
						$("#show4").css({"display":"block"})
						curr_stat = true
					}
				}
			}
		</script>
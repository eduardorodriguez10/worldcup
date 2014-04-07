
function updateOptionsR16(selected, disabled, next_round){
		var e = document.getElementById("bracket_"+selected);
		var valueSelected = e.selectedIndex;
		var oldTeam = 0;
		var oldTeamIndex = 0;

		//get value of previously selected team
		for(var i=0;i<5;i++)
		{
			if(document.getElementById("bracket_"+disabled).options[i].disabled == true){
				oldTeamIndex = i;
				oldTeam = document.getElementById("bracket_"+disabled).options[i].value;
			}
		}	
		var teamSelected = e.options[valueSelected].value;		
		// set CSS to selected if value selected
		setCSSSelected("#bracket_"+selected, valueSelected);
		// show the new team and hide the old team in the next round
		if(valueSelected){
			document.getElementById("bracket_"+disabled).options[valueSelected].disabled = true;
			displayInNextRound("#bracket_"+next_round+" option[value="+teamSelected.toString()+"]", true);
		};
		if(oldTeam){
			document.getElementById("bracket_"+disabled).options[oldTeamIndex].disabled = false;
			displayInNextRound("#bracket_"+next_round+" option[value="+oldTeam.toString()+"]", false);
		}
	};
	function updateOptionsQF(selected, next_round){
		var e = document.getElementById("bracket_"+selected);
		var valueSelected = e.selectedIndex;
		// get value of previously selected team
		var oldTeam = document.getElementById(selected+"-old").value;
		// get value of new team selected
		var teamSelected = e.value;
		// set CSS to selected if value selected
		setCSSSelected("#bracket_"+selected, valueSelected);
		// show the new team and hide the old team in the next round
		if(valueSelected){
			displayInNextRound("#bracket_"+next_round+" option[value="+teamSelected.toString()+"]", true);
		};
		if(oldTeam){
			displayInNextRound("#bracket_"+next_round+" option[value="+oldTeam.toString()+"]", false);
		}
		document.getElementById(selected+"-old").value = e.value;
	};
	function updateOptionsSF(selected, next_round){
		var e = document.getElementById("bracket_"+selected);
		var valueSelected = e.selectedIndex;
		// get value of previously selected team
		var oldTeam = document.getElementById(selected+"-old").value;
		// get value of new team selected
		var teamSelected = e.value;
		// set CSS to selected if value selected
		setCSSSelected("#bracket_"+selected, valueSelected);

		// show the new team and hide the old team in the next round
		if(valueSelected>0){
			displayInNextRound("#bracket_w"+next_round+" option[value="+teamSelected.toString()+"]", true);
			displayInNextRound("#bracket_l"+next_round+" option[value="+teamSelected.toString()+"]", true);
		}
		if(oldTeam>0){
			displayInNextRound("#bracket_w"+next_round+" option[value="+oldTeam.toString()+"]", false);
			displayInNextRound("#bracket_l"+next_round+" option[value="+oldTeam.toString()+"]", false);
		}
		document.getElementById(selected+"-old").value = e.value;
	};
	function updateOptionsFinals(selected, disabled, next_round){
		var e = document.getElementById("bracket_"+selected);
		var valueSelected = e.selectedIndex;
		// get value of previously selected team
		var oldTeam = document.getElementById(selected+"-old").value;
		// get value of new team selected
		var teamSelected = e.value;
		console.log(teamSelected);
		console.log(selected[0]);

		// set CSS to selected if value selected
		setCSSSelected("#bracket_"+selected, valueSelected);
		// show the new team and hide the old team in the next round
		if(valueSelected){
			document.getElementById("bracket_"+disabled).options[teamSelected].disabled = true;
			if(selected[0]=='w'){
				displayInNextRound("#bracket_champion option[value="+teamSelected.toString()+"]", true);
			};
			if(selected[0]=='l'){
				displayInNextRound("#bracket_third option[value="+teamSelected.toString()+"]", true);
			};
		};

		if(oldTeam){
			document.getElementById("bracket_"+disabled).options[oldTeam].disabled = false;
			if(selected[0]=='w'){
				displayInNextRound("#bracket_champion option[value="+oldTeam.toString()+"]", false);
			};
			if(selected[0]=='l'){
				displayInNextRound("#bracket_third option[value="+oldTeam.toString()+"]", false);
			}
		}
		document.getElementById(selected+"-old").value = e.value;
	};
	function changeFinals(selected){
		var e = document.getElementById("bracket_"+selected);
		var valueSelected = e.selectedIndex;
		// get value of new team selected
		var teamSelected = e.value;

		// set the CSS to selected if value is selected
		setCSSSelected("#bracket_"+selected, valueSelected);
	};

	function hideTeamsW(w_number){
		var selIndex = document.getElementById("bracket_w"+w_number).selectedIndex;
		if (selIndex)
			selIndex++;
		for(var t = 1; t<33; t++){
				if(selIndex!=t){
				$("#bracket_w"+w_number.toString()+" option[value="+t.toString()+"]").hide();
				$("#bracket_w"+w_number.toString()+" option[value="+t.toString()+"]").wrap('<span style="display:none;" />');
				}
			};
	};

	//readjust R16 javascript in case of reload
	function fixR16Games() {
		var next_game = {'a1': 'w49', 'b2': 'w49', 'c1': 'w50', 'd2': 'w50', 'e1': 'w53', 'f2': 'w53', 'g1': 'w54', 'h2': 'w54', 'b1': 'w51', 'a2':'w51', 'd1':'w52', 'c2': 'w52', 'f1': 'e2', 'h1': 'w56', 'g2': 'w56', 'w49': 'w57', 'w50': 'w57', 'w53': 'w58', 'w54': 'w58', 'w57': 'w61', 'w58': 'w61', 'w51': 'w59', 'w52': 'w59', 'w55': 'w60', 'w56': 'w60', 'w59': 'w62', 'w60': 'w62'};
		for (var i = 97; i <105; i++){
			var e = document.getElementById("bracket_"+String.fromCharCode(i)+"1");
			var teamSelected = e.value;
			var e2 = document.getElementById("bracket_"+String.fromCharCode(i)+"2");
			var teamSelected2 = e2.value;
			var next_round1 = next_game[String.fromCharCode(i)+'1'];
			var next_round2 = next_game[String.fromCharCode(i)+'2'];
			console.log("team selected "+teamSelected);
			console.log("next round value "+document.getElementById("bracket_"+next_round1).value);

			if(teamSelected){
					if(e.options[0].value)
					$("#bracket_"+String.fromCharCode(i)+"1").prepend("<option value=''>Group "+String.fromCharCode(i-32)+" 1st</option>");
			}
			if(teamSelected2){
					if(e2.options[0].value)
					$("#bracket_"+String.fromCharCode(i)+"2").prepend("<option value=''>Group "+String.fromCharCode(i-32)+" 2nd</option>");
			}
			if(teamSelected){
					document.getElementById("bracket_"+String.fromCharCode(i)+"2").options[e.selectedIndex].disabled = true;
					setCSSSelected("#bracket_"+String.fromCharCode(i)+"1", true);
					console.log($("#bracket_"+next_round1).val());
					console.log("#bracket_"+next_round1);
					if(document.getElementById("bracket_"+next_round1).value!=teamSelected)
					displayInNextRound("#bracket_"+next_round1+" option[value="+teamSelected+"]", true);
				}
			if(teamSelected2){
					document.getElementById("bracket_"+String.fromCharCode(i)+"1").options[e2.selectedIndex].disabled = true;
					setCSSSelected("#bracket_"+String.fromCharCode(i)+"2",true);
					console.log($("#bracket_"+next_round2).val());
					if(document.getElementById("bracket_"+next_round2).value!=teamSelected2)
					displayInNextRound("#bracket_"+next_round2+" option[value="+teamSelected2+"]", true);
			}
		}
		// for (var i = 97; i <105; i++){
		// 	var e = document.getElementById("bracket_"+String.fromCharCode(i)+"1");
		// 	var teamSelected = e.options[e.selectedIndex].value;
		// 	var e2 = document.getElementById("bracket_"+String.fromCharCode(i)+"2");
		// 	var teamSelected2 = e2.options[e2.selectedIndex].value;
		// 	var next_round1 = next_game[String.fromCharCode(i)+'1'];
		// 	var next_round2 = next_game[String.fromCharCode(i)+'2'];
		// 	if(teamSelected)
		// 			if(document.getElementById("bracket_"+next_round1).value==teamSelected)
		// 			displayInNextRound("#bracket_"+next_round1+" option[value="+teamSelected+"]", true);
		// 	if(teamSelected2)
		// 			if(document.getElementById("bracket_"+next_round2).value==teamSelected2)
		// 			displayInNextRound("#bracket_"+next_round2+" option[value="+teamSelected2+"]", true);
		// }
	};

	function fixWGames () {
		var next_game = {'a1': 'w49', 'b2': 'w49', 'c1': 'w50', 'd2': 'w50', 'e1': 'w53', 'f2': 'w53', 'g1': 'w54', 'h2': 'w54', 'b1': 'w51', 'a2':'w51', 'd1':'w52', 'c2': 'w52', 'f1': 'e2', 'h1': 'w56', 'g2': 'w56', 'w49': 'w57', 'w50': 'w57', 'w53': 'w58', 'w54': 'w58', 'w57': 'w61', 'w58': 'w61', 'w51': 'w59', 'w52': 'w59', 'w55': 'w60', 'w56': 'w60', 'w59': 'w62', 'w60': 'w62'};
		for (var i = 49; i < 63; i++){
			var value = document.getElementById("bracket_w"+i.toString()).value;
			console.log("value = "+value);
			var e = document.getElementById("bracket_w"+i.toString());
			// var teamSelected = e.options[e.selectedIndex].value;
			// console.log("bracket_w"+i.toString());
			// console.log(e.selectedIndex);
			var teamSelected = document.getElementById("bracket_w"+i.toString()).value;
			console.log(teamSelected);
			var next_round = next_game['w'+i.toString()];
			if(teamSelected){
					console.log("Team Selected "+teamSelected+" for "+i);
					if(e.options[0].value)
					$("#bracket_w"+i.toString()).prepend("<option value=''>Winner Game "+i.toString()+"</option>");
					setCSSSelected("#bracket_w"+i.toString(),true);
					displayInNextRound("#bracket_"+next_round+" option[value="+teamSelected+"]", true);
					console.log("#bracket_"+next_round+" option[value="+teamSelected+"]");

			}

		}
	};

	function setCSSSelected(elem, b){
		if (b) {
		$(elem).removeClass("notselected");
		$(elem).addClass("selected");
		}
		else
		{
		$(elem).removeClass("selected");
		$(elem).addClass("notselected");
		}
	};

	function displayInNextRound(elem, b){
		if(b) {
			if($(elem).parent("span").length){
				console.log(elem+" Parent span length: "+$(elem).parent("span").length);
				$(elem).show();
				$(elem).unwrap('<span style="display:none;" />');
			}
		}
		else{
			$(elem).hide();
			$(elem).prop("selected", false);
			if($(elem).parent("select").length)
			$(elem).wrap('<span style="display:none;" />');
		};
	};
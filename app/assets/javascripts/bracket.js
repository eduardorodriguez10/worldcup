
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
				oldTeam = document.getElementById(selected+"-old").value;
			}
		}	
		var teamSelected = e.options[valueSelected].value;		
		// set CSS to selected if value selected
		setCSSSelected("#bracket_"+selected, valueSelected);
		// show the new team and hide the old team in the next round
		if(oldTeam!='-1'){
			document.getElementById("bracket_"+disabled).options[oldTeamIndex].disabled = false;
			displayInNextRound("#bracket_"+next_round+" option[value="+oldTeam.toString()+"]", false);
		}
		if(teamSelected!='0'){
			document.getElementById("bracket_"+disabled).options[valueSelected].disabled = true;
			displayInNextRound("#bracket_"+next_round+" option[value="+teamSelected.toString()+"]", true);
			console.log("Trying to Set");
		};
		document.getElementById(selected+"-old").value = document.getElementById("bracket_"+selected).value;
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
		$("#bracket_"+selected).val(teamSelected);
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


		// set CSS to selected if value selected
		setCSSSelected("#bracket_"+selected, valueSelected);
		// show the new team and hide the old team in the next round
		if(valueSelected){
			// console.log('Value Selected = '+teamSelected);
			// console.log("#bracket_"+disabled+" option[value="+teamSelected.toString()+"]");
			// document.getElementById("bracket_"+disabled).options[teamSelected].disabled = true;
			// console.log("Disabling "+"#bracket_"+disabled+" option[value="+teamSelected.toString()+"]");
			
			$("#bracket_"+disabled+" option[value="+teamSelected.toString()+"]").prop('disabled', true);
			if(selected[0]=='w'){
				displayInNextRound("#bracket_champion option[value="+teamSelected.toString()+"]", true);
			};
			if(selected[0]=='l'){
				displayInNextRound("#bracket_third option[value="+teamSelected.toString()+"]", true);
			};
		};

		if(oldTeam){
			console.log("OldTeam = "+oldTeam);
			// document.getElementById("bracket_"+disabled).options[oldTeam].disabled = false;
			$("#bracket_"+disabled+" option[value="+oldTeam.toString()+"]").removeAttr("disabled");
			console.log("Removing Disabled"+"#bracket_"+disabled+" option[value="+oldTeam.toString()+"]");
			if(selected[0]=='w'){
				displayInNextRound("#bracket_champion option[value="+oldTeam.toString()+"]", false);
			};
			if(selected[0]=='l'){
				displayInNextRound("#bracket_third option[value="+oldTeam.toString()+"]", false);
			}
		}
		document.getElementById(selected+"-old").value = teamSelected;
	};
	function changeFinals(selected){
		var e = document.getElementById("bracket_"+selected);
		var valueSelected = e.selectedIndex;
		// get value of new team selected
		var teamSelected = e.value;

		// set the CSS to selected if value is selected
		setCSSSelected("#bracket_"+selected, valueSelected);
	};


	function hideTeamsW(){
		var prev_game = {'w491':'a1', 'w492': 'b2', 'w501': 'c1', 'w502':'d2', 'w531': 'e1', 'w532': 'f2', 'w541': 'g1', 'w542': 'h2', 'w511': 'b1', 'w512': 'a2', 'w521': 'd1', 'w522': 'c2', 'w551': 'f1', 'w552': 'e2', 'w561': 'h1', 'w562': 'g2', 'w571': 'w49', 'w572': 'w50', 'w581': 'w53', 'w582': 'w54', 'w611': 'w57', 'w612': 'w58', 'w591': 'w51', 'w592': 'w52', 'w601': 'w55', 'w602': 'w56', 'w621': 'w59', 'w622': 'w60', 'champion1': 'w61', 'champion2': 'w62', 'l611': 'w58', 'l612': 'w57', 'l621': 'w59', 'l622': 'w60' };
		for (var i = 49; i<63; i++){
			var selIndex = document.getElementById("bracket_w"+i).selectedIndex;
			if (selIndex)
				selIndex++;
			for(var t = 1; t<33; t++){
					if(selIndex!=t && t!=document.getElementById(prev_game["w"+i+"1"]+"-old").value && t!=document.getElementById(prev_game["w"+i+"2"]+"-old").value){
						displayInNextRound("#bracket_w"+i.toString()+" option[value="+t.toString()+"]", false);
					}
				};
		};
	};
	function hideTeamsL(){
		var prev_game = {'l611': 'w58', 'l612': 'w57', 'l621': 'w59', 'l622': 'w60' };
		for (var i = 61; i < 63; i++){
		var selIndex = document.getElementById("bracket_l"+i).selectedIndex;
		if (selIndex)
			selIndex++;
		for(var t = 1; t<33; t++){
				if(selIndex!=t && t!=document.getElementById(prev_game["l"+i+"1"]+"-old").value && t!=document.getElementById(prev_game["l"+i+"2"]+"-old").value){
						displayInNextRound("#bracket_l"+i.toString()+" option[value="+t.toString()+"]", false);
				}
			};
		}
	};

	function hide3rdAndChampion(){

		for(var t = 1; t<33; t++){
			    displayInNextRound("#bracket_third option[value="+t.toString()+"]", false);
			};
		for(var t = 1; t<33; t++){
				displayInNextRound("#bracket_champion option[value="+t.toString()+"]", false);
			};
	};

	//readjust R16 javascript in case of reload
	function fixR16Games() {
		var next_game = {'a1': 'w49', 'b2': 'w49', 'c1': 'w50', 'd2': 'w50', 'e1': 'w53', 'f2': 'w53', 'g1': 'w54', 'h2': 'w54', 'b1': 'w51', 'a2':'w51', 'd1':'w52', 'c2': 'w52', 'f1': 'w55', 'e2': 'w55', 'h1': 'w56', 'g2': 'w56', 'w49': 'w57', 'w50': 'w57', 'w53': 'w58', 'w54': 'w58', 'w57': 'w61', 'w58': 'w61', 'w51': 'w59', 'w52': 'w59', 'w55': 'w60', 'w56': 'w60', 'w59': 'w62', 'w60': 'w62'};
		for (var i = 97; i <105; i++){
			var e = document.getElementById("bracket_"+String.fromCharCode(i)+"1");
			var teamSelected = e.value;
			var teamSelected = document.getElementById(String.fromCharCode(i)+"1"+"-old").value;
			var e2 = document.getElementById("bracket_"+String.fromCharCode(i)+"2");
			var teamSelected2 = e2.value;
			var teamSelected2 = document.getElementById(String.fromCharCode(i)+"2"+"-old").value;
			var next_round1 = next_game[String.fromCharCode(i)+'1'];
			var next_round2 = next_game[String.fromCharCode(i)+'2'];
			console.log("Team Selected 1 "+ teamSelected);
			console.log("Team Selected 2 "+ teamSelected2);
			if(teamSelected!='-1'){
					console.log("Entered teamSelected");
					if(e.options[0].value)
					$("#bracket_"+String.fromCharCode(i)+"1").prepend("<option value=''>Group "+String.fromCharCode(i-32)+" 1st</option>");
			}
			if(teamSelected2!='-1'){
					if(e2.options[0].value)
					$("#bracket_"+String.fromCharCode(i)+"2").prepend("<option value=''>Group "+String.fromCharCode(i-32)+" 2nd</option>");
			}
			if(teamSelected!='-1'){
					document.getElementById("bracket_"+String.fromCharCode(i)+"2").options[e.selectedIndex].disabled = true;
					setCSSSelected("#bracket_"+String.fromCharCode(i)+"1", true);
					// if(document.getElementById(next_round1+"-old").value!=teamSelected)
						// displayInNextRound("#bracket_"+next_round1+" option[value="+teamSelected+"]", true);
				}
			if(teamSelected2!='-1'){
					document.getElementById("bracket_"+String.fromCharCode(i)+"1").options[e2.selectedIndex].disabled = true;
					setCSSSelected("#bracket_"+String.fromCharCode(i)+"2",true);
					// if(document.getElementById(next_round2+"-old").value!=teamSelected2)
						// displayInNextRound("#bracket_"+next_round2+" option[value="+teamSelected2+"]", true);
			}

		}
	};

	function fixWGames () {
		var next_game = {'a1': 'w49', 'b2': 'w49', 'c1': 'w50', 'd2': 'w50', 'e1': 'w53', 'f2': 'w53', 'g1': 'w54', 'h2': 'w54', 'b1': 'w51', 'a2':'w51', 'd1':'w52', 'c2': 'w52', 'f1': 'w55', 'e2': 'w55', 'h1': 'w56', 'g2': 'w56', 'w49': 'w57', 'w50': 'w57', 'w53': 'w58', 'w54': 'w58', 'w57': 'w61', 'w58': 'w61', 'w51': 'w59', 'w52': 'w59', 'w55': 'w60', 'w56': 'w60', 'w59': 'w62', 'w60': 'w62', 'w61': 'champion', 'w62': 'champion', 'w58':'l61', 'w59': 'l62', 'w60': 'l62', 'w57': 'l61'};
		var prev_game = {'w491':'a1', 'w492': 'b2', 'w501': 'c1', 'w502':'d2', 'w531': 'e1', 'w532': 'f2', 'w541': 'g1', 'w542': 'h2', 'w511': 'b1', 'w512': 'a2', 'w521': 'd1', 'w522': 'c2', 'w551': 'f1', 'w552': 'e2', 'w561': 'h1', 'w562': 'g2', 'w571': 'w49', 'w572': 'w50', 'w581': 'w53', 'w582': 'w54', 'w611': 'w57', 'w612': 'w58', 'w591': 'w51', 'w592': 'w52', 'w601': 'w55', 'w602': 'w56', 'w621': 'w59', 'w622': 'w60', 'champion1': 'w61', 'champion2': 'w62', 'l611': 'w58', 'l612': 'w57', 'l621': 'w59', 'l622': 'w60' };
		for (var i = 49; i < 63; i++){
			var value = document.getElementById("bracket_w"+i.toString()).value;
			var e = document.getElementById("bracket_w"+i.toString());
			var teamSelected = document.getElementById("w"+i.toString()+"-old").value;
			var next_round = next_game['w'+i.toString()];
			

				var team1  = document.getElementById(prev_game['w'+i.toString()+'1']+"-old").value;
				var team2  = document.getElementById(prev_game['w'+i.toString()+'2']+"-old").value;
			
			
			if(teamSelected!='-1'){
					if(e.options[0].value)
					$("#bracket_w"+i.toString()).prepend("<option value=''>Winner Game "+i.toString()+"</option>");

					setCSSSelected("#bracket_w"+i.toString(),true);

					displayInThisRound("#bracket_w"+i+" option[value="+team1+"]", true);
					displayInThisRound("#bracket_w"+i+" option[value="+team2+"]", true);
					document.getElementById('bracket_w'+i.toString()).value = document.getElementById('w'+i.toString()+"-old").value;
					$("#bracket_w"+i.toString()).val($("#w"+i.toString()+"-old").val());

					if(i==61){
						displayInThisRound("#bracket_l61 option[value="+document.getElementById(prev_game['l'+i.toString()+'1']+"-old").value+"]", true);
						displayInThisRound("#bracket_l61 option[value="+document.getElementById(prev_game['l'+i.toString()+'2']+"-old").value+"]", true);
						document.getElementById('bracket_l61').value = document.getElementById("l61-old").value;
					}
					if(i==62){
						displayInThisRound("#bracket_l62 option[value="+document.getElementById(prev_game['l'+i.toString()+'1']+"-old").value+"]", true);
						displayInThisRound("#bracket_l62 option[value="+document.getElementById(prev_game['l'+i.toString()+'2']+"-old").value+"]", true);
						document.getElementById('bracket_l62').value = document.getElementById("l62-old").value;
					}

			};
		};
	};

	function fixLGames(){
		var next_game = {'l61': 'third', 'l62': 'third'}
		for (var i = 61; i < 63; i++){
			var e = document.getElementById("bracket_l"+i.toString());
			var teamSelected = document.getElementById("l"+i.toString()+"-old").value;
			if(teamSelected!='-1'){
				if(e.options[0].value)
					$("#bracket_l"+i.toString()).prepend("<option value=''>Loser Game "+i.toString()+"</option>");

				setCSSSelected("#bracket_l"+i.toString(),true);
				displayInNextRound("#bracket_third option[value="+teamSelected+"]", true);
			};
		};
	};

	function disableFinals(){
		for (var i = 61; i < 63; i++){
			var e = document.getElementById("bracket_l"+i.toString());
			var teamSelected = document.getElementById("l"+i.toString()+"-old").value;
			console.log("l"+i.toString()+"-old "+ document.getElementById("l"+i.toString()+"-old").value);
			if(teamSelected!='-1'){
				// document.getElementById("bracket_w"+i.toString()).options[teamSelected].disabled = true;
				$("#bracket_w"+i.toString()+" option[value="+teamSelected.toString()+"]").prop('disabled', true);
			}
			var e = document.getElementById("bracket_w"+i.toString());
			var teamSelected = document.getElementById("w"+i.toString()+"-old").value;
			if(teamSelected!='-1'){
				// document.getElementById("bracket_l"+i.toString()).options[teamSelected].disabled = true;
				$("#bracket_l"+i.toString()+" option[value="+teamSelected.toString()+"]").prop('disabled', true);
			}
		};
	};

	function fix3rdAndChampion(){
			var prev_game = {'w491':'a1', 'w492': 'b2', 'w501': 'c1', 'w502':'d2', 'w531': 'e1', 'w532': 'f2', 'w541': 'g1', 'w542': 'h2', 'w511': 'b1', 'w512': 'a2', 'w521': 'd1', 'w522': 'c2', 'w551': 'f1', 'w552': 'e2', 'w561': 'h1', 'w562': 'g2', 'w571': 'w49', 'w572': 'w50', 'w581': 'w53', 'w582': 'w54', 'w611': 'w57', 'w612': 'w58', 'w591': 'w51', 'w592': 'w52', 'w601': 'w55', 'w602': 'w56', 'w621': 'w59', 'w622': 'w60', 'champion1': 'w61', 'champion2': 'w62', 'l611': 'w58', 'l612': 'w57', 'l621': 'w59', 'l622': 'w60' };
			var e = document.getElementById("bracket_third");
			var teamSelected = document.getElementById("third-old").value;
			if(teamSelected!='-1'){
				if(e.options[0].value)
					$("#bracket_third").prepend("<option value=''>Third Place</option>");

				setCSSSelected("#bracket_third",true);
			}
			var e = document.getElementById("bracket_champion");
			var teamSelected = document.getElementById("champion-old").value;
			if(teamSelected!='-1'){
				if(e.options[0] == null || e.options[0].value)
					$("#bracket_champion").prepend("<option value=''>Champion</option>");

				setCSSSelected("#bracket_champion",true);
			}
			if(document.getElementById("third-old").value != '-1')
				document.getElementById("bracket_third").value = document.getElementById("third-old").value;
			if(document.getElementById("champion-old").value != '-1'){
				displayInThisRound("#bracket_champion option[value="+document.getElementById("w61-old").value+"]", true);
				displayInThisRound("#bracket_champion option[value="+document.getElementById("w62-old").value+"]", true);
				document.getElementById('bracket_champion').value = document.getElementById("champion-old").value;
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
		
		if(document.getElementById("browser").value != 'Chrome' || document.getElementById("browser").value != 'Safari'){
			if(b){
				$(elem).show();
				if($(elem).parent("span").length)
					$(elem).unwrap('<span style="display:none;" />');
			}
			else {
					$(elem).hide();
					$(elem).prop("selected", false);
					if(!($(elem).parent("span").length))
						$(elem).wrap('<span style="display:none;" />');
				}
		} 
		else {
			if(b)
				$(elem).show();
			else {
				$(elem).hide();
				$(elem).prop("selected", false);
			}
		}
	};

	function displayInThisRound(elem, b){

		if(document.getElementById("browser").value != 'Chrome' || document.getElementById("browser").value != 'Safari'){
			if(b){
				$(elem).show();
				if($(elem).parent("span").length)
					$(elem).unwrap('<span style="display:none;" />');
			}
			else {
					$(elem).hide();
					$(elem).prop("selected", false);
					if(!($(elem).parent("span").length))
						$(elem).wrap('<span style="display:none;" />');
				}
		} 
		else {
			if(b)
				$(elem).show();
			else {
				$(elem).hide();
				$(elem).prop("selected", false);
			}
		}
	};

	function hideTeams(){
				//hide teams for wGames
			hideTeamsW();

		//hide teams for L61 and L62
			hideTeamsL();

		// hide 3rd Place and Champions Teams
			hide3rdAndChampion();

	};

	function fixSelects(){

			fixR16Games();

			fixWGames();
			fixLGames();

			fix3rdAndChampion();

			disableFinals();

			hideTeamsW();
			hideTeamsL();

	};

	function showMessage(elem){
		var y = window.scrollY + (window.innerHeight / 2) - 100;
		var x = (window.innerWidth / 2) - 150;
		$(elem).css("top",y+'px');
		$(elem).css("left",x+'px');
		$(elem).removeClass("off");
		$(elem).addClass("on");
		console.log("showMessage Function");
	};

	function clearMessage(elem){
		$(elem).removeClass("on");
		$(elem).addClass("off");
		console.log("clearMessage Function");
	};




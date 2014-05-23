
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


	function hideTeamsW(){
		for (var i = 49; i<63; i++){
			var selIndex = document.getElementById("bracket_w"+i).selectedIndex;
			document.getElementById("w"+i+"-old").value = document.getElementById("bracket_w"+i).value;
			if (selIndex)
				selIndex++;
			for(var t = 1; t<33; t++){
					if(selIndex!=t){
					$("#bracket_w"+i.toString()+" option[value="+t.toString()+"]").hide();
					$("#bracket_w"+i.toString()+" option[value="+t.toString()+"]").wrap('<span style="display:none;" />');
					}
				};
		};
	};
	function hideTeamsL(){
		for (var i = 61; i < 63; i++){
		var selIndex = document.getElementById("bracket_l"+i).selectedIndex;
		document.getElementById("l"+i+"-old").value = document.getElementById("bracket_l"+i).value;
		if (selIndex)
			selIndex++;
		for(var t = 1; t<33; t++){
				if(selIndex!=t){
				$("#bracket_l"+i.toString()+" option[value="+t.toString()+"]").hide();
				$("#bracket_l"+i.toString()+" option[value="+t.toString()+"]").wrap('<span style="display:none;" />');
				}
			};
		}
	};

	function hide3rdAndChampion(){
		var e = document.getElementById("bracket_third");
		var teamSelected = document.getElementById("bracket_third").value;
		if(teamSelected)
		document.getElementById('third-old').value = teamSelected;

		var e = document.getElementById("bracket_champion");
		var teamSelected = document.getElementById("bracket_champion").value;
		if(teamSelected)
		document.getElementById('champion-old').value = teamSelected;

		for(var t = 1; t<33; t++){
				$("#bracket_third option[value="+t.toString()+"]").hide();
				$("#bracket_third option[value="+t.toString()+"]").wrap('<span style="display:none;" />');
			};
		for(var t = 1; t<33; t++){
				$("#bracket_champion option[value="+t.toString()+"]").hide();
				$("#bracket_champion option[value="+t.toString()+"]").wrap('<span style="display:none;" />');
			};
	};

	//readjust R16 javascript in case of reload
	function fixR16Games() {
		var next_game = {'a1': 'w49', 'b2': 'w49', 'c1': 'w50', 'd2': 'w50', 'e1': 'w53', 'f2': 'w53', 'g1': 'w54', 'h2': 'w54', 'b1': 'w51', 'a2':'w51', 'd1':'w52', 'c2': 'w52', 'f1': 'w60', 'e2': 'w60', 'h1': 'w56', 'g2': 'w56', 'w49': 'w57', 'w50': 'w57', 'w53': 'w58', 'w54': 'w58', 'w57': 'w61', 'w58': 'w61', 'w51': 'w59', 'w52': 'w59', 'w55': 'w60', 'w56': 'w60', 'w59': 'w62', 'w60': 'w62'};
		for (var i = 97; i <105; i++){
			var e = document.getElementById("bracket_"+String.fromCharCode(i)+"1");
			var teamSelected = e.value;
			var e2 = document.getElementById("bracket_"+String.fromCharCode(i)+"2");
			var teamSelected2 = e2.value;
			var next_round1 = next_game[String.fromCharCode(i)+'1'];
			var next_round2 = next_game[String.fromCharCode(i)+'2'];

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
					console.log("TEAM SELECTED NEXT ROUND FOR "+next_round1+" "+document.getElementById("bracket_"+next_round1).value);
					if(document.getElementById("bracket_"+next_round1).value!=teamSelected)
						displayInNextRound("#bracket_"+next_round1+" option[value="+teamSelected+"]", true);
				}
			if(teamSelected2){
					document.getElementById("bracket_"+String.fromCharCode(i)+"1").options[e2.selectedIndex].disabled = true;
					setCSSSelected("#bracket_"+String.fromCharCode(i)+"2",true);
					if(document.getElementById("bracket_"+next_round2).value!=teamSelected2)
						displayInNextRound("#bracket_"+next_round2+" option[value="+teamSelected2+"]", true);
			}

			document.getElementById("bracket_"+next_round1).value = document.getElementById(next_round1+"-old").value;
			document.getElementById("bracket_"+next_round2).value = document.getElementById(next_round2+"-old").value;

		}
	};

	function fixWGames () {
		var next_game = {'a1': 'w49', 'b2': 'w49', 'c1': 'w50', 'd2': 'w50', 'e1': 'w53', 'f2': 'w53', 'g1': 'w54', 'h2': 'w54', 'b1': 'w51', 'a2':'w51', 'd1':'w52', 'c2': 'w52', 'f1': 'w60', 'e2': 'w60', 'h1': 'w56', 'g2': 'w56', 'w49': 'w57', 'w50': 'w57', 'w53': 'w58', 'w54': 'w58', 'w57': 'w61', 'w58': 'w61', 'w51': 'w59', 'w52': 'w59', 'w55': 'w60', 'w56': 'w60', 'w59': 'w62', 'w60': 'w62', 'w61': 'champion', 'w62': 'champion', 'l58':'l61', 'l59': 'l62', 'l60': 'l62', 'l57': 'l61'};
		for (var i = 49; i < 63; i++){
			var value = document.getElementById("bracket_w"+i.toString()).value;
			var e = document.getElementById("bracket_w"+i.toString());
			var teamSelected = document.getElementById("bracket_w"+i.toString()).value;
			var next_round = next_game['w'+i.toString()];
			if(teamSelected){
					if(e.options[0].value)
					$("#bracket_w"+i.toString()).prepend("<option value=''>Winner Game "+i.toString()+"</option>");

					setCSSSelected("#bracket_w"+i.toString(),true);
					document.getElementById('w'+i.toString()+"-old").value = teamSelected;

					if(i<61)
					displayInNextRound("#bracket_"+next_round+" option[value="+teamSelected+"]", true);

					if(i==57 || i == 58)
						displayInNextRound("#bracket_l61 option[value="+teamSelected+"]", true);

					if(i==59 || i == 60)
						displayInNextRound("#bracket_l62 option[value="+teamSelected+"]", true);

					if(i==61 || i == 62)
						displayInNextRound("#bracket_champion option[value="+teamSelected+"]", true);
			};
		if(i<61)
			document.getElementById("bracket_"+next_round).value = document.getElementById(next_round+"-old").value;
		if(i>56 && i<61){
			next_round = next_game['l'+i.toString()];
			document.getElementById("bracket_"+next_round).value = document.getElementById(next_round+"-old").value;
		}

		};
		

	};

	function fixLGames(){
		var next_game = {'l61': 'third', 'l62': 'third'}
		for (var i = 61; i < 63; i++){
			var e = document.getElementById("bracket_l"+i.toString());
			var teamSelected = document.getElementById("bracket_l"+i.toString()).value;
			if(teamSelected){
				if(e.options[0].value)
					$("#bracket_l"+i.toString()).prepend("<option value=''>Loser Game "+i.toString()+"</option>");

				setCSSSelected("#bracket_l"+i.toString(),true);
				document.getElementById('l'+i.toString()+"-old").value = teamSelected;
				displayInNextRound("#bracket_third option[value="+teamSelected+"]", true);
			};
		};
		var teamSelectedThird = document.getElementById("bracket_third").value;
		console.log("TEAM SELECTED IN THIRD BEFORE FIXING "+ teamSelectedThird);
		$("#bracket_third").val(teamSelectedThird);
		var teamSelectedThird = document.getElementById("bracket_third").value;
		console.log("TEAM SELECTED IN THIRD AFTER FIXING "+ teamSelectedThird);

	};

	function disableFinals(){
		for (var i = 61; i < 63; i++){
			var e = document.getElementById("bracket_l"+i.toString());
			var teamSelected = document.getElementById("bracket_l"+i.toString()).value;
			if(teamSelected)
				document.getElementById("bracket_w"+i.toString()).options[teamSelected].disabled = true;
			var e = document.getElementById("bracket_w"+i.toString());
			var teamSelected = document.getElementById("bracket_w"+i.toString()).value;
			if(teamSelected)
				document.getElementById("bracket_l"+i.toString()).options[teamSelected].disabled = true;
		};
	};

	function fix3rdAndChampion(){
			var e = document.getElementById("bracket_third");
			var teamSelected = document.getElementById("bracket_third").value;
			if(teamSelected){
				if(e.options[0].value)
					$("#bracket_third").prepend("<option value=''>Third Place</option>");

				setCSSSelected("#bracket_third",true);
			}
			var e = document.getElementById("bracket_champion");
			var teamSelected = document.getElementById("bracket_champion").value;
			if(teamSelected){
				if(e.options[0].value)
					$("#bracket_champion").prepend("<option value=''>Champion</option>");

				setCSSSelected("#bracket_champion",true);
			}
			if(document.getElementById("third-old").value != '0')
				document.getElementById("bracket_third").value = document.getElementById("third-old").value;
			if(document.getElementById("champion-old").value != '0')
				document.getElementById("bracket_champion").value = document.getElementById("champion-old").value;

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
			console.log("trying to set "+elem+" with span length "+$(elem).parent("span").length)
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




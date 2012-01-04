$(document).ready(function() {
	if ($("#draft_status_container").length > 0){
		setTimeout(updateDraftStatus, 30000);
	}

//    $("div#[id^='alert']").fadeOut(8000);
//    $("div#[id^='notice']").fadeOut(8000);

    $('#notice').slideDown('slow');
        setTimeout(function(){
            $('#notice').slideUp('slow');
        }, 5000);

    $('#alert').slideDown('slow');
        setTimeout(function(){
            $('#alert').slideUp('slow');
        }, 5000);

});

function updateDraftStatus() {
	var current_pick = $("#current_pick").html();
	$.getScript("/draft/get_current_draft_status.js?previous_pick=" + current_pick);
	setTimeout(updateDraftStatus, 30000);
}

function getRoster(mm_team_id) {
	$.getScript("/mm_teams/get_roster.js?mm_team_id=" + mm_team_id);
}

function getEligiblePlayersByRound() {
	id = $("#player_selected_round").val();
	$.getScript("/draft/get_eligible_players_by_round.js?selected_round=" + id);
}

function getNcaaPlayersByTeam() {
	id = $("#ncaa_player_ncaa_team_id").val();
	$.getScript("/ncaa_players/get_by_ncaa_team.js?ncaa_team_id=" + id);
}

function getScoringDetails(player_id)
{
	$.getScript("/home/player_scoring_details.js?player_id=" + player_id);
}




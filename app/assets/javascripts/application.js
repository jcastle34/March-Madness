// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require plugins
//= require_self

$(document).ready(function() {
    if ($("#draft_status_container").length > 0){
        setTimeout(updateDraftStatus, 30000);
    }

    $('#notice').slideDown('slow');
    setTimeout(function(){
        $('#notice').slideUp('slow');
    }, 5000);

    $('#alert').slideDown('slow');
    setTimeout(function(){
        $('#alert').slideUp('slow');
    }, 5000);

    $('#my_team').colorbox({
        href: function(){
            var id = $(this).data('team');
            return "/mm_teams/get_roster.js?mm_team_id=" + id;
        }
    });

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

function getPreferredPlayersByRound() {
    id = $("#preferred_player_selected_round").val();
    $.getScript("/draft/get_preferred_players_by_round.js?selected_round=" + id);
}

function getNcaaPlayersByTeam() {
    id = $("#ncaa_player_ncaa_team_id").val();
    $.getScript("/ncaa_players/get_by_ncaa_team.js?ncaa_team_id=" + id);
}

function getScoringDetails(player_id)
{
    $.getScript("/home/player_scoring_details.js?player_id=" + player_id);
}




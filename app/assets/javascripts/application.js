// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require plugins
//= require colorbox
//= require bootstrap
//= require backtop
//= require chosen
//= require_self

$(document).ready(function() {
    initChosen();

    var heightFix = $(document).outerHeight();
    $('#nav_container').css({
        height: heightFix+"px"
    });

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

    $('.standings_mm_team').colorbox({
        href: function(){
            var id = $(this).data('team');
            return "/mm_teams/get_roster.js?mm_team_id=" + id;
        }
    });

    $('#flash').fadeIn('slow');
    setTimeout(function(){
        $('#flash').fadeOut('slow');
    }, 5000);

    $('.icon_close').on('click', function(){
        $(this).parent().fadeOut();
        return false;
    });

    $('#sidebar-toggle').on('click', function() {
        menu = $('#main_nav').html();
        if($('#mobile_nav').length) {
            $('#mobile_nav').remove();
        } else {
            $('#top_nav').after("<ul id=\"mobile_nav\">" + menu +"</ul>");

        }
    });

});

function updateDraftStatus() {
    var current_pick = $("#current_pick").html();
    $.getScript("/draft/get_current_draft_status.js?previous_pick=" + current_pick);
    setTimeout(updateDraftStatus, 30000);
}

function getEligiblePlayersByRound(mm_team_id) {
    id = $("#player_selected_round").val();
    if($('#draft_page_container').length == 0) {
        $.getScript("/mm_teams/" + mm_team_id + "/get_eligible_players_by_round.js?selected_round=" + id);
    }
    else {
        $.getScript("/draft/get_eligible_players_by_round.js?selected_round=" + id);
    }

}

function getPreferredPlayersByRound(mm_team_id) {
    id = $("#preferred_player_selected_round").val();
    if($('#draft_page_container').length == 0) {
        $.getScript("/mm_teams/" + mm_team_id + "/get_preferred_players_by_round.js?selected_round=" + id);
    }
    else {
        $.getScript("/draft/get_preferred_players_by_round.js?selected_round=" + id);
    }
}

function addPreferredPlayer(player_id, mm_team_id) {
    id = $("#player_selected_round").val();
    $.getScript("/mm_teams/" + mm_team_id + "/add_preferred_player.js?ncaa_player_id=" + player_id + "&selected_round=" + id);
}

function removePreferredPlayer(player_id, mm_team_id) {
    id = $("#preferred_player_selected_round").val();
    $.getScript("/mm_teams/" + mm_team_id + "/remove_preferred_player.js?ncaa_player_id=" + player_id + "&selected_round=" + id);
}

function getNcaaPlayersByTeam() {
    id = $("#ncaa_player_ncaa_team_id").val();
    $.getScript("/ncaa_players/get_by_ncaa_team.js?ncaa_team_id=" + id);
}

function getScoringDetails(player_id)
{
    $.getScript("/home/player_scoring_details.js?player_id=" + player_id);
}

function showPreferredPlayers() {
    id = $("#player_selected_round").val();
    $.getScript("/draft/get_preferred_players_by_round.js?selected_round=" + id);
    $('#draft_players_container').hide();
    $('#preferred_players_container').show();
    $('#show_preferred_players').addClass('on').siblings().removeClass('on');
}

function showEligiblePlayers() {
    id = $("#preferred_player_selected_round").val();
    $.getScript("/draft/get_eligible_players_by_round.js?selected_round=" + id);
    $('#preferred_players_container').hide();
    $('#draft_players_container').show();
    $('#show_all_players').addClass('on').siblings().removeClass('on');
}

function initChosen() {
    $('select').chosen();
}





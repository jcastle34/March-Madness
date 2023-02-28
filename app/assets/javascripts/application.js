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

function getEligiblePlayersByPosition(mm_team_id, sort, sort_order) {
    position = $("#player_selected_position").val();
    $.getScript("/mm_teams/" + mm_team_id + "/get_eligible_players_by_position.js?selected_position=" + position + "&sort=" + sort + "&sort_order=" + sort_order);
}

function sortEligiblePlayers(mm_team_id, sort, sort_order) {
    position = $("#player_selected_position").val();
    $.getScript("/mm_teams/" + mm_team_id + "/sort_eligible_players.js?selected_position=" + position + "&sort=" + sort + "&sort_order=" + sort_order);
}

function addPreferredPlayer(player_id, mm_team_id) {
    $.getScript("/mm_teams/" + mm_team_id + "/add_preferred_player.js?ncaa_player_id=" + player_id);
}

function removePreferredPlayer(player_id, mm_team_id) {
    $.getScript("/mm_teams/" + mm_team_id + "/remove_preferred_player.js?ncaa_player_id=" + player_id);
}

function getNcaaPlayersByTeam() {
    id = $("#ncaa_player_ncaa_team_id").val();
    $.getScript("/admin/ncaa_players/get_by_ncaa_team.js?ncaa_team_id=" + id);
}

function getScoringDetails(player_id)
{
    $.getScript("/home/player_scoring_details.js?player_id=" + player_id);
}

function initChosen() {
    $('select').chosen();
}





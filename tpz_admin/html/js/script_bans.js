$(function () {

    $("#main").on("click", "#bans-section-refresh-icon", function () {
        PlayButtonClickSound();

        $("#bans-section-search-input").val('');

        $.post('http://tpz_admin/request_bans_section', JSON.stringify({}));
    });

    $("#main").on("click", "#bans-section-search-button", function () {
        PlayButtonClickSound();

        let $input = $("#bans-section-search-input").val();

        $.post('http://tpz_admin/request_bans_section_search_input', JSON.stringify({
            input: $input,
        }));

    });

    $("#main").on("click", "#bans-section-users-pages-list-value", function () {
        PlayButtonClickSound();

        let $button = $(this);
        let $selectedPage = $button.attr('page');

        $.post("http://tpz_admin/request_bans_section_page", JSON.stringify({ page: $selectedPage }));
    });

    $("#main").on("click", "#bans-section-users-list-main", function () {
        PlayButtonClickSound();

        let $button = $(this);
        let $identifier = $button.attr('identifier');
        let $steamname = $button.attr('steamname');

        SELECTED_BANNED_USER = $identifier;
        SELECTED_BANNED_USER_STEAM = $steamname;

        $("#bans-section-dialog-title").text($steamname);
        $(".bans-section-dialog").fadeIn();
    });


    $("#main").on("click", "#bans-section-dialog-cancel-button", function () {
        PlayButtonClickSound();
        $(".bans-section-dialog").fadeOut();
    });


    $("#main").on("click", "#bans-section-dialog-unban-button", function () {
        PlayButtonClickSound();
        
        $(".bans-section-dialog").fadeOut();

        $.post("http://tpz_admin/unban", JSON.stringify({ 
            steamname: SELECTED_BANNED_USER_STEAM, 
            identifier: SELECTED_BANNED_USER 
        }));

    });

});
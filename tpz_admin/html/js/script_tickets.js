$(function () {

    $("#main").on("click", "#tickets-section-refresh-icon", function () {
        PlayButtonClickSound();

        $("#tickets-section-search-input").val('');

        $.post('http://tpz_admin/request_tickets_section', JSON.stringify({}));
    });

    $("#main").on("click", "#tickets-section-search-button", function () {
        PlayButtonClickSound();

        let $input = $("#tickets-section-search-input").val();

        $.post('http://tpz_admin/request_tickets_section_search_input', JSON.stringify({
            input: $input,
        }));

    });

    $("#main").on("click", "#tickets-section-users-pages-list-value", function () {
        PlayButtonClickSound();

        let $button = $(this);
        let $selectedPage = $button.attr('page');

        $.post("http://tpz_admin/request_tickets_section_page", JSON.stringify({ page: $selectedPage }));
    });

    $("#main").on("click", "#tickets-section-users-list-main", function () {
        PlayButtonClickSound();

        let $button = $(this);
        let $steamname = $button.attr('steamname');
        let $count = $button.attr('count');
        let $timestamp = $button.attr('timestamp');

        SELECTED_TICKET_TIMESTAMP = $timestamp;

        $("#tickets-section-dialog-title").text("#" + $count + " - " + $steamname);
        $(".tickets-section-dialog").fadeIn();
    });


    $("#main").on("click", "#tickets-section-dialog-cancel-button", function () {
        PlayButtonClickSound();
        $(".tickets-section-dialog").fadeOut();
    });


    $("#main").on("click", "#tickets-section-dialog-delete-button", function () {
        PlayButtonClickSound();
        
        $(".tickets-section-dialog").fadeOut();

        $.post("http://tpz_admin/delete_ticket", JSON.stringify({ 
            timestamp: SELECTED_TICKET_TIMESTAMP, 
        }));

    });

    $("#create-ticket").on("click", "#create-ticket-close-button", function () {
        PlayButtonClickSound();
        CloseNUI();
    });


    $("#create-ticket").on("click", "#create-ticket-send-button", function () {
        PlayButtonClickSound();
        
        let $title = $("#create-ticket-title-textarea").val().trim();
        let $message = $("#create-ticket-message-textarea").val().trim();

        if (!$title) {
            RequestNotification('NUI_CREATE_TICKET_NO_TITLE', "error");
            return;
        }

        if (!$message) {
            RequestNotification('NUI_CREATE_TICKET_NO_MESSAGE', "error");
            return;
        }

        let $exclamation = $("#create-ticket-checkbox").is(":checked") ? 1 : 0;
        
        CloseNUI();

        $.post("http://tpz_admin/create_ticket", JSON.stringify({
            title : $title,
            message : $message,
            exclamation: $exclamation,
        }));

    });

});
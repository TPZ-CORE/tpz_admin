$(function () {


    $("#main").on("click", "#users-section-refresh-icon", function () {
        PlayButtonClickSound();

        $("#users-section-search-input").val('');

        $.post('http://tpz_admin/request_users_section', JSON.stringify({}));
    });

    $("#main").on("click", "#users-selected-section-list-dialog-refresh-icon", function () {
        PlayButtonClickSound();

        $("#users-selected-section-list-dialog-search-input").val('');

        $.post('http://tpz_admin/request_users_refresh_items_list', JSON.stringify({}));
    });

    $("#main").on("click", "#users-section-search-button", function () {
        PlayButtonClickSound();

        let $input = $("#users-section-search-input").val();

        $.post('http://tpz_admin/request_users_search_input', JSON.stringify({
            input: $input,
        }));

    });

    $("#main").on("click", "#users-section-users-pages-list-value", function () {
        PlayButtonClickSound();

        let $button = $(this);
        let $selectedPage = $button.attr('page');

        $.post("http://tpz_admin/request_users_page", JSON.stringify({ page: $selectedPage }));
    });
   
    

    $("#main").on("click", "#users-section-users-list-main", function () {
        PlayButtonClickSound();

        let $button = $(this);
        let $selectedSource = $button.attr('user-index');
        let $steamname = $button.attr('steamname');

        $.post("http://tpz_admin/request_selected_user_data", JSON.stringify({ source: $selectedSource, steamname : $steamname }));
    });


    $("#main").on("click", "#users-selected-section-back-icon", function () {
        PlayButtonClickSound();

        CURRENT_SELECTED_BUTTON = "uses-section";
        CURRENT_SELECTED_PAGE = "USERS";

        $(".users-selected-section").hide();
        $(".users-section").show();
    });

    $("#main").on("click", "#users-selected-section-back-title", function () {
        PlayButtonClickSound();

        CURRENT_SELECTED_BUTTON = "uses-section";
        CURRENT_SELECTED_PAGE = "USERS";

        $(".users-selected-section").hide();
        $(".users-section").show();

    });

    $("#main").on("click", "#users-selected-section-actions-list-main", function () {
        PlayButtonClickSound();

        let $button = $(this);
        let $source = $button.attr('source');
        let $action = $button.attr('action');

        $.post("http://tpz_admin/request_perform_selected_user_action", JSON.stringify({ source: $source, action : $action }));
    });

    $("#main").on("click", "#users-selected-section-dialog-cancel-button", function () {
        PlayButtonClickSound();

        $(".users-selected-section-dialog").fadeOut();
    });

    $("#main").on("click", "#users-selected-section-dialog-accept-button", function () {
        PlayButtonClickSound();

        let $type1 = DIALOG_INPUT1_TYPE
        let $type2 = DIALOG_INPUT2_TYPE
        let $type3 = DIALOG_INPUT3_TYPE

        let $input1 = $("#users-selected-section-dialog-input1-input").val();
        let $input2 = $("#users-selected-section-dialog-input2-input").val();
        let $input3 = $("#users-selected-section-dialog-input3-input").val();
        
        console.log(SELECTED_ACTION_TYPE)
        if (SELECTED_ACTION_TYPE != 'ADDWEAPON'){

            if (!validateInput($input1, $type1, "Input 1")) return;
            if (!validateInput($input2, $type2, "Input 2")) return;
            if (!validateInput($input3, $type3, "Input 3")) return;

        }

        $(".users-selected-section-dialog").fadeOut();

        // we prioritize $input2 because it requires
        $input2 = (SELECTED_ACTION_TYPE == 'ADDITEM' || SELECTED_ACTION_TYPE == 'ADDWEAPON') ? $input1 : $input2;
        $input1 = (SELECTED_ACTION_TYPE == 'ADDITEM' || SELECTED_ACTION_TYPE == 'ADDWEAPON') ? DIALOG_ITEM_NAME : $input1;
    
        console.log($input1, $input2)

        $.post("http://tpz_admin/request_perform_selected_user_action2", JSON.stringify({
            source: SELECTED_ACTION_TYPE_SOURCE_ID,
            action: SELECTED_ACTION_TYPE,
            input1: $input1,
            input2: $input2,
            input3: $input3,
        }));

    
    });


    $("#main").on("click", "#users-selected-section-list-dialog-close-button", function () {
        PlayButtonClickSound();

        $(".users-selected-section-list-dialog").fadeOut();
    });


    $("#main").on("click", "#users-selected-section-list-dialog-search-button", function () {
        PlayButtonClickSound();

        let $input = $("#users-selected-section-list-dialog-search-input").val();

        $.post('http://tpz_admin/request_users_search_items_list', JSON.stringify({
            input: $input,
        }));

    });

});
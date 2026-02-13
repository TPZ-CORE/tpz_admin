$(function () {


    $("#main").on("click", "#admin-privacy-section-refresh-icon", function () {
        PlayButtonClickSound();

        $("#admin-privacy-section-search-input").val('');

        $.post('http://tpz_admin/request_admin_history_actions_section', JSON.stringify({}));
    });

    $("#main").on("click", "#admin-privacy-section-search-button", function () {
        PlayButtonClickSound();

        let $input = $("#admin-privacy-section-search-input").val();

        $.post('http://tpz_admin/request_admin_history_actions_section_search_input', JSON.stringify({
            input: $input,
        }));

    });

    $("#main").on("click", "#admin-privacy-section-users-pages-list-value", function () {
        PlayButtonClickSound();

        let $button = $(this);
        let $selectedPage = $button.attr('page');

        $.post("http://tpz_admin/request_admin_history_actions_section_page", JSON.stringify({ page: $selectedPage }));
    });
   


});
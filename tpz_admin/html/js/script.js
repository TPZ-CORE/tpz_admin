
function CloseNUI() {
  $("#create-ticket").fadeOut();
  $("#main").fadeOut();

  HideAll();
  $.post('http://tpz_admin/close', JSON.stringify({}));
}

$(function() {

	window.addEventListener('message', function(event) {
		
    var item = event.data;

		if (item.type == "enable") {

      if (item.enable){
        document.body.style.display = item.enable ? "block" : "none";
      }else {
        $("#main").fadeOut(1000);
        $("#create-ticket").fadeOut(1000);

      }

      if (item.enable){

        if (item.window == 'main') {

          CURRENT_SELECTED_PAGE = 'INFORMATION';

          ClearAllMainButtons();

          // Add 'active' to the clicked button and its icon
          $('#main-information-button').addClass('active').css('color', 'aliceblue');
          var iconId = '#' + $('#main-information-button').attr('id') + '-icon';
          $(iconId).css('color', 'aliceblue');

          $("#main").fadeIn(1000);
          $(".information-section").fadeIn(2000);

          CURRENT_SELECTED_BUTTON = "main-information-button";

        } else if (item.window == 'ticket') {

          $("#create-ticket-title-textarea").val('');
          $("#create-ticket-message-textarea").val('');
          $("#create-ticket-checkbox").prop("checked", false);

          $("#create-ticket").fadeIn(1000);

        }

      }

    } else if (item.action == 'SET_CREATE_TICKET_INFORMATION'){

      $("#create-ticket-textarea-title").text(item.locales['NUI_CREATE_TICKET_TEXTAREA_TITLE']);
      $("#create-ticket-message-textarea-title").text(item.locales['NUI_CREATE_TICKET_TEXTAREA_MESSAGE_TITLE']);

      $("#create-ticket-background-title").text(item.locales['NUI_CREATE_TICKET_TITLE']);
      $("#create-ticket-checkbox-title").text(item.locales['NUI_CREATE_TICKET_CHECKBOX_TITLE']);
      $("#create-ticket-send-button").text(item.locales['NUI_CREATE_TICKET_SEND_BUTTON']);

    } else if (item.action == "SET_INFORMATION") {

      $("#main-information-button").text(item.locales['NUI_INFORMATION_BUTTON']);
      $("#main-users-button").text(item.locales['NUI_USERS_BUTTON']);
      $("#main-user-button").text(item.locales['NUI_USER_BUTTON']);
      $("#main-tickets-button").text(item.locales['NUI_TICKETS_BUTTON']);
      $("#main-bans-button").text(item.locales['NUI_BANS_BUTTON']);
      $("#main-history-button").text(item.locales['NUI_ADMIN_ACTIONS_BUTTON']);

      $("#information-section-title").text(item.locales['NUI_INFORMATION_TITLE']);
      $("#information-section-description").html(item.locales['NUI_INFORMATION_DESCRIPTION']);

      $("#users-section-title").text(item.locales['NUI_USERS_BUTTON']);
      $("#users-section-users-list-id-title").text(item.locales['NUI_USERS_PLAYERS_ID']);
      $("#users-section-users-list-steam-title").text(item.locales['NUI_USERS_PLAYERS_STEAM_NAME']);
      $("#users-section-users-list-fullname-title").text(item.locales['NUI_USERS_PLAYERS_CHARACTER_NAME']);
      $("#users-section-users-list-job-title").text(item.locales['NUI_USERS_PLAYERS_JOB']);

      $("#users-section-search-button").text(item.locales['NUI_USERS_SEARCH_BUTTON']);
      $("#users-selected-section-actions-title").text(item.locales['NUI_USERS_SELECTED_ACTIONS_TITLE']);
      $("#users-selected-section-back-title").text(item.locales['NUI_USERS_SELECTED_BACK_TITLE']);
      $("#users-selected-section-inventory-title").text(item.locales['NUI_USERS_SELECTED_INVENTORY_TITLE']);
      $("#users-selected-section-info-title").text(item.locales['NUI_USERS_SELECTED_INFO_TITLE']);

      $("#users-selected-section-dialog-accept-button").text(item.locales['NUI_DIALOG_ACCEPT_BUTTON']);
      $("#users-selected-section-dialog-cancel-button").text(item.locales['NUI_DIALOG_CANCEL_BUTTON']);

      $("#users-selected-section-list-dialog-search-button").text(item.locales['NUI_DIALOG_LIST_SEARCH']);

      $("#admin-privacy-section-title").text(item.locales['NUI_ADMIN_PRIVACY_TITLE']);
      $("#admin-privacy-section-search-button").text(item.locales['NUI_ADMIN_PRIVACY_SEARCH_BUTTON']);

      $("#admin-privacy-section-users-list-id-title").text(item.locales['NUI_ADMIN_PRIVACY_ID']);
      $("#admin-privacy-section-users-list-steamhex-title").text(item.locales['NUI_ADMIN_PRIVACY_STEAMHEX']);
      $("#admin-privacy-section-users-list-steamname-title").text(item.locales['NUI_ADMIN_PRIVACY_STEAM_NAME']);
      $("#admin-privacy-section-users-list-date-title").text(item.locales['NUI_ADMIN_PRIVACY_DATE']);

      $("#bans-section-title").text(item.locales['NUI_BANS_TITLE']);
      $("#bans-section-search-button").text(item.locales['NUI_BANS_SEARCH_BUTTON']);

      $("#bans-section-users-list-id-title").text(item.locales['NUI_BANS_ID']);
      $("#bans-section-users-list-steamhex-title").text(item.locales['NUI_BANS_STEAMHEX']);
      $("#bans-section-users-list-steamname-title").text(item.locales['NUI_BANS_STEAM_NAME']);
      $("#bans-section-users-list-warnings-title").text(item.locales['NUI_BANS_WARNINGS']);

      $("#bans-section-dialog-description").text(item.locales['NUI_BANS_DIALOG_DESCRIPTION']);
      $("#bans-section-dialog-unban-button").text(item.locales['NUI_BANS_DIALOG_UNBAN_BUTTON']);
      $("#bans-section-dialog-cancel-button").text(item.locales['NUI_BANS_DIALOG_CANCEL_BUTTON']);

      $("#tickets-section-title").text(item.locales['NUI_TICKETS_TITLE']);

      $("#tickets-section-search-button").text(item.locales['NUI_TICKETS_SEARCH_BUTTON']);

      $("#tickets-section-users-list-id-title").text(item.locales['NUI_TICKETS_ID']);
      $("#tickets-section-users-list-fullname-title").text(item.locales['NUI_TICKETS_FULLNAME']);
      $("#tickets-section-users-list-steamname-title").text(item.locales['NUI_TICKETS_STEAM_NAME']);
      $("#tickets-section-users-list-date-title").text(item.locales['NUI_TICKETS_DATE']);

      $("#tickets-section-dialog-description").text(item.locales['NUI_TICKETS_DIALOG_DESCRIPTION']);

      $("#tickets-section-dialog-delete-button").text(item.locales['NUI_TICKETS_DIALOG_DELETE_BUTTON']);
      $("#tickets-section-dialog-cancel-button").text(item.locales['NUI_TICKETS_DIALOG_CANCEL_BUTTON']);

    } else if (item.action == "SELECTED_WINDOW_SECTION") {
      
      if (CURRENT_SELECTED_BUTTON != item.window) {
        HideAll();
      }

      item.hasPermission ? $("." + item.window).show() : $("." + item.window).hide();

      if (item.hasPermission){
        CURRENT_SELECTED_BUTTON = item.window;
      }

      if (!item.hasPermission){

        $("." + CURRENT_SELECTED_BUTTON).show();

        RequestNotification('NUI_NO_PERMISSIONS', "error");
        ClearAllMainButtons();

        SELECTED_PAGE = CURRENT_SELECTED_PAGE;
        SELECTED_BUTTON = CURRENT_SELECTED_BUTTON;

        $('#main-' + CURRENT_SELECTED_PAGE.toLowerCase() + "-button").addClass('active').css('color', 'aliceblue');
        $('#main-' + CURRENT_SELECTED_PAGE.toLowerCase() + "-button-icon").css('color', 'aliceblue');
        return;
      }

      $('#' + SELECTED_BUTTON).addClass('active').css('color', 'aliceblue');
      var iconId = '#' + $('#' + SELECTED_BUTTON).attr('id') + '-icon';
      $(iconId).css('color', 'aliceblue');

      CURRENT_SELECTED_PAGE = SELECTED_PAGE;
      CURRENT_SELECTED_BUTTON = item.window;

      if (item.window == 'users-section'){
        $("#users-section-users-list-count").text(item.locales['NUI_USERS_PLAYERS_COUNT'] + " " + item.current_players + "/" + item.max_players);
      
        // Load pages based on online players list (MAX 40 pages)
        let pages    = item.total_pages;
        let selected = item.selected_page;

        if (pages > 1) {

          $.each(new Array(pages + 1), function (value) {
            if (value != 0) {
              var opacity = selected == value ? '0.7' : null;
              $("#users-section-users-pages-list").append(`<div page = "` + value + `" id="users-section-users-pages-list-value" style = "opacity: ` + opacity + `;" >` + value + `</div>`);
            }
          });

        } else {
          $("#users-section-users-pages-list").append(`<div page = "1" id="users-section-users-pages-list-value" style = "opacity: 0.7;" >1</div>`);
        }


      }else if (item.window == 'users-selected-section'){

        let res = item.result;

        SELECTED_PAGE = 'SELECTED_USERS';
        CURRENT_SELECTED_PAGE = SELECTED_PAGE;

        $(".users-selected-section-dialog").hide();
        $(".users-selected-section-list-dialog").hide();

        $("#users-selected-section-title").text(res.steamname + " - (Steam Hex: " + res.identifier + " | Char ID: " + res.charIdentifier + ")");

        $("#users-selected-section-info-desc-title").html(item.description);

      }else if (item.window == 'admin-privacy-section') {

        // Load pages based on online players list (MAX 40 pages)
        let pages = item.total_pages;
        let selected = item.selected_page;

        if (pages > 1) {

          $.each(new Array(pages + 1), function (value) {
            if (value != 0) {
              var opacity = selected == value ? '0.7' : null;
              $("#admin-privacy-section-users-pages-list").append(`<div page = "` + value + `" id="admin-privacy-section-users-pages-list-value" style = "opacity: ` + opacity + `;" >` + value + `</div>`);
            }
          });

        } else {
          $("#admin-privacy-section-users-pages-list").append(`<div page = "1" id="admin-privacy-section-users-pages-list-value" style = "opacity: 0.7;" >1</div>`);
        }


      } else if (item.window == 'bans-section') {
        $(".bans-section-dialog").hide();

        // Load pages based on online players list (MAX 40 pages)
        let pages = item.total_pages;
        let selected = item.selected_page;

        if (pages > 1) {

          $.each(new Array(pages + 1), function (value) {
            if (value != 0) {
              var opacity = selected == value ? '0.7' : null;
              $("#bans-section-users-pages-list").append(`<div page = "` + value + `" id="bans-section-users-pages-list-value" style = "opacity: ` + opacity + `;" >` + value + `</div>`);
            }
          });

        } else {
          $("#bans-section-users-pages-list").append(`<div page = "1" id="bans-section-users-pages-list-value" style = "opacity: 0.7;" >1</div>`);
        }

      } else if (item.window == 'tickets-section') {
        $(".tickets-section-dialog").hide();

        // Load pages based on online players list (MAX 40 pages)
        let pages = item.total_pages;
        let selected = item.selected_page;

        if (pages > 1) {

          $.each(new Array(pages + 1), function (value) {
            if (value != 0) {
              var opacity = selected == value ? '0.7' : null;
              $("#tickets-section-users-pages-list").append(`<div page = "` + value + `" id="tickets-section-users-pages-list-value" style = "opacity: ` + opacity + `;" >` + value + `</div>`);
            }
          });

        } else {
          $("#tickets-section-users-pages-list").append(`<div page = "1" id="tickets-section-users-pages-list-value" style = "opacity: 0.7;" >1</div>`);
        }

      }
  
    } else if (item.action == 'RESET_SELECTED_USERS_LIST') {

      $("#users-selected-section-actions-list").html('');
      $("#users-selected-section-inventory-list").html('');

    } else if (item.action == 'RESET_USERS_LIST') {

      $("#users-section-users-list").html('');
      $("#users-section-users-pages-list").html('');

    } else if (item.action == 'RESET_SELECTED_USER_ITEMS_WEAPONS_LIST') {

      $("#users-selected-section-list-dialog-list").html('');


    } else if (item.action == 'RESET_ADMIN_PRIVACY_LIST') {

      $("#admin-privacy-section-users-list").html('');
      $("#admin-privacy-section-users-pages-list").html('');

    } else if (item.action == 'RESET_BANS_LIST') {

      $("#bans-section-users-list").html('');
      $("#bans-section-users-pages-list").html('');

    } else if (item.action == 'RESET_TICKETS_LIST') {

      $("#tickets-section-users-list").html('');
      $("#tickets-section-users-pages-list").html('');

    } else if (item.action == 'ADMIN_PRIVACY_LIST_INSERT'){

      let res = item.result;

      $("#admin-privacy-section-users-list").append(
        `<div id="admin-privacy-section-users-list-main" >` +
        `<div id="admin-privacy-section-users-list-id" >#` + res.count + `</div>` +
        `<div id="admin-privacy-section-users-list-steamhex" >` + res.identifier + `</div>` +
        `<div id="admin-privacy-section-users-list-steamname" >` + res.steamname + `</div>` +
        `<div id="admin-privacy-section-users-list-date" >` + res.date + `</div>` +
        `<div id="admin-privacy-section-users-list-action" >- ` + res.action + `</div>` +
        `</div> <div> &nbsp; </div>`
      );

    } else if (item.action == 'BANS_LIST_INSERT') {

      let res = item.result;

      $("#bans-section-users-list").append(
        `<div id="bans-section-users-list-main" identifier = "${res.identifier}" steamname = "${res.steamname}" >` +
        `<div id="bans-section-users-list-id" >#` + res.count + `</div>` +
        `<div id="bans-section-users-list-steamhex" >` + res.identifier + `</div>` +
        `<div id="bans-section-users-list-steamname" >` + res.steamname + `</div>` +
        `<div id="bans-section-users-list-warnings" >` + res.warnings + `</div>` +
        `<div id="bans-section-users-list-reason-title" >` + res.banned_reason_title + `</div>` +
        `<div id="bans-section-users-list-reason">- ` + res.banned_reason + `</div>` +
        `<div id="bans-section-users-list-remaining">` + res.remaining_time + `</div>` +
        `</div> <div> &nbsp; </div>`
      );

    } else if (item.action == 'TICKETS_LIST_INSERT') {

      let res = item.result;

      let exclamation = res.exclamation == 1 ? `<div id="tickets-section-users-list-exclamation" class="fa-solid fa-exclamation" ></div>` : "";

      let baseHeight = 5.5; // vw
      let extraHeight = 0;

      if (res.message.length > 260) {
        let extraBlocks = Math.ceil((res.message.length - 260) / 260);
        extraHeight = extraBlocks * 2.5;
      }

      let finalHeight = baseHeight + extraHeight;
      
      $("#tickets-section-users-list").append(
        `<div id="tickets-section-users-list-main" steamname = "${res.steamname}" count ="${res.id}" timestamp ="${res.timestamp}" style="height:${finalHeight}vw;">` +
        exclamation +
        `<div id="tickets-section-users-list-id" >#` + res.id + `</div>` +
        `<div id="tickets-section-users-list-steamname" >` + res.steamname + `</div>` +
        `<div id="tickets-section-users-list-fullname" >` + res.fullname + `</div>` +
        `<div id="tickets-section-users-list-date" >` + res.date + `</div>` +
        `<div id="tickets-section-users-list-description-title" >` + res.description_title + `</div>` +
        `<div id="tickets-section-users-list-title">` + res.title + `</div>` +
        `<div id="tickets-section-users-list-description">- ` + res.message + `</div>` +
        `</div> <div> &nbsp; </div>`
      );

    } else if (item.action == 'USERS_LIST_INSERT'){

      let res = item.result;

      $("#users-section-users-list").append(
        `<div id="users-section-users-list-main" user-index = "${res.source}" steamname = "${res.steamname}" >` +
        `<div id="users-section-users-list-id" >#` + res.source + `</div>` +
        `<div id="users-section-users-list-steam" >` + res.steamname + `</div>` +
        `<div id="users-section-users-list-fullname" >` + res.username + `</div>` +
        `<div id="users-section-users-list-job" >` + res.job + `</div>` +
        `</div> <div> &nbsp; </div>`
      );

    } else if (item.action == 'USERS_SELECTED_LIST_INSERT'){
      let res = item.result;

      $("#users-selected-section-actions-list").append(
        `<div id="users-selected-section-actions-list-main" source = "${item.source}" action = "${res.ActionType}" >` +
        `<div id="users-selected-section-actions-list-label" >` + res.Label + `</div>` +
        `</div> <div> &nbsp; </div>`
      );

    } else if (item.action == 'USERS_SELECTED_LIST_INSERT_INVENTORY') {

      let prod_item = item.result;

      if (prod_item.type != "weapon") {

        if (prod_item.stackable == 0) {

          if (prod_item.durability != -1) {
            $("#users-selected-section-inventory-list").append(
              `<div id = "primary_content-` + prod_item.item + "-" + prod_item.itemId + `" class = "item-` + prod_item.item + "-" + prod_item.itemId + `"> ` +
              `<img id="users-selected-section-inventory-list-image" src = "` + getItemIMG(prod_item.item) + `"></img>` +
              `<div id="users-selected-section-inventory-list-count" style = 'background-color: #9e7a4a; color: snow; font-weight: 100; font-size: 0.5vw; '>` + Number(prod_item.durability) + `%</div>` +
              `<div class = "item-weight-` + prod_item.item + "-" + prod_item.itemId + `" id="users-selected-section-inventory-list-weight">` + prod_item.weight + `kg</div>` +
              `</div>`
            );
          } else {
            $("#users-selected-section-inventory-list").append(
              `<div id = "primary_content-` + prod_item.item + "-" + prod_item.itemId + `" class = "item-` + prod_item.item + "-" + prod_item.itemId + `"> ` +
              `<img id="users-selected-section-inventory-list-image" src = "` + getItemIMG(prod_item.item) + `"></img>` +
              `<div class = "item-weight-` + prod_item.item + "-" + prod_item.itemId + `" id="users-selected-section-inventory-list-weight">` + prod_item.weight + `kg</div>` +
              `</div>`
            );
          }

        } else {

          let weight = prod_item.weight * prod_item.quantity
          weight = weight.toFixed(2);

          $("#users-selected-section-inventory-list").append(
            `<div id = "primary_content-` + prod_item.item + "-" + prod_item.itemId + `" class = "item-` + prod_item.item + "-" + prod_item.itemId + `"> ` +
            `<img id="users-selected-section-inventory-list-image" src = "` + getItemIMG(prod_item.item) + `"></img>` +
            `<div class = "item-count-` + prod_item.item + "-" + prod_item.itemId + `" id="users-selected-section-inventory-list-count">` + prod_item.quantity + `</div>` +
            `<div class = "item-weight-` + prod_item.item + "-" + prod_item.itemId + `" id="users-selected-section-inventory-list-weight">` + weight + `kg</div>` +
            `</div>`
          );
        }

      } else {

        var durability = prod_item.durability

        if (durability != -1) {
          $("#users-selected-section-inventory-list").append(
            `<div id = "primary_content-` + prod_item.item + "-" + prod_item.itemId + `" class = "item-` + prod_item.item + "-" + prod_item.itemId + `"> ` +
            `<img id="users-selected-section-inventory-list-image" src = "` + getItemIMG(prod_item.item) + `"></img>` +
            `<div id="users-selected-section-inventory-list-count" style = 'background-color: brown; color: snow; font-weight: 100; font-size: 0.5vw; '>` + durability + `%</div>` +
            `<div class = "item-weight-` + prod_item.item + "-" + prod_item.itemId + `" id="users-selected-section-inventory-list-weight">` + prod_item.weight + `kg</div>` +
            `</div>`
          );

        } else {
          $("#users-selected-section-inventory-list").append(
            `<div id = "primary_content-` + prod_item.item + "-" + prod_item.itemId + `" class = "item-` + prod_item.item + "-" + prod_item.itemId + `"> ` +
            `<img id="users-selected-section-inventory-list-image" src = "` + getItemIMG(prod_item.item) + `"></img>` +
            `<div class = "item-weight-` + prod_item.item + "-" + prod_item.itemId + `" id="users-selected-section-inventory-list-weight">` + prod_item.weight + `kg</div>` +
            `</div>`
          );
        }
      }

    } else if (item.action == 'INSERT_DIALOG_ITEMS_LIST'){

      let prod_item = item.result;

      let backgroundImage = prod_item.backgroundImageName != null ? prod_item.backgroundImageName : prod_item.item;
      
      $("#users-selected-section-list-dialog-list").append(
        `<div class = "dialog-item-${prod_item.item}" item = "${prod_item.item}" label = "${prod_item.label}" > ` +
        `<img id="users-selected-section-list-dialog-list-image" src = "` + getItemIMG(backgroundImage) + `"></img>` +
        `<div id="users-selected-section-list-dialog-list-weight">` + prod_item.weight + `kg</div>` +
        `</div>`
      );


    } else if (item.action == 'OPEN_DIALOG_INPUT') {

      DIALOG_ITEM_NAME = item.item; // defines if the dialog is for weapons or items (if not null)

      SELECTED_ACTION_TYPE_SOURCE_ID = item.source;
      SELECTED_ACTION_TYPE = item.action_type;
      DIALOG_INPUT1_TYPE = 'N/A'
      DIALOG_INPUT2_TYPE = 'N/A'
      DIALOG_INPUT3_TYPE = 'N/A'

      $("#users-selected-section-dialog-input1-input").hide();
      $("#users-selected-section-dialog-input2-input").hide();
      $("#users-selected-section-dialog-input3-input").hide();
      $("#users-selected-section-dialog-input1-description").text("");
      $("#users-selected-section-dialog-input2-description").text("");
      $("#users-selected-section-dialog-input3-description").text("");
      $("#users-selected-section-dialog-input1-input").val("");
      $("#users-selected-section-dialog-input2-input").val("");
      $("#users-selected-section-dialog-input3-input").val("");

      $("#users-selected-section-dialog-title").text(item.title);

      if (item.input1_description){
        $("#users-selected-section-dialog-input1-description").text(item.input1_description);

        $('#users-selected-section-dialog-input1-input').attr('placeholder', item.placeholder1);
        $("#users-selected-section-dialog-input1-input").show();

        DIALOG_INPUT1_TYPE = item.input1_type;
      }

      if (item.input2_description) {
        $("#users-selected-section-dialog-input2-description").text(item.input2_description);
        $('#users-selected-section-dialog-input2-input').attr('placeholder', item.placeholder2);
        $("#users-selected-section-dialog-input2-input").show();

        DIALOG_INPUT2_TYPE = item.input2_type;
      }

      if (item.input3_description) {
        $("#users-selected-section-dialog-input3-description").text(item.input3_description);
        $('#users-selected-section-dialog-input3-input').attr('placeholder', item.placeholder3);
        $("#users-selected-section-dialog-input3-input").show();

        DIALOG_INPUT3_TYPE = item.input3_type;
      }

      $(".users-selected-section-dialog").fadeIn();


    } else if (item.action == 'OPEN_DIALOG_ITEMS_WEAPONS_LIST') {

      SELECTED_ACTION_TYPE_SOURCE_ID = item.source;
      SELECTED_ACTION_TYPE = item.action_type;

      $("#users-selected-section-list-dialog-search-input").val('');

      $("#users-selected-section-list-dialog-title").text(item.title);
      $("#users-selected-section-list-dialog-description").text(item.description);

      $(".users-selected-section-list-dialog").fadeIn();

    } else if (item.action == "sendNotification") {
      let prod_notify = item.notification_data;
      SendNotification(prod_notify.message, prod_notify.color, prod_notify.duration);

    } else if (item.action == "close") {
      CloseNUI();
    }

  });
  
  $("body").on("keyup", function (key) { if (key.which == 27) { CloseNUI(); } });

  $('#main-information-button, #main-users-button, #main-user-button, #main-tickets-button, #main-bans-button, #main-history-button').hover(
    function () { // Mouse enter
      if (!$(this).hasClass('active')) {
        $(this).css('color', 'aliceblue');
        var iconId = '#' + $(this).attr('id') + '-icon';
        $(iconId).css('color', 'aliceblue');
      }
    },
    function () { // Mouse leave
      if (!$(this).hasClass('active')) {
        $(this).css('color', '');
        var iconId = '#' + $(this).attr('id') + '-icon';
        $(iconId).css('color', '');
      }
    }
  );

  function ClearAllMainButtons() {
    $('#main-information-button, #main-users-button, #main-user-button, #main-tickets-button, #main-bans-button, #main-history-button')
      .each(function () {
        // Remove 'active' class
        $(this).removeClass('active');

        // Reset button color
        $(this).css('color', '');

        // Reset corresponding icon color
        var iconId = '#' + $(this).attr('id') + '-icon';
        $(iconId).css('color', '');
      });
  }

  // Hovering actions for go back option on player list because we want (2) elements to change their css.
  // Function to enforce type
  function enforceType(value, type) {

    switch (type) {
      case 'STRING':
        return value.replace(/[^a-zA-Z\s]/g, '');
      case 'INT':
        return value.replace(/\D/g, '');
      case 'FLOAT':
        return value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
      case '-INT':
        value = value.replace(/[^0-9-]/g, '');
        if (value.indexOf('-') > 0) value = value.replace('-', '');
        return value;
      default:
        return value;
    }
  }

  $('#users-selected-section-dialog-input1-input').on('input', function () {
    this.value = enforceType(this.value, DIALOG_INPUT1_TYPE);
  });

  // Input 2
  $('#users-selected-section-dialog-input2-input').on('input', function () {
    this.value = enforceType(this.value, DIALOG_INPUT2_TYPE);
  });

  // Input 3
  $('#users-selected-section-dialog-input3-input').on('input', function () {
    this.value = enforceType(this.value, DIALOG_INPUT3_TYPE);
  });

  $(document).on("mouseenter", "[class^='dialog-item-']", function () {
    let item = $(this).attr("item");
    let label = $(this).attr("label");
    $("#users-selected-section-list-dialog-list-hovered-item-name").text(item);
    $("#users-selected-section-list-dialog-list-hovered-name").text(label);
  });

  $(document).on("mouseleave", "[class^='dialog-item-']", function () {
    $("#users-selected-section-list-dialog-list-hovered-item-name").text("");
    $("#users-selected-section-list-dialog-list-hovered-name").text("");
  });

  /* ------------------------------------------------
  ------------------------------------------------ */ 

  $("#main").on("click", "#main-close-button", function () {
    PlayButtonClickSound();
    CloseNUI();
  });

  $("#main").on("click", "[id^='main-'][id$='-button']", function () {
    PlayButtonClickSound();

    // Extract the page name (e.g. 'information', 'upgrades', etc.)
    const buttonId = $(this).attr('id');
    const page = buttonId.replace('main-', '').replace('-button', '').toUpperCase();

    SELECTED_PAGE = page;

    // Reset styles
    ClearAllMainButtons();

    // Highlight clicked button + icon
    $(this).addClass('active').css('color', 'aliceblue');
    $('#' + buttonId + '-icon').css('color', 'aliceblue');

    SELECTED_BUTTON = buttonId;

    // Optional: page-specific logic
    switch (page) {

      case 'INFORMATION':
        HideAll();
        ClearAllMainButtons();

        $(".information-section").show();

        CURRENT_SELECTED_BUTTON = "information-section";

        SELECTED_PAGE = "INFORMATION";
        SELECTED_BUTTON = "main-information-button";

        $("#main-information-button").addClass('active').css('color', 'aliceblue');
        $("#main-information-button-icon").css('color', 'aliceblue');

        CURRENT_SELECTED_PAGE = "information";
        CURRENT_SELECTED_BUTTON = "main-information-button";

        break;

      case 'USERS':
        $("#users-section-search-input").val('');
        $.post('http://tpz_admin/request_users_section', JSON.stringify({}));
        break;

      case 'HISTORY':
        $("#admin-privacy-section-search-input").val('');
        $.post('http://tpz_admin/request_admin_history_actions_section', JSON.stringify({}));
        break;

      case 'BANS':
        $("#bans-section-search-input").val('');
        $.post('http://tpz_admin/request_bans_section', JSON.stringify({}));
        break;

      case 'TICKETS':
        $("#tickets-section-search-input").val('');
        $.post('http://tpz_admin/request_tickets_section', JSON.stringify({}));
        break;
    }
  });

  $(document).on("click", "[class^='dialog-item-']", function () {
    PlayButtonClickSound();

    let $item = $(this).attr("item");
    let $label = $(this).attr("label");

    $.post("http://tpz_admin/request_perform_selected_user_action3", JSON.stringify({
      source: SELECTED_ACTION_TYPE_SOURCE_ID,
      item : $item,
      label : $label,
    }));

  });

});

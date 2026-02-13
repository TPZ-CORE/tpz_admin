
let HAS_COOLDOWN = false;
let CURRENT_SELECTED_PAGE = null;
let SELECTED_PAGE = null;
let CURRENT_SELECTED_BUTTON = null;
let SELECTED_BUTTON = null;

let DIALOG_INPUT1_TYPE = 'N/A'
let DIALOG_INPUT2_TYPE = 'N/A'
let DIALOG_INPUT3_TYPE = 'N/A'

let SELECTED_ACTION_TYPE = null;
let SELECTED_ACTION_TYPE_SOURCE_ID = 0;

let DIALOG_ITEM_NAME = null;

let SELECTED_BANNED_USER = null;
let SELECTED_BANNED_USER_STEAM = null;

let SELECTED_TICKET_TIMESTAMP = null;

document.addEventListener("DOMContentLoaded", function () {

  $("#create-ticket").fadeOut();
  $("#main").fadeOut();

  displayPage("information-section", "visible");
  $(".information-section").fadeOut();

  displayPage("users-section", "visible");
  $(".users-section").fadeOut();

  displayPage("users-selected-section", "visible");
  $(".users-selected-section").fadeOut();

  displayPage("admin-privacy-section", "visible");
  $(".admin-privacy-section").fadeOut();

  displayPage("bans-section", "visible");
  $(".bans-section").fadeOut();

  displayPage("tickets-section", "visible");
  $(".tickets-section").fadeOut();

  displayPage("notification", "visible");
  $(".notification").fadeOut();

});

function PlayButtonClickSound() {
  var audio = new Audio('./audio/button_click.wav');
  audio.volume = 0.2;
  audio.play();
}

function displayPage(page, cb){
  document.getElementsByClassName(page)[0].style.visibility = cb;

  [].forEach.call(document.querySelectorAll('.' + page), function (el) {
    el.style.visibility = cb;
  });
}

function ResetCooldown(){ setTimeout(function () { HAS_COOLDOWN = false; }, 500); }


function HideAll(){
  $(".information-section").hide();
  $(".users-section").hide();
  $(".users-selected-section").hide();
  $(".admin-privacy-section").hide();
  $(".bans-section").hide();
  $(".tickets-section").fadeOut();
}

let notificationTimeout; // store timeout globally

function SendNotification(text, color, cooldown) {

  $("#notification_message").text("");
  $("#notification_message").fadeOut();
  
  // Default cooldown
  cooldown = (cooldown == null || cooldown === 0 || cooldown === undefined) ? 4000 : cooldown * 1000;

  // Clear any previous timeout
  if (notificationTimeout) {
    clearTimeout(notificationTimeout);
    notificationTimeout = null;
  }

  // Update message
  $("#notification_message").text(text);
  $("#notification_message").css("color", color);
  $("#notification_message").fadeIn();

  // Set new timeout
  notificationTimeout = setTimeout(function () {
    $("#notification_message").text("");
    $("#notification_message").fadeOut();
    notificationTimeout = null; // clear reference
  }, cooldown);
}

function RequestNotification(text, type) {
  $.post('http://tpz_admin/requestNotification', JSON.stringify({ message: text, messageType: type }));
}

function getItemIMG(item) {
  return 'nui://tpz_inventory/html/img/items/' + item + '.png';
}

function isInt(val) {
  return /^-?\d+$/.test(val);
}

function isNegativeInt(val) {
  return /^-?\d+$/.test(val); // same regex, negatives allowed but not required
}

function isFloat(val) {
  return /^-?\d+(\.\d+)?$/.test(val);
}

function validateInput(value, type, label) {

  // N/A → optional
  if (type === "N/A") {
    return true;
  }

  // Required for all other types
  if (value === null || value === "") {
    console.log(label + " is required.");
    return false;
  }

  switch (type) {
    case "INT":
      if (!isInt(value) || value.includes("-")) {
        console.log(label + " must be a positive integer.");
        return false;
      }
      break;

    case "-INT":
      if (!isNegativeInt(value)) {
        console.log(label + " must be an integer (negative allowed).");
        return false;
      }
      break;

    case "FLOAT":
      if (!isFloat(value)) {
        console.log(label + " must be an integer or float (e.g. 50 or 50.0).");
        return false;
      }
      break;

    case "STRING":
      // Everything accepted → no validation
      break;

    default:
      console.log("Unknown type for " + label);
      return false;
  }

  return true;
}
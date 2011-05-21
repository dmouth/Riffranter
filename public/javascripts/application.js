jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});          

// ================
// = Follow Users =
// ================
$(function(){
  $(".follow-user-link").live("click", function(){
    $.post($(this).attr("href"), {follow_id: $(this).data("follow-id")});
    return false;
  });

  $(".unfollow-user-link").live("click", function(){
    $.post($(this).attr("href"), {follow_id: $(this).data("follow-id")});
    return false;
  });
});   

// ===================
// = Follow Personas =
// ===================
$(function(){
  $(".follow-persona-link").live("click", function(){
    $.post($(this).attr("href"), {current_user_id: $(this).data("current-user-id")});
    return false;
  });

  $(".unfollow-persona-link").live("click", function(){
    $.post($(this).attr("href"), {current_user_id: $(this).data("current-user-id")});
    return false;
  });
});   

// ===============================================
// = Generic persona rant widget (with selector) =
// ===============================================
$(function(){
  $("#persona-rant-widget select").live("change", function(){
    $.get("/prw/update_widget", {id: $(this).val()})
  });

  $("#persona-rant-widget .submit-link").live("click", function(){
    $.post("/persona_rant_widget/new_persona_rant", {id: $(this).data("current-user-id"), persona_id: $(this).data("persona-id"), text: $("#persona-rant-widget textarea").val()});
    return false;
  });
})

// =======================================
// = Rant widget, on persona detail page =
// =======================================
$(function(){
  $("#rant-widget select").live("change", function(){
    $.get("/prw/update_widget", {id: $(this).val()})
  });

  $("#rant-widget .submit-link").live("click", function(){
    $.post("/persona_rant_widget/new_rant", {id: $(this).data("current-user-id"), persona_id: $(this).data("persona-id"), text: $("#rant-widget textarea").val()});
    return false;
  });
})

// =========================
// = General site behavior =
// =========================
$(function(){
  $(".flash-message").fadeOut(2000);
})   

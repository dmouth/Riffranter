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

// =========================
// = General site behavior =
// =========================
$(function(){
  $(".flash-message").fadeOut(2000);
})   

jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});          

// ================
// = Follow Users =
// ================
$(function(){
  $(".follow-user-link").click(function(){
    $.post("/users/" + $(this).data("current-user-id") + "/follow", {follow_id: $(this).data("follow-id")});
    return false;
  });
});   


$(function(){
  $(".flash-message").fadeOut(2000);
})   

// ==============
// = Tabs stuff =
// ==============
// $(function() {
//   $("#tabs-page").tabs({
//     select: function(event, ui){
//       var url = $.data(ui.tab, 'load.tabs');
//       if(url){
//         location.href = url;
//         return false;
//       },
//       load: function(){
//         return true;
//       }
//     }  
//   }); 
// });
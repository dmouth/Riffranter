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
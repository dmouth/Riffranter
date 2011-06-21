$(function() {
  setTimeout(getLatestRants, 60000);
});

function getLatestRants(){
  if($("#rant-container").hasClass("latest")){
    newestId = $("#rant-container.latest .rant-partial:first-child").data("rant-id") ;
    $.get("/rants/latest", {last_id: newestId});
    setTimeout(getLatestRants, 60000);
  }
}

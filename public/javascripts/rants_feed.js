$timer = null;

$(function() {
  setTimeout(getLatestRants, 60000);
});         

function stopTimer(){
  if(timer != null){
    clearTimeout($timer);
  }
}

function getLatestRants(){
  if($("#rant-container").hasClass("latest")){
    newestId = $("#rant-container.latest .rant-partial:first-child").data("rant-id") ;
    $.get("/rants/latest", {last_id: newestId});
    $timer = setTimeout(getLatestRants, 60000);   
    
  }
  if($("#rant-container").hasClass("subscriber")){
    newestId = $("#rant-container.subscriber .rant-partial:first-child").data("rant-id") ;
    $.get("/rants/subscriber", {last_id: newestId});
    $timer = setTimeout(getLatestRants, 60000);
  }    
}
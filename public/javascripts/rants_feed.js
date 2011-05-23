$(function(){
  setTimeout(getLatestRants, 10000);
})

function getLatestRants(){ 
  newestId = $("#latest-rants ..home-page-rant:first-child").data("rant-id") ;
  $.get("/rants/latest", {last_id: newestId});
  setTimeout(getLatestRants, 10000);
}
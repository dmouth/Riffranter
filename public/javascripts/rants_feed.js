$(function() {
  setTimeout(getLatestRants, 90000);
});

function getLatestRants(){
  newestId = $("#latest-rants .rant-partial:first-child").data("rant-id") ;
  $.get("/rants/latest", {last_id: newestId});
  setTimeout(getLatestRants, 90000);
}

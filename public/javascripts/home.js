// ========================
// = Rant type tabs stuff =
// ========================

$(function(){
  $("#latest-rants a").live("click", function(){
    $.get("/home/latest_rants");
    return false;
  });
  $("#hot-rants a").live("click", function(){
    $.get("/home/hot_rants");
    return false;
  });
  $("#subscriber-rants a").live("click", function(){
    $.get("/home/subscriber_rants");
    return false;
  });
});
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

// ================================
// = More link at bottom of rants =
// ================================

$(function(){
  $("#more-rants.latest").live("click", function(){
    lastId = $("#rant-container.latest .rant-partial:last-child").data("rant-id") ;
    $.get("/rants/more_latest", {last_id: lastId});
    return false;
  });
  $("#more-rants.subscriber").live("click", function(){
    lastId = $("#rant-container.subscriber .rant-partial:last-child").data("rant-id") ;
    $.get("/rants/more_subscriber", {last_id: lastId});
    return false;
  });
});
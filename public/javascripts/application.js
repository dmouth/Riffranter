$(function(){
  $(".flash-message").fadeOut(2000);
})   

// ==============
// = Tabs stuff =
// ==============
$(document).ready(function() {
	$("#tabs-page").tabs();

	$("#tabs a").click(function(){
    $("#tabs li").removeClass("active");
    $(this).parent().addClass("active");
	})
});
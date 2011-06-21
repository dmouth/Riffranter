// =======================================================
// = Set up all axax calls to be .js -- saves on typing. =
// =======================================================
jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});       

// =============================================
// = Hover-appearing controls on rants partial =
// =============================================              
$(function(){
	$(".rant-partial .shadow-box").live("mouseover", function(){
		$(this).children(".rant-controls").removeClass("controlsOff").addClass("controlsOn");    
	});
	$(".rant-partial .shadow-box").live("mouseout", function(){
		$(this).children(".rant-controls").removeClass("controlsOn").addClass("controlsOff");
	})
})     

// ====================================================================
// = Override delete link on partial to stay at the originating page. =
// ====================================================================
$(function(){
  $(".delete-rant-link").live("click", function(){
    if(confirm("Are you sure?")){
      $.post($(this).attr("href"), {method: "DELETE"});
      // window.location.href = $(this).data("return-url");
    }
    return false;
  });
});

// ============================
// = Rating control for rants =
// ============================
$(function(){
  $(".rating-control").each(function(){
    bindRatingControl(this);
  });
});

function bindRatingControl(control){
  var rant_id = $(control).data("rant-id");
  var current_user_id = $(control).data("current-user-id");

  $(control).stars({
    oneVoteOnly: true,
    callback: function(ui, type, value){
      $.post("/rants/" + rant_id + "/add_vote", {value: value, current_user_id: current_user_id, show_user_icon: $(control).parents(".rant-partial").data("show-user-icon")});
    }
  });
}

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

// ===================
// = Follow Personas =
// ===================
$(function(){
  $(".follow-persona-link").live("click", function(){
    $.post($(this).attr("href"), {current_user_id: $(this).data("current-user-id")});
    return false;
  });

  $(".unfollow-persona-link").live("click", function(){
    $.post($(this).attr("href"), {current_user_id: $(this).data("current-user-id")});
    return false;
  });
});

// ===============================================
// = Generic persona rant widget (with selector) =
// ===============================================
$(function(){

	var rantLimit = 200;

  $("#persona-rant-widget .submit-link").live("click", function(){
    id = $("#persona-rant-widget-persona-select-dd").val();
    $.post("/persona_rant_widget/new_persona_rant", {id: $(this).data("current-user-id"), persona_id: id, text: $("#persona-rant-widget textarea").val()});
    return false;
  }); 

	function limitRant(control) {
		if(control.val().length >= rantLimit) {   
			control.val(control.val().substring(0,rantLimit));
		}                           
		counter =	$("#persona-rant-widget-count");
		counter.text(control.val().length + "/" + rantLimit);
		return true;
	}

	$("textarea#persona_rant").live("keydown", function() {
		return limitRant($(this));
	});
	$("#persona-rant-widget textarea").live("keydown", function() {
		return limitRant($(this));
	});
	$("#rant-widget textarea").live("keydown", function() {
		limitRant($(this));
	});
  // synced dropdown stuff
  $("#persona-rant-widget-category-select select").live("change", function(){
    $.get("/prw/category_changed", {id: $(this).val()})
  });
  $("#persona-rant-widget-persona-select select").live("change", function(){
    $.get("/prw/persona_changed", {id: $(this).val()})
  });        
});   

// =======================================
// = Rant widget, on persona detail page =
// =======================================
$(function(){
  $("#rant-widget select").live("change", function(){
    $.get("/prw/update_widget", {id: $(this).val()})
  });

  $("#rant-widget .submit-link").live("click", function(){
    $.post("/persona_rant_widget/new_rant", {id: $(this).data("current-user-id"), persona_id: $(this).data("persona-id"), text: $("#rant-widget textarea").val()});
    return false;
  });
})

// =========================
// = General site behavior =
// =========================
$(function(){
  $(".flash-message").fadeOut(2000);
})

// ==================================
// = Terms and Conditions accordion =
// ==================================

$(function(){
  $("#legal-footer a").click(function(){
    $("#legal-footer .terms").toggle(200, "linear");
  })
})
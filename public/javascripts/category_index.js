$(function(){
  $("#category_dropdown").change(function(){
    window.location.href = "/categories?category_id=" + $(this).val();
  });
})

 
/* global $*/
$(document).on('turbolinks:load', function() {
  // 準備ができたらしてくださいという記述
  $(document).ready(function () {
    $('#tab-contents .tab[id != "tab1"]').hide();
    
    $('#tab-menu a').on('click', function(event) {
      $("#tab-contents .tab").hide();
      $("#tab-menu .active").removeClass("active");
      $(this).addClass("active");
      $($(this).attr("href")).show();
      event.preventDefault();
    });
    
  })
});

  
  // let title = "javascriptが使えました";
  // alert(title);

$(document).ready(function(){
  // insert notification with short-url and copy button on ajax:success
  $("#new_earl").on("ajax:success", function(e, data, status, xhr){
    $("#your-url-container").html(
      "<div id='success-notice' class='alert alert-success'>" +
        "<span> your TinyEarl: <a id='short-url' href=\"" + data["short_url"] + "\">" + data["short_url"] +"</a> </span>"+
        "<button type='button' class='btn btn-success btn-sm' id='copy'>copy</button>" +
        "<p id='copy-status' style='display: none;'></p>" +
      "</div>"
      );

    // copy to clipboard on click
    $("#copy").on('click', function(){
      // create tmp empty input field, insert short-url as value, and select      
      var $temp = $("<input>");
      $("body").append($temp);
      $temp.val($("#short-url").text()).select();

      try {
        // copy to clipboard
        var success = document.execCommand('copy');
        var msg = success ? 'successfully copied to clipboard' : 'woops! something went wrong'
        $("#copy-status").text(msg).fadeIn().delay(3000).fadeOut();
      } catch(err) {
        $("#success-notice").append('woops! something went wrong');
        console.log(err);
      }
      $temp.remove();
    })
  }).on("ajax:error", function(e, data, status, xhr){
    $("#your-url-container").html(
      "<div class='alert alert-warning'> Error: " + data.responseJSON["full_url"].join(", ") + "</div>"
      );
  });

  // infinite scroll
  var next_page = 2;
  window.onscroll = function(ev) {
    if ((window.innerHeight + window.scrollY) >= document.body.scrollHeight) {
      get_next_page();
    }
  };
  $("#load-more > button").on('click', function(){
    get_next_page();
  });

  // get next page if load more button is still present
  // index.html.erb removes it if we're on the last page
  function get_next_page(){
    if($("#load-more > button").length > 0){
      $("#load-more > button").prop('disabled', true);
      $.ajax({
        url: window.location.href,
        data: { page: next_page },
        dataType: 'script',
        success: function(){ 
          next_page += 1;
          $("#load-more > button").prop('disabled', false);
        }
      });      
    }
  }
});
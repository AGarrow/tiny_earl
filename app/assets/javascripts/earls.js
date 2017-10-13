$(document).ready(function(){
	$("#new_earl").on("ajax:success", function(e, data, status, xhr){
		$("#your-url-container").html("<div class='alert alert-success'> your TinyEarl: " + data["short_url"] + "</div>")
	}).on("ajax:error", function(e, data, status, xhr){
		$("#your-url-container").html("<div class='alert alert-warning'> Error: " + data.responseJSON["full_url"].join(", ") + "</div>")
	});
});
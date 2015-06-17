function change_type_fields()
{
	   var resource_types = getSelectedOptions(document.getElementById('resource_type_selector'));
	   var newPath = $('#update_path').attr('value') + "?resource_types=" + resource_types;
	   $('#update_link').attr('href', newPath);
	   $('#update_link').click();
}

function change_use_fields()
{
	   var uses = getSelectedOptions(document.getElementById('resource_use_selector'));
	   var newPath = $('#update_use_path').attr('value') + "?uses=" + uses;
	   $('#update_use_link').attr('href', newPath);
	   $('#update_use_link').click();
}

/*
 * from: http://www.dyn-web.com/tutorials/forms/select/multi-selected.php
 */
function getSelectedOptions(sel) {
    var opts = [], opt;
    
    // loop through options in select list
    for (var i=0, len=sel.options.length; i<len; i++) {
        opt = sel.options[i];
        
        // check if selected
        if ( opt.selected ) {
            // add to array of option elements to return from this function
            opts.push(opt.value);
        }
    }
    
    // return array containing references to selected option elements
    return opts;
}

$(document).on('page:load', function() {
      init();
});

$(document).on('page:fetch', function() {
  var spinner = $(".loading");
  spinner.show();
  $("#overlay").show();
});
$(document).on('page:change', function() {
  $(".loading").hide();
  $("#overlay").hide();
});

$(function() {
      init();
});

function init() {
	// Initialize the plugin
	$('.choose_generic_file_dialog').dialog({
	  autoOpen: false,
	  modal: true,
	  width: 500,
	  buttons: {
	    Cancel: function() {
	      $( this ).dialog( "close" );
        }
  	  }
	});
	
	$(".remove-file").click(remove_file);
	
	$( ".select_dialog_open" ).click(function(event) {
		var target = event.target;
		var attr_name = $(target).attr("data-attribute");
	  	$( "#choose_" + attr_name + "_dialog" ).dialog( "open" );
	  	return false;
	});
	
	$(".search_generic_file_button").click(function(event) {
		var target = event.target;
		var attr_name = $(target).attr("data-attribute");
		$.get( "/catalog.json?utf8=%E2%9C%93&q=" + $("#search_" + attr_name + "_input").val(), function( data ) {
		  var docs = data["response"]["docs"];
		  var docsHtml = "";
		  for (doc in docs) {
		  		docsHtml += '<div>';
		  		docsHtml += '<a onclick="setText(\'' + attr_name + '\',\'' + docs[doc]["id"] + '\',\'' + docs[doc]["title_principals_tesim"][0] + '\',\'' + docs[doc]["depositor_tesim"] + '\')" >';
		  		docsHtml += "<span class=\"glyphicon glyphicon-plus-sign\"></span> ";
		  		docsHtml += build_result_entry(docs[doc]);
		  		docsHtml += "</a>";
		  		docsHtml += "</div>";
		  }
		  $("#" + attr_name + "_results").html(docsHtml);
	});
	
 });
}

function build_result_entry(doc) {
	var title = doc["title_principals_tesim"][0];
	var depositor = doc["depositor_tesim"][0];
	return "\"" + title + "\"" + " uploaded by " + depositor;
}

function remove_file(event) {
	var target = event.target;
	var attr_name = $(target).attr("data-attribute");
	var id = $(target).parent().attr("data-id");
	$(target).parent().remove();
	$("#" + attr_name + "_list").children("input[value='" + id  + "']").remove();
}

function setText(attr_name, id, title, depositor) {
	var html = '<li data-id="' + id + '"' + '">"';
	html += title + '" uploaded by ' + depositor;
	html += " <span class=\"glyphicon glyphicon-trash remove-file\" data-attribute=\"" + attr_name + "\"></span>";
	html += "</li>";
	
	$("#" + attr_name + "_list").append(html);
	
	$("#" + attr_name + "_list").children("li[data-id='" + id  + "']").click(remove_file);
	
	var nrExistingHosts = $("#" + attr_name + "_list input").length;
	var idString = "generic_file_" + attr_name + "_attributes_" + nrExistingHosts + "_id";
	var inputString = '<input class="hidden form-control" type="hidden" value="' + id + '" name="generic_file[' + attr_name + '_attributes][' + nrExistingHosts + '][id]" id="' + idString + '">';
	$("#" + attr_name + "_list").append(inputString);
	$( "#choose_" + attr_name + "_dialog" ).dialog( "close" );
}
  
function find_related_host() {
	
  
  return false;
}

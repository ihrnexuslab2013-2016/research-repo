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

$(function() {
      init();
});

function init() {
	// Initialize the plugin
	$('.choose_generic_file_dialog').dialog({
	  autoOpen: false,
	  modal: true,
	  buttons: {
	    Cancel: function() {
	      $( this ).dialog( "close" );
		        }
	      	}
	});
	
	  
	$( "#select_dialog_open" ).click(function(event) {
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
		  		docsHtml += '<li><a onclick="setText(\'' + attr_name + '\',\'' + docs[doc]["id"] + '\',\'' + docs[doc]["title_principals_tesim"][0] + '\',\'' + docs[doc]["depositor_tesim"] + '\')" >' + docs[doc]["title_principals_tesim"][0] + "</a></li>";
		  }
		  $("#" + attr_name + "_results").html(docsHtml);
	});
 });
}

function setText(attr_name, id, title, depositor) {
	$("#" + attr_name + "_list").append('<li>"' + title + '" uploaded by ' + depositor);
	var nrExistingHosts = $("#" + attr_name + "_list input").length;
	var idString = "generic_file_" + attr_name + "_attributes_" + nrExistingHosts + "_id";
	var inputString = '<input class="hidden form-control" type="hidden" value="' + id + '" name="generic_file[' + attr_name + '_attributes][' + nrExistingHosts + '][id]" id="' + idString + '">';
	$("#" + attr_name + "_list").append(inputString);
	$( "#choose_" + attr_name + "_dialog" ).dialog( "close" );
}
  
function find_related_host() {
	
  
  return false;
}

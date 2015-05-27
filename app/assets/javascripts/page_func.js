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

$(function() {
      // Initialize the plugin
      $('#simple_overlay').dialog({
      	  autoOpen: false,
	      modal: true,
	      buttons: {
	        Ok: function() {
	          $( this ).dialog( "close" );
	        }
      	}
      });

  
	   $( "#simple_overlay_open" ).click(function() {
	      $( "#simple_overlay" ).dialog( "open" );
	      return false;
	    });
	    
	    $("#search_related_host_button").click(function() {
	    	$.get( "/catalog.json?utf8=%E2%9C%93&q=" + $("#search_related_host_input").val(), function( data ) {
			  var docs = data["response"]["docs"];
			  var docsHtml = "";
			  for (doc in docs) {
			  		docsHtml += "<li><a onclick=\"setText('" + docs[doc]["id"] + "','" + docs[doc]["title_principals_tesim"][0] + "')\" >" + docs[doc]["title_principals_tesim"][0] + "</a></li>";
			  }
			  $("#results").html(docsHtml);
			});
	    });
});

function setText(id, title) {
	$("#related_host_label").attr("value", title);
	$("#generic_file_related_host_attributes_0_id").attr("value", id);
	$( "#simple_overlay" ).dialog( "close" );
}
  
function find_related_host() {
	
  
  return false;
}

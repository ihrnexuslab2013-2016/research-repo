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

var add_nested_attribute_template = ["<div class=\"nested_attribute_entry\">", "<div class=\"form-group string optional generic_{{attr_name}}_label with-button\">",
"<input label=\"false\" class=\"string optional\" type=\"text\" name=\"generic_file[{{attr_name}}_attributes][{{index}}][label]\" id=\"generic_file_{{attr_name}}_attributes_{{index}}_label\">",
"<button class=\"btn btn-success add-nested\" data-attribute=\"{{attr_name}}\"><i class=\"icon-white glyphicon-plus\"></i><span> Add</span></button>",
"</div>"].join("\n");

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
	
	$(".delete-nested").click(delete_nested_attribute);
	$(".delete-nested-multi").click(delete_nested_attribute);
	$(".add-nested-multi").click(add_nested_attr_multi);
	
	$(".add-nested").click(add_nested_attribute);
	
	$(".select_dialog_open" ).click(function(event) {
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

function add_nested_attr_multi(event) {
	var target = event.target;
	var surrounding_div = target.closest("div[class='nested_attribute_entry']");
	
	var button = target.closest("button[data-attribute]");
	var attribute_name = $(button).attr("data-attribute");
	
	var list = target.closest("div[id='" + attribute_name + "_input_list']");
	var list_length = $(list).children(".nested_attribute_entry").size();
		
	var last_entry = $(list).children(".nested_attribute_entry").last();
	
	// enable remove button if disabled
	var remove_button = last_entry.find("button.delete-nested-multi").first();
	if (remove_button != null) {
		$(remove_button).removeAttr('disabled');
	}
		
	var new_entry_html = last_entry.clone(); 
	var new_entry = $(new_entry_html).insertAfter(last_entry);
	
	new_entry.find("input[id$='_id']").remove();
	new_entry.find("input[type='text']").attr("value", "");
	new_entry.find("input[type='text']").val("");
	new_entry.find("input[type='url']").attr("value", "");
   new_entry.find("input[type='url']").val("");
	
	var inputs = $(new_entry).find("input");
	inputs.each(function() {
		update_attribute_index(this, list_length);
	});
	
	$(new_entry).find("button").click(delete_nested_attribute);
	  	
  		
	return false;
}

function add_nested_attribute(event) {
		var target = event.target;
		var surrounding_div = target.closest("div[class='nested_attribute_entry']");
		
		var button = target.closest("button[data-attribute]");
		
		var attribute_name = $(button).attr("data-attribute");
		
		var list = target.closest("div[id='" + attribute_name + "_input_list']");
		var list_length = $(list).children(".nested_attribute_entry").size();
		
	  	var new_entry_html = $(list).children(".nested_attribute_entry").last().clone(); 
	  	var new_entry = $(new_entry_html).appendTo(list);
	  	
	  	new_entry.find("input[id$='_id']").remove();
	  	new_entry.find("input[type='text']").val("");
	  	
	  	var inputs = $(new_entry).find("input");
  		inputs.each(function() {
  			update_attribute_index(this, list_length);
  		});
	  	
	  	// turn add button into remove button
	  	$(button).find("span").html(" Remove");
	  	$(button).find("i").toggleClass("glyphicon-plus glyphicon-minus");
	  	$(button).attr("class", "btn btn-danger delete-nested");
	  	$(button).unbind("click");
	  	$(button).click(delete_nested_attribute);
	  	
	  	var new_button = new_entry.find("button");
	  	$(new_button).click(add_nested_attribute);
	  	
	  	return false;
	}
	
function delete_nested_attribute(event) {
	var target = event.target;
	var button = target.closest("button[data-attribute]");
	var attr_name = $(button).attr("data-attribute");
		
	var surrounding_div = target.closest("div[class='nested_attribute_entry']");
	var list = surrounding_div.closest("div[id='" + attr_name + "_input_list']");
	  	
  	var div_to_remove = target.closest("div[class='nested_attribute_entry']");
  	div_to_remove.remove();
  	
  	// update all indexes
  	var list_items = $(list).children("div");
  	$(list).children("div").each(function(i) {
  		var inputs = $(this).find("input");
  		inputs.each(function() {
  			update_attribute_index(this, i);
  		});
  		
  	});
  	
  	// for nested attributes with multiple input fields:
  	// if there is only one entry left, disable remove button if there is one
  	if (list_items.length == 1) {
  		var delete_button = list_items.first().find("button.delete-nested-multi").first();
  		if (delete_button != null) {
  			delete_button.attr('disabled', true);
  		}
  	}
  	
  	
  	return false;
}

function update_attribute_index(input, i) {
	var oldName = $(input).attr("name");
	var oldId = $(input).attr("id");
	var newName = oldName.replace(new RegExp("\[[0-9]+?\]"), "[" + i + "]");
	var newId = oldId.replace(new RegExp("_[0-9]+?_"), "_" + i + "_");
	
	$(input).attr("name", newName);
	$(input).attr("id", newId);
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
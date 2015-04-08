function change_type_fields()
{
	/*var path_parts = window.location.href.split('/');
	$.ajax({
        url : "/files/" + path_parts[path_parts.length - 2] + "/update_edit",
        data : {updated_data: $('#descriptions_display').find('form').serializeArray()}, 
        type: "POST",
        success : function(data) {
          $("#descriptions_display").html(data);
        }
     }); */
    
	   var resource_types = getSelectedOptions(document.getElementById('resource_type_selector'));
	   var newPath = $('#update_path').attr('value') + "?resource_types=" + resource_types;
	   $('#update_link').attr('href', newPath);
	   $('#update_link').click();
	   
	
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
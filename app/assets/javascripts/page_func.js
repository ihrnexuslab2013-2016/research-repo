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
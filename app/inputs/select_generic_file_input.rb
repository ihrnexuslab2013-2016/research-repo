class SelectGenericFileInput < SimpleForm::Inputs::FileInput
  
  def input(wrapper_options = nil)
    out = ActiveSupport::SafeBuffer.new
     
    html = '<span class="input-group-btn field-controls">'
    html += '<button id="select_dialog_open" class="btn btn-success add_file">'
    html += "<i class=\"icon-white glyphicon-add\"></i><span data-attribute=\"#{attribute_name}\">Add #{attribute_name.to_s.humanize.singularize.downcase}</span>"
    html += '</button>'
    html += '</span>'
    html += "<div id=\"choose_#{attribute_name}_dialog\" class=\"choose_generic_file_dialog\" title=\"Select resource\">"
    html += "<input id=\"search_#{attribute_name}_input\" type=\"text\">"
    html += "<button id=\"search_#{attribute_name}_button\" class=\"btn btn-success add_file search_generic_file_button\" data-attribute=\"#{attribute_name}\">Search</button>"
    html += "<ul id=\"#{attribute_name}_results\">"
    html += '</ul>'
    html += '</div>'
    
    out << html.html_safe
    
  end
end
class SelectGenericFileInput < SimpleForm::Inputs::FileInput
  
  def input(wrapper_options = nil)
    out = ActiveSupport::SafeBuffer.new
    
    return out if object.nil?
    
    html = "<div class=\"select_dialog_open\" data-attribute=\"#{attribute_name}\">"
    html += "<span class=\"glyphicon glyphicon-plus-sign\"></span> Add #{attribute_name.to_s.humanize.singularize.downcase}"
    html += "</div>" 
    html += "<ul class=\"linked_file_list\" id=\"#{attribute_name}_list\">"
    object.model.send("#{attribute_name}").each do |host| 
      @builder.simple_fields_for "#{attribute_name}".to_sym, host do |build|
        html += build.hidden_field "id"
        html += "<li data-id=\"#{host.id}\">"
        html += "\"#{host.title_principals.first.label}\" uploaded by #{host.depositor}"
        html += " <span class=\"glyphicon glyphicon-trash remove-file\" data-attribute=\"#{attribute_name}\"></span>"
        html += "</li>"
      end
    end 
    html += "</ul>"
    
    html += "<div id=\"choose_#{attribute_name}_dialog\" class=\"choose_generic_file_dialog\" title=\"Select resource\">"
    html += "<input style=\"width: 80%;\" id=\"search_#{attribute_name}_input\" type=\"text\">"
    html += "<button id=\"search_#{attribute_name}_button\" class=\"add_file btn btn-success search_generic_file_button\" data-attribute=\"#{attribute_name}\">Search</button>"
    html += "<div id=\"#{attribute_name}_results\" class=\"result-list\">"
    html += '</div>'
    html += '</div>'
    
    out << html.html_safe
    
  end
end
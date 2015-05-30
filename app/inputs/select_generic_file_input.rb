class SelectGenericFileInput < SimpleForm::Inputs::FileInput
  
  def input(wrapper_options = nil)
    out = ActiveSupport::SafeBuffer.new
    
    return out if object.nil?
    
    html = "<ul id=\"#{attribute_name}_list\">"
    puts "++++++++++++++++++++"
    puts attribute_name
    puts object
    puts object.send("#{attribute_name}")
    object.model.send("#{attribute_name}").each do |host| 
      @builder.simple_fields_for "#{attribute_name}".to_sym, host do |build|
        html += build.hidden_field "id"
        html += "<li>"
        html += "\"#{host.title_principals.first.label}\" uploaded by #{host.depositor}"
        html += "</li>"
      end
    end 
    html += "</ul>"
    
    html += '<span class="input-group-btn field-controls">'
    html += '<button id="select_dialog_open" class="add_file btn btn-success" style="border-radius: 4px;">'
    html += "<i class=\"icon-white glyphicon-add\"></i><span data-attribute=\"#{attribute_name}\">Add #{attribute_name.to_s.humanize.singularize.downcase}</span>"
    html += '</button>'
    html += '</span>'
    html += "<div id=\"choose_#{attribute_name}_dialog\" class=\"choose_generic_file_dialog\" title=\"Select resource\">"
    html += "<input id=\"search_#{attribute_name}_input\" type=\"text\">"
    html += "<button id=\"search_#{attribute_name}_button\" class=\"add_file btn btn-success search_generic_file_button\" data-attribute=\"#{attribute_name}\">Search</button>"
    html += "<ul id=\"#{attribute_name}_results\">"
    html += '</ul>'
    html += '</div>'
    
    out << html.html_safe
    
  end
end
class NestedAttributeMultipleInput < SimpleForm::Inputs::FileInput
  
  def input(wrapper_options = nil)
    out = ActiveSupport::SafeBuffer.new
    
    return out if object.nil? or object.model.nil?
    
    html = "<div id=\"#{attribute_name}_input_list\">"
    
    collection = object.model.send("#{attribute_name}")
    class_name = GenericFile.reflections["#{attribute_name}".to_sym].class_name
    
    fields = options[:fields]
    
    (collection + [class_name.constantize.new]).each_with_index do |attribute, index|
      html += "<div class=\"nested_attribute_entry\">"
      
      @builder.simple_fields_for "#{attribute_name}".to_sym, attribute do |build|
        html += "<div class=\"form-group string optional generic_#{attribute_name}_label with-button\">"
        html += "<div class=\"file-show-term panel-body\">"
        
        fields.each do |field|
          html += build.input field
        end
        
        html += build.hidden_field "id"
        
        hidden_value_fields = options[:hidden_value_field]
        if not hidden_value_fields.nil?
          hidden_value_fields.each do |key, value|
            html += build.hidden_field key, :value => value
          end
        end
        html += "<button class=\"btn btn-danger delete-nested-multi\" data-attribute=\"#{attribute_name}\">"
        html += "<i class=\"icon-white glyphicon-minus\"></i><span> Remove</span>"
        html += "</button>"
          
        html += "</div>"
        html += "</div>"
      end
      html += "</div>"
      
      
    end
    
    html += "<button class=\"btn btn-success add-nested-multi\" data-attribute=\"#{attribute_name}\">"
    html += "<i class=\"icon-white glyphicon-plus\"></i><span> Add</span>"
    html += "</button>"
    
    html += "</div>"
    
    
    out << html.html_safe
     
  end
end
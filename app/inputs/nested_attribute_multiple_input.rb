class NestedAttributeMultipleInput < SimpleForm::Inputs::CollectionInput
  
  def input(wrapper_options = nil)
    out = ActiveSupport::SafeBuffer.new
    
    return out if object.nil? or object.model.nil?
     
    html = "<div id=\"#{attribute_name}_input_list\">"
    
    collection = object.model.send("#{attribute_name}")
    class_name = GenericFile.reflections["#{attribute_name}".to_sym].class_name
    clazz = class_name.constantize
    
    
    fields = options[:fields]
    multiple = true
    multiple = options[:multiple] if !options[:multiple].nil? 
    
    elements = collection + []
    elements << clazz.new if elements.empty?
    
    elements.each_with_index do |attribute, index|
      html += "<div class=\"nested_attribute_entry\">"
      
      @builder.simple_fields_for "#{attribute_name}".to_sym, attribute do |build|
        html += "<div class=\"generic_#{attribute_name}_label with-button\">"
        html += "<div class=\"file-show-term panel-body\">"
        
        
        fields.each do |field|
          field_contents = attribute.send(field)
          html += "<div" 
          html += " class= \"nested-attrs-li\" " if !clazz.multiple? field
          html += " class=\"form-group multi_value\" " if clazz.multiple? field
          html +=  ">"
          html += build.label field
          html += "<ul class=\"listing\">"
          if clazz.multiple? field
            field_contents + [""].each do |con|
              html += "<li class=\"field-wrapper\">"
              html += build.text_field nil, {:wrapper => false, :label => false, :value => con, 
                :name =>  "#{object_name}[#{attribute_name}_attributes][#{index}][#{field}][]", 
                :id => "#{object_name}_#{attribute_name}_attributes_#{index}_#{field}"}
              html += "</li>"
            end
          else
             html += "<li class=\"field-wrapper\">"
             html += build.input field, {:wrapper => false, :label => false}
             html += "</li>"
          end
          html += "</ul>"
          html += "</div>" 
        end
        
        if !attribute.id.blank?
          html += build.hidden_field "id"
        end
        
        hidden_value_fields = options[:hidden_value_field]
        if not hidden_value_fields.nil?
          hidden_value_fields.each do |key, value|
            html += build.hidden_field key, :value => value
          end
        end
        if multiple
          html += "<button class=\"btn btn-danger delete-nested-multi\" data-attribute=\"#{attribute_name}\""
          html += " disabled " if elements.size == 1
          html += ">"
          
          html += "<i class=\"icon-white glyphicon-minus\"></i><span> Remove</span>"
          html += "</button>"
        end
          
        html += "</div>"
        html += "</div>"
      end
      html += "</div>"
      
      
    end
    
    if multiple
      html += "<button class=\"btn btn-success add-nested-multi\" data-attribute=\"#{attribute_name}\">"
      html += "<i class=\"icon-white glyphicon-plus\"></i><span> Add</span>"
      html += "</button>"
    end
    
    html += "</div>"
    
    
    out << html.html_safe
     
  end
  
  private 
    def multiple?; true; end
end
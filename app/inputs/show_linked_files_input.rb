class ShowLinkedFilesInput < SimpleForm::Inputs::FileInput
  
  def input(wrapper_options = nil)
    out = ActiveSupport::SafeBuffer.new
    
    return out if object.nil?
    
    html = ""
    object.model.send("#{attribute_name}").each do |obj|    
        html += "<span itemprop=\"#{attribute_name}\" itemscope=\"\" itemtype=\"http://schema.org/Thing\">"
        html += '<span itemprop="name">'
        html += "<a href=\"#{sufia.generic_file_path(obj)}\">"
        html += obj.title_principals.first.label
        html += "</a>"
        html += "uploaded by"
        html += obj.depositor
        html += "</span>"
        html += "</span>"
    end 
    
    out << html.html_safe
    
  end
end
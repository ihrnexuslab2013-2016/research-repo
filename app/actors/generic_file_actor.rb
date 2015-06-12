class GenericFileActor < Sufia::GenericFile::Actor
  
  def update_metadata(attributes, visibility)
    ref_attrs = [:related_hosts_attributes, :related_referenced_by_attributes, :related_originals_attributes]
    ref_attrs.each{ |attr| set_referenced_files(attr, attributes) }
    
    super(attributes, visibility)
  end
  
  
  def set_referenced_files(ref_attr, attributes)
    referenced_files = attributes[ref_attr]
    if !referenced_files.nil?
      files = []
      referenced_files.each do |key, file_attr|
        id = file_attr[:id]
        if !id.empty?
          file = GenericFile.find(id)
          files << file
        end
      end
      ridx = ref_attr.to_s.rindex "_attributes"
      attr_name = ref_attr.to_s[0..ridx-1]
      generic_file.send("#{attr_name}=", files)
      attributes.except! ref_attr
    end
  end
  
end
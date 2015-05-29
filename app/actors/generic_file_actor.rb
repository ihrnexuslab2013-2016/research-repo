class GenericFileActor < Sufia::GenericFile::Actor
  
  def update_metadata(attributes, visibility)
    referenced_files = attributes[:related_hosts_attributes]
    if !referenced_files.nil?
      files = []
      referenced_files.each do |key, file_attr|
        id = file_attr[:id]
        if !id.empty?
          file = GenericFile.find(id)
          files << file
        end
      end
      generic_file.related_hosts = files
      attributes.except! :related_hosts_attributes
    end
    
    
    super(attributes, visibility)
  end
  
end
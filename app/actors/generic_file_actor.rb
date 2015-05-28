class GenericFileActor < Sufia::GenericFile::Actor
  
  def update_metadata(attributes, visibility)
    referenced_files = attributes[:related_hosts_attributes]
    puts "update referenced files ++++++++++++++++++++++"
    puts referenced_files
    
    if !referenced_files.nil?
      referenced_files.each do |key, file_attr|
        id = file_attr[:id]
        if !id.empty?
          file = GenericFile.find(id)
          generic_file.related_hosts = [file]
        end
      end
      attributes.except! :related_hosts_attributes
    end
    
    super(attributes, visibility)
  end
  
end
class GenericFileActor < Sufia::GenericFile::Actor
  
  def create_metadata(batch_id)
    #@generic_file.title_uniforms = [MODS::TitleInfo.new]
    #@generic_file.subject_geographics = [MODS::MADS::Geographic.new]
    #@generic_file.subject_topics = [MODS::MADS::Topic.new]
      
    super
  end
  
end
class GenericFileActor < Sufia::GenericFile::Actor
  
  def create_metadata(batch_id)
    @generic_file.title_uniforms = [MODS::TitleInfo.new]
      
    super
  end
 
end
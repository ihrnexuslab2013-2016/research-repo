class KarkinosFileEditForm < KarkinosGenericFilePresenter
  include HydraEditor::Form
  include HydraEditor::Form::Permissions
  include AttributeHelper
  
  self.required_fields = [:title, :creator, :tag, :rights]
  
  @permitted_additional_files = []
  files = AttributeHelper.yaml_use_files # AttributeHelper.yaml_type_files + AttributeHelper.yaml_use_files
  files.each do |file|  
    yamlFile = YAML.load_file(file)
    yamlFile['fields'].each do |field|
      termSym = field['name'].parameterize.underscore.to_sym
      if multiple?(termSym)
        @permitted_additional_files << { termSym => [] }
      else
        @permitted_additional_files << termSym
      end
    end
  end
  
  def self.build_permitted_params
     super  + (@permitted_additional_files ? @permitted_additional_files : [])
  end
  

end
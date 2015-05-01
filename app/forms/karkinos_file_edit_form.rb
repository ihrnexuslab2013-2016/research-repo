class KarkinosFileEditForm < KarkinosGenericFilePresenter
  include HydraEditor::Form
  include HydraEditor::Form::Permissions
  include AttributeHelper
  
  self.required_fields = [:title, :creator, :tag, :rights]
  @@permitted_nested_params = [ :title_principals => [:label] ]
  
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
     super  + (@permitted_additional_files ? @permitted_additional_files : []) + @@permitted_nested_params
  end
  
  def self.nested_attributes(form_params)
    permitted_nested_params = form_params.permit(@@permitted_nested_params)
    puts "+++++++++++++++ nested attr"
    puts form_params
    puts permitted_nested_params
    puts @@permitted_nested_params.keys
    
    permitted_nested_params
  end

end
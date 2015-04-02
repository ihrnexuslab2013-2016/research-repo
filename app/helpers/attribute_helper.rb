module AttributeHelper
  def self.yaml_type_files
    typeFiles = Dir.glob("#{Rails.root}/metadata/type/*")
  end
  
  def self.yaml_use_files
    typeFiles = Dir.glob("#{Rails.root}/metadata/use/*")
  end
end
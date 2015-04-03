def build_use_hash 
  uses = Hash.new
  useFiles = Dir.glob("#{Rails.root}/metadata/use/*")
  useFiles.each do |file|  
     yamlFile = YAML.load_file(file)
     uses.store(yamlFile['use_name'], yamlFile['use_name'])
  end
  return uses
end
module KarkinosRDF
  class MODS
    
    @@namespace = 'http://www.loc.gov/mods/v3#'
    
    class << self
      def property(sym, relation)
        class_variable_set("@@#{sym}", relation)
        
        define_singleton_method(sym) do
          ::RDF::URI.new(@@namespace + class_variable_get("@@#{sym}"))
        end
      end
    end
    
    property :type_of_resource, "typeOfResource"
    
    property :title, "title"
    
    property :titleinfo, "titleInfo"
    
  end
end
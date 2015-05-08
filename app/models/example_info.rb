class ExampleInfo < ActiveFedora::Base
  property :label, predicate: ::RDF::URI.new("http://test.org/label"), multiple: false
end

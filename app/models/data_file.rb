class DataFile < GenericFile
  #include Sufia::GenericFile
  
  
  belongs_to :generic_file, predicate: ActiveFedora::RDF::Fcrepo::RelsExt.isPartOf
  
end
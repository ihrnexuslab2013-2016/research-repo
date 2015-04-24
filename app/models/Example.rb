require "active-fedora"

class Example < ActiveFedora::Base
  
  property :titleInfo, predicate: ModsVocabulary.hasTitle, class_name: "TitleInfo", multiple: false
end
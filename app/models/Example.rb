require "active-fedora"

class Example < ActiveFedora::Base
  
  has_and_belongs_to_many :titleInfo, :predicate => ModsVocabulary.hasTitle, :class_name => "TitleInfo"
  accepts_nested_attributes_for :titleInfo
end
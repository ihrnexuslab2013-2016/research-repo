require "active-fedora"

class Example < ActiveFedora::Base
  
  has_and_belongs_to_many :titleInfo, :predicate => MODS::MODSVocabulary.titleInfo, :class_name => "MODS::TitleInfo"
  accepts_nested_attributes_for :titleInfo
end
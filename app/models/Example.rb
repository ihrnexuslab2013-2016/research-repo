#require 'mods/mods_vocabulary'

class Example < ActiveFedora::Base
  
  has_and_belongs_to_many :example_infos, :predicate => MODS::MODSVocabulary.titlePrincipal, :class_name => "ExampleInfo"
  accepts_nested_attributes_for :example_infos
  
  
  def test
    ["a", "b"].each_with_index do |ti, index|
      puts ti
      puts "#{index}"
    end
  end
  
    
end
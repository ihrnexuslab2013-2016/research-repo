module MODS
  class NoteGroup < LabelProperty
    property :note_group_note, predicate: MODS::MODSRDFVocabulary.noteGroupNote, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
    property :note_group_type, predicate: MODS::MODSRDFVocabulary.noteGroupType, multiple: false do |index|
       index.as :stored_searchable, :facetable
    end
  end
end
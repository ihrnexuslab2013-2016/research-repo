module NestedNoteGroups
  extend ActiveSupport::Concern
  
  module ClassMethods
    def build_permitted_params
      permitted = super
      permitted << { note_groups_attributes: permitted_note_groups_params }
      permitted
    end

    def permitted_note_groups_params
      [:label, :id, :note_group_note, :note_group_type]
    end

  end

  def note_groups_attributes= attributes
    model.note_groups_attributes= attributes
  end

end
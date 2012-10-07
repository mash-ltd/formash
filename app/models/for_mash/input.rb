module ForMash
  class Input
    include Mongoid::Document

    # Constants
    TYPES = %w(text_field number_field text_area file_field drop_down radio_buttons)

    # Fields
    field :label
    field :type, type: Symbol
    field :predefined_values, type: Array, default: []
    field :required, type: Boolean, default: false

    # Relations
    embedded_in :item, class_name: 'ForMash::Item'

    # Validations
    validates :label, presence: true
    validates :type, inclusion: { in: TYPES.map(&:to_sym) }

    # Overrides
    def predefined_values=(value)
      self[:predefined_values] = value.split(',').map(&:strip)
    end
  end
end

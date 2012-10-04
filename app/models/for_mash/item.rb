module ForMash
  class Item
    include Mongoid::Document
    include Mongoid::Timestamps::Created

    # Fields
    field :name

    # Relations
    belongs_to :template, class_name: 'ForMash::Template'
    embeds_many :inputs, class_name: 'ForMash::Input'
    accepts_nested_attributes_for :inputs, allow_destroy: true

    # Validations
    validates :name, presence: true
  end
end

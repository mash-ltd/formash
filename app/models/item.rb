class Item
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  
  # Fields
  field :name
  
  # Relations
  belongs_to :template
  embeds_many :inputs
  accepts_nested_attributes_for :inputs, allow_destroy: true
  
  # Validations
  validates :item_id, :name, presence: true
end

class Template
  include Mongoid::Document
  include Mongoid::Timestamps

  # Fields
  field :name 
  
  # Relations
  has_many :items, dependent: :destroy
  has_many :fills, dependent: :destroy
  accepts_nested_attributes_for :items, allow_destroy: true
  
  # Validations
  validates :name, presence: true
  
  # Scopes
  scope :list, asc(:name)
  
  # Callbacks
  # after_validation :flatten_nested_errors
  before_destroy -> { self.fills.empty? }

# protected  
#   def flatten_nested_errors
#     if self.errors[:items].any?
#       self.errors[:items].clear
#       self.items.each do |item|
#         if item.errors[:inputs].any?
#           item.errors[:inputs].clear
#           item.inputs.each do |input|
#             input.errors.full_messages.each do |error|
#               item.errors[:inputs] << error
#             end
#           end
#       end
#     end
#   end
end
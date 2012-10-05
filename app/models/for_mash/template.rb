module ForMash
  class Template
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Paranoia

    # Fields
    field :name

    # Relations
    belongs_to :creator, polymorphic: true
    has_many :items, class_name: 'ForMash::Item'
    has_many :fills, autosave: true, class_name: 'ForMash::Fill'
    accepts_nested_attributes_for :items, allow_destroy: true

    # Validations
    validates :name, presence: true

    # Scopes
    scope :list, asc(:name)
    scope :created_by, ->(creator) { where(creator_id: creator.id, creator_type: creator.class.to_s) }

    # Callbacks
    # after_validation :flatten_nested_errors

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
end
module ForMash
  class Entry
    # Regex copied from http://stackoverflow.com/questions/2964678/jquery-youtube-url-validation-with-regex/10315969#10315969
    YOUTUBE_REGEX = %r#\A(?:https?:\/\/)?(?:www\.)?youtube\.com\/watch\?(?=.*v=((?:\w|-){11}))(?:\S+)?\Z#

    include Mongoid::Document

    # Fields
    field :input_id, type: Moped::BSON::ObjectId
    field :value

    # Relations
    embedded_in :fill, class_name: 'ForMash::Fill'
    belongs_to :item, class_name: 'ForMash::Item', inverse_of: nil

    # Validations
    validates :input_id, presence: true
    validates :value, inclusion: { in: ->(entry) { entry.predefined_values.map(&:downcase) } }, if: -> { self.value.present? && self.required? && [:drop_down, :radio_buttons].include?(self.type)  }
    validates :value, numericality: true, if: -> { self.type == :number_field }
    validates :value, format: { with: YOUTUBE_REGEX }, if: -> { self.type == :youtube_video }
    validates :value, presence: true, if: -> { self.required? }, unless: -> { self.type == :file_field }
    validates :file, presence: true, if: -> { self.required? && self.type == :file_field }

    # Delegate
    delegate :label, :type, :predefined_values, :required?, to: :input

    # Methods
    def input
      @input ||= self.item.inputs.find(self.input_id) if self.input_id.present?
    end

    def input=(value)
      self.input_id = (@input = value).id
    end

    def file_cache?
      self.file_cache.present?
    end
  end
end

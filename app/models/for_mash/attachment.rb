module ForMash
  class Attachment
    include Mongoid::Document

    attr_accessor :file

    belongs_to :fill, class_name: 'ForMash::Fill'

    mount_uploader :file, EntryFileUploader
  end
end

# encoding: utf-8

module ForMash
  class EntryFileUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick
    include Sprockets::Helpers::RailsHelper
    include Sprockets::Helpers::IsolatedHelper

    # Storage
    storage :file

    def store_dir
      "uploads/#{model.class.to_s.underscore}/fills/#{model.fill.id}/#{model.id}"
    end

    def extension_white_list
      %w(doc docx pdf xls txt jpg jpeg png)
    end
  end
end

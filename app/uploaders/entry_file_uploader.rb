# encoding: utf-8
class EntryFileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  # Storage
  storage :grid_fs
  
  def store_dir
    "fills/#{model.mre.id}/entries/#{model.id}"
  end
end

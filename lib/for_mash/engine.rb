require 'for_mash/link_to_fields'
require 'for_mash/youtube_video'
require 'nested_form'

ActiveSupport.on_load :action_view do
  ActionView::Helpers::FormBuilder.send :include, ForMash::LinkToFields
  ActionView::Helpers::FormBuilder.send :include, ForMash::YoutubeVideo
end

module ForMash
  class Engine < ::Rails::Engine
    self.routes.default_scope = { :module => 'for_mash' }
  end
end

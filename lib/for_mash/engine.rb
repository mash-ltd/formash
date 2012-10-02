require 'for_mash/link_to_fields'

ActiveSupport.on_load :action_view do
  ActionView::Helpers::FormBuilder.send :include, ForMash::LinkToFields
end

module ForMash
  class Engine < ::Rails::Engine
    isolate_namespace ForMash
  end
end

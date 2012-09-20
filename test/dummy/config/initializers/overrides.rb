class Symbol
  def method_missing(method, *args, &block)
    string = self.to_s
    if string.respond_to?(method)
      string.send(method)
    else
      super
    end
  end
end

module ActiveRecord
  class Base
    def self.build(*args)
      self.new(*args)
    end
  end
end

module ActionView
  module Helpers
    class FormBuilder
      alias_method :_label, :label
      
      def required?(method)
        @object.class.validators_on(method).map(&:kind).include?(:presence)
      end
      
      def label(method, text = nil, options = {}, &block)
        if @object.present? && options[:required].nil? ? required?(method) : options[:required]
          if text.is_a?(Hash)
            options.merge!(text)
            text = nil
          end
          
          text ||= human(method)
          text = I18n.t(:required, scope: :helpers, default: "#{text}*", text: text.html_safe)
        end
        
        _label(method, text, options.except(:required), &block)
      end
    end
  end
end

# Libraries
ActiveRecord::Base.send :extend, Embeds
ActiveRecord::Base.send :extend, Addressable
ActiveRecord::Base.send :include, Human::ActiveRecord
ActionView::Helpers::FormBuilder.send :include, LinkToFields
ActionView::Helpers::FormBuilder.send :include, Human::FormBuilder
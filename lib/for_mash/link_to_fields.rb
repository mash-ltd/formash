module ForMash
  module LinkToFields
    def link_to_add_fields(name, options = {}, &block)
      new_object = @object.class.reflect_on_association(name).klass.new

      partial    = options.delete(:partial)   || "#{name}_fields"
      title      = options.delete(:title)     || I18n.t('helpers.link_to_fields.add', name: name.to_s.singularize)
      append_to  = options.delete(:append_to) || "##{@template.send(:sanitize_to_id, "#{@object_name}[#{name}]")}"

      fields = fields_for(name, new_object, child_index: "new_#{name}") do |builder|
        @template.render partial: partial, locals: { f: builder }
      end
      @template.link_to (block_given? ? @template.capture(&block) : title), '#', options.merge(data: { link_to_fields: :add, name: name, fields: fields.to_json, append_to: append_to })
    end

    def link_to_remove_fields(name, options = {}, &block)
      title = options.delete(:title) || I18n.t('helpers.link_to_fields.remove', name: name.to_s.singularize)

      hidden_field(:_destroy) + @template.link_to((block_given? ? @template.capture(&block) : title), '#', options.merge(data: { link_to_fields: :remove, for: "##{@template.dom_id(@object)}" }))
    end
  end
end
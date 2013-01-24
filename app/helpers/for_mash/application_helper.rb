module ForMash
  module ApplicationHelper
    def application_error_messages_for(form)
      form.error_messages header_message: nil, class: 'alert alert-error'
    end
    
    def title(title = nil, out = nil)
      title ||= controller_name.humanize
      content_for(:title, [title].flatten.join(' &#9656; ').html_safe)
      [(out || title)].flatten.join(' &#9656; ').html_safe
    end
    
    def application_title
      "NabdaNet#{" &mdash; #{content_for(:title)}" if content_for?(:title)}".html_safe
    end
    
    def nav_link(*args)
      options = args.extract_options!
      path, title = args

      to_controller = options.delete(:controller)
      to_action = options.delete(:action)

      if to_controller.present?
        active = (controller_name.to_sym == :entities && params[:type].tableize == to_controller.to_s)
        active ||= (params[:individual_id].present? && to_controller == :individuals)
        active ||= controller_name == to_controller.to_s
        
        active &&= (action_name == to_action.to_s) if to_action.present?
      else
        active = request.path == send(path)
      end

      content_tag :li, class: ('active' if active) do
        link_to (title || to_controller.titleize), send(path, options.merge(page: nil))
      end
    end
    
    def auto_link(text, options = {})
      Rinku.auto_link(text, *options)
    end
    
    def beautify(text)
      return if text.nil?
      text = auto_link(text)
      text = simple_format(text)

      text.html_safe
    end
    
    def dotiw(time)
      distance_of_time_in_words(time, Time.now, true, highest_measure_only: true)
    end
    
    def display_contact_number(contact_number)
      contact_number.gsub(/[^\d]/, '').gsub(/(\d{2})(\d{1,2})(\d{4})(\d{4})$/, '\1 (\2) \3-\4')
    end
    
    def display_address(address)
      beautify %Q{
        #{address[:building]} #{address[:street]},
        #{address[:district]}, #{address[:city]},
        #{"P.O. #{address[:postal_code]}, " if address[:postal_code].present?}#{address[:country]}.
      }
    end
    
    def carrierwave_tmp_path(path = nil)
      "/tmp#{"/#{path}" if path.present?}"
    end
    
    def singular_named_route(*records)
      named_route(records, :singular)
    end
    
    def plural_named_route(*records)
      named_route(records, :plural)
    end
    
    def named_route(records, inflection)
      send(:build_named_route_call, records, inflection, routing_type: :path)
    end

    def input_label_css_class(input)
      ''
    end

    def extract_youtube_vid(url)
      results = url.scan(Entry::YOUTUBE_REGEX)
      raise "Failed to extract video id from this URL: #{url}" if results.empty?
      results.first[0]
    end
  end
end

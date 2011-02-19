module Stakr #:nodoc:
  module I18nHelpers #:nodoc:
    
    # Methods to translate keys in views and helpers.
    module Helper
      
      # Translates the specified key using <tt>I18n</tt>. If the key starts
      # with <tt>'.'</tt> the key is prefixed with <tt>"views.#{template_path}"</tt>
      # and <tt>"views.shared"</tt> as fallback where <tt>template_path</tt> is
      # filled with the path of the current template or the template invoking the
      # current helper.
      def translate(key, options = {})
        key = key.to_s
        if key.first == "."
          defaults = []
          segments = template.path_without_format_and_extension.split('/')
          defaults << :"views.#{segments.join('.')}#{key}"
          loop do
            segments.pop
            break if segments.blank?
            defaults << :"views.#{segments.join('.')}.shared#{key}"
          end
          defaults << :"views.shared#{key}"
          defaults << options[:default] if options[:default]
          defaults.flatten!
          defaults << key.split('.').last.humanize
          I18n.translate(defaults.shift, options.merge(:default => defaults))
        else
          I18n.translate(key, options)
        end
      end
      
    end
    
  end
end

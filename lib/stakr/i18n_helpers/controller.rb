module Stakr #:nodoc:
  module I18nHelpers #:nodoc:
    
    # Methods to translate keys in controllers.
    module Controller
      
      def scope_key_by_controller(key, controller_class, including_action = true) #:nodoc:
        controller = controller_class.to_s.underscore.gsub('/', '.')
        controller = controller[0..-12] if controller.ends_with?('_controller')
        including_action ?
          "controllers.#{controller}.#{params[:action]}#{key}" :
          "controllers.#{controller}#{key}"
      end
      
      # Translates the specified key using <tt>I18n</tt>. If the key starts with <tt>'.'</tt>
      # the key is prefixed with <tt>"controllers.#{controller_name}.#{action}"</tt> and
      # <tt>"controllers.#{controller_name}"</tt> as fallback where <tt>controller_name</tt>
      # is filled with names (underscore) of all ascending controllers up to
      # <tt>ActionController::Base</tt>.
      def translate(key, options = {})
        if key.to_s.first == '.'
          classes = []
          current = self.class
          while true
            classes << current
            current = current.superclass
            break if current.nil? || current == ActionController::Base
          end
          defaults =  classes.map { |c| scope_key_by_controller(key, c, true ).to_sym }
          defaults += classes.map { |c| scope_key_by_controller(key, c, false).to_sym }
          defaults << options[:default] if options[:default]
          defaults.flatten!
          defaults << key.to_s.split('.').last.humanize
          I18n.translate(defaults.shift, options.merge(:default => defaults))
        else
          I18n.translate(key, options)
        end
      end
      alias :t :translate
      
    end
    
  end
end

module Stakr #:nodoc:
  module I18nHelpers #:nodoc:
    module Models #:nodoc:
      
      # Methods to return a localized description of a model action, using I18n.
      # 
      # See also HumanMessage::ClassMethods
      module HumanMessage
        
        def self.included(base) #:nodoc:
          base.extend(ClassMethods)
        end
        
        def human_message(scope, *args)
          self.class.human_message(scope, *args)
        end
        
        # See also HumanMessage
        module ClassMethods
          
          # TODO
          # 
          # ==== Examples
          # 
          #   ...
          # 
          def human_message(scope, *args)
            options = args.extract_options!
            args = args.map(&:to_s).join('.')
            defaults = self_and_descendants_from_active_record.map do |klass|
              :"#{klass.name.underscore}.#{args}"
            end
            defaults << options[:default] if options[:default]
            defaults.flatten!
            I18n.translate(defaults.shift, options.merge(:default => defaults, :scope => [:activerecord, scope]))
          end
          
        end
        
      end
      
    end
  end
end

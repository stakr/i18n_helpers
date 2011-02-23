module Stakr #:nodoc:
  module I18nHelpers #:nodoc:
    module Models #:nodoc:
      
      # Methods to return a localized example of a model attribute, using I18n.
      # 
      # See also HumanAttributeExample::ClassMethods
      module HumanAttributeExample
        
        def self.included(base) #:nodoc:
          base.extend(ClassMethods)
        end
        
        # See also HumanAttributeExample
        module ClassMethods
          
          # Returns a localized example of a model attribute, using I18n.
          # The method is intended to be used e.g. below an input field.
          # 
          # The excepted translation key is:
          # 
          #   activerecord.examples.[model_name].[attribute_key_name]
          # 
          # ==== Examples
          # 
          #   I18n.locale = :en
          #   User.human_attribute_example('password')   # => 'e.g. "secret"'
          #   
          #   I18n.locale = :de
          #   User.human_attribute_example('password')   # => 'z.B. "geheim"'
          # 
          def human_attribute_example(attribute_key_name, options = {})
            defaults = self_and_descendants_from_active_record.map do |klass|
              :"#{klass.name.underscore}.#{attribute_key_name}"
            end
            defaults << options[:default] if options[:default]
            defaults.flatten!
            defaults << attribute_key_name.to_s.humanize
            I18n.translate(defaults.shift, options.merge(:default => defaults, :scope => [:activerecord, :examples]))
          end
          
        end
        
      end
      
    end
  end
end

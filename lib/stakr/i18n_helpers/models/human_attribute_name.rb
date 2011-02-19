module Stakr #:nodoc:
  module I18nHelpers #:nodoc:
    module Models #:nodoc:
      
      # Methods to transform the name of a model attribute into a more humane format, using I18n.
      # 
      # See also HumanAttributeName::ClassMethods
      module HumanAttributeName
        
        def self.included(base) #:nodoc:
          base.extend(ClassMethods)
        end
        
        # See also HumanAttributeName
        module ClassMethods
          
          # Transforms the name of a model attribute into a more humane format, using I18n.
          # 
          # The excepted translation key is:
          # 
          #   activeresource.attributes.[model_name].[attribute_key_name]
          # 
          # ==== Examples
          # 
          #   I18n.locale = :en
          #   User.human_attribute_name('first_name')   # => 'First name'
          #   
          #   I18n.locale = :de
          #   User.human_attribute_name('first_name')   # => 'Vorname'
          # 
          def human_attribute_name(attribute_key_name, options = {})
            defaults = self_and_descendants_from_active_record.map do |klass|
              :"#{klass.name.underscore}.#{attribute_key_name}"
            end
            defaults << options[:default] if options[:default]
            defaults.flatten!
            defaults << attribute_key_name.to_s.humanize
            options[:count] ||= 1
            I18n.translate(defaults.shift, options.merge(:default => defaults, :scope => [i18n_top_level_key, :attributes]))
          end
          
        end
        
      end
      
    end
  end
end

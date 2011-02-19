module Stakr #:nodoc:
  module I18nHelpers #:nodoc:
    module Models #:nodoc:
      
      # Methods to return a localized description of a model attribute, using I18n.
      # 
      # See also HumanAttributeDescription::ClassMethods
      module HumanAttributeDescription
        
        def self.included(base) #:nodoc:
          base.extend(ClassMethods)
        end
        
        # See also HumanAttributeDescription
        module ClassMethods
          
          # Returns a localized description of a model attribute, using I18n.
          # The method is intended to be used e.g. for the description behind a checkbox.
          # 
          # The excepted translation key is:
          # 
          #   activerecord.descriptions.[model_name].[attribute_key_name]
          # 
          # ==== Examples
          # 
          #   I18n.locale = :en
          #   User.human_attribute_description('terms')   # => 'I accept all the terms.'
          #   
          #   I18n.locale = :de
          #   User.human_attribute_description('terms')   # => 'Ich akzeptiere alle moeglichen Nutzungsbedingungen.'
          # 
          def human_attribute_description(attribute_key_name, options = {})
            defaults = self_and_descendants_from_active_record.map do |klass|
              :"#{klass.name.underscore}.#{attribute_key_name}"
            end
            defaults << options[:default] if options[:default]
            defaults.flatten!
            defaults << attribute_key_name.to_s.humanize
            I18n.translate(defaults.shift, options.merge(:default => defaults, :scope => [i18n_top_level_key, :descriptions]))
          end
          
        end
        
      end
      
    end
  end
end

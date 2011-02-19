module Stakr #:nodoc:
  module I18nHelpers #:nodoc:
    module Models #:nodoc:
      
      # Methods to transform the name of a model into a more humane format, using I18n.
      # 
      # See also HumanName::ClassMethods
      module HumanName
        
        def self.included(base) #:nodoc:
          base.extend(ClassMethods)
        end
        
        # See also HumanName
        module ClassMethods
          
          # Transforms the name of a model into a more humane format, using I18n.
          # 
          # The excepted translation key is:
          # 
          #   activerecord.models.[model_name]
          #   activeresource.models.[model_name]
          # 
          # ==== Examples
          # 
          #   I18n.locale = :en
          #   User.human_name   # => 'User'
          #   
          #   I18n.locale = :de
          #   User.human_name   # => 'Nutzer'
          # 
          def human_name(options = {})
            defaults = self_and_descendants_from_active_record.map do |klass|
              :"#{klass.name.underscore}"
            end 
            defaults << self.name.humanize
            I18n.translate(defaults.shift, {:scope => [i18n_top_level_key, :models], :count => 1, :default => defaults}.merge(options))
          end
          
        end
        
      end
      
    end
  end
end

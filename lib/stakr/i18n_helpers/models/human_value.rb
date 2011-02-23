module Stakr #:nodoc:
  module I18nHelpers #:nodoc:
    module Models #:nodoc:
      
      # Methods to transform the value of a model attribute into a more humane format, using I18n.
      # 
      # See also HumanValue::ClassMethods
      module HumanValue
        
        def self.included(base) #:nodoc:
          base.extend(ClassMethods)
        end
        
        # Transforms the current value of a model attribute into a more humane format, using I18n.
        # 
        # The excepted translation key is:
        # 
        #   activerecord.values.[model_name].[attribute_key_name].[current_value]
        # 
        # ==== Examples
        # 
        #   user = User.new(:name => 'John', :gender => 'male', :enabled => false)
        #   
        #   I18n.locale = :en
        #   user.human_value('gender')    # => 'male'
        #   user.human_value('enabled')   # => 'disabled'
        #   
        #   I18n.locale = :de
        #   user.human_value('gender')    # => 'maennlich'
        #   user.human_value('enabled')   # => 'gesperrt'
        # 
        def human_value(attribute_key_name, options = {})
          if respond_to?(attribute_key_name)
            self.class.human_value(attribute_key_name, send(attribute_key_name), options)
          elsif respond_to?(:translation) && translation.respond_to?(attribute_key_name)
            translation.send(attribute_key_name)
          else
            self.class.human_value(attribute_key_name, nil, options)
          end
        end
        
        # See also HumanValue
        module ClassMethods
          
          # Transforms the specified value of a model attribute into a more humane format, using I18n.
          # 
          # The excepted translation key is:
          # 
          #   activerecord.values.[model_name].[attribute_key_name].[value]
          # 
          # ==== Examples
          # 
          #   I18n.locale = :en
          #   User.human_value('gender', 'male')    # => 'male'
          #   User.human_value('enabled', false)    # => 'disabled'
          #   
          #   I18n.locale = :de
          #   User.human_value('gender', 'male')    # => 'maennlich'
          #   User.human_value('enalbed', false)    # => 'gesperrt'
          # 
          def human_value(attribute_key_name, value, options = {})
            value = 'blank' if value.nil? || value == ''  # cannot use blank? here, because false returns also true for blank?
            value = 'true'  if value == true
            value = 'false' if value == false
            case value
            when Date, Time, DateTime
              I18n.localize(value, options)
            else
              defaults = []
              if options[:format]
                defaults << self_and_descendants_from_active_record.map do |klass|
                  :"#{klass.name.underscore}.#{attribute_key_name}.#{options[:format]}"
                end
              end
              defaults << self_and_descendants_from_active_record.map do |klass|
                :"#{klass.name.underscore}.#{attribute_key_name}.#{value}"
              end
              if value.is_a?(Fixnum)
                # TODO: this is wrong: add :count => value to options instead
                case value
                when 0
                  defaults << self_and_descendants_from_active_record.map do |klass|
                    :"#{klass.name.underscore}.#{attribute_key_name}.zero"
                  end
                when 1
                  defaults << self_and_descendants_from_active_record.map do |klass|
                    :"#{klass.name.underscore}.#{attribute_key_name}.one"
                  end
                else
                  defaults << self_and_descendants_from_active_record.map do |klass|
                    :"#{klass.name.underscore}.#{attribute_key_name}.other"
                  end
                end
              end
              defaults << self_and_descendants_from_active_record.map do |klass|
                :"#{klass.name.underscore}.#{attribute_key_name}"
              end
              defaults << options[:default] if options[:default]
              defaults.flatten!
              defaults << value.to_s.humanize
              I18n.translate(defaults.shift, options.merge(:default => defaults, :value => value, :scope => [:activerecord, :values]))
            end
          end
          
        end
        
      end
      
    end
  end
end

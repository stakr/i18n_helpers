module Stakr #:nodoc:
  module I18nHelpers #:nodoc:
    module Models #:nodoc:
      
      # TODO
      # 
      # See also ModelTranslation::ClassMethods
      module ModelTranslation
        
        def self.included(base) #:nodoc:
          base.extend(ClassMethods)
        end
        
        # See also ModelTranslation
        module ClassMethods
          
          def translatable(options = {})
            options = options.with_indifferent_access
            
            base_class_name       = name
            association_name      = options[:association_name] || sti_name.underscore
            foreign_key           = options[:foreign_key] || "#{association_name}_id"
            
            translated_class_name = options[:class_name] || "#{name}Translation"
            translated_class      = translated_class_name.constantize
            table_name            = translated_class.table_name
            
            # add declarations to base class
            named_scope :translated, :include => :translation, :conditions => "#{connection.quote_table_name(table_name)}.#{connection.quote_column_name('id')} IS NOT NULL"
            
            has_many :translations, :class_name => translated_class_name, :foreign_key => foreign_key, :dependent => :destroy
            has_one  :translation, :class_name => translated_class_name, :foreign_key => foreign_key, :conditions => "#{connection.quote_table_name(table_name)}.#{connection.quote_column_name('locale')} = \#{#{name}.connection.quote(I18n.locale.to_s)}"
            
            # add declarations to translated class
            translated_class.class_eval <<-END_OF_RUBY, __FILE__, __LINE__ + 1
              
              belongs_to :#{association_name}, :class_name => '#{base_class_name}'
              
              named_scope :locale, lambda { |locale|
                { :conditions => { :locale => locale.to_s } } # to_s ensures not to search for a symbol
              }
              
              validates_inclusion_of :locale, :in => LOCALES
              validates_uniqueness_of :locale, :scope => :#{foreign_key}
              
            END_OF_RUBY
            
          end
          
        end
        
      end
      
    end
  end
end

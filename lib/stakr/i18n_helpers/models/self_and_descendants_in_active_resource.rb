module Stakr #:nodoc:
  module I18nHelpers #:nodoc:
    module Models #:nodoc:
      
      module SelfAndDescendantsInActiveResource #:nodoc:
        
        def self.included(base) #:nodoc:
          base.extend(ClassMethods)
        end
        
        module ClassMethods #:nodoc:
          
          # Dummy implementation in order to behave like ActiveRecord::Base
          def self_and_descendants_from_active_record
            [self]
          end
          
        end
        
      end
      
    end
  end
end

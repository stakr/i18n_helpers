require 'stakr/i18n_helpers/controller'

require 'stakr/i18n_helpers/helper'

require 'stakr/i18n_helpers/models/human_attribute_description'
require 'stakr/i18n_helpers/models/human_attribute_example'
require 'stakr/i18n_helpers/models/human_attribute_name'
require 'stakr/i18n_helpers/models/human_name'
require 'stakr/i18n_helpers/models/human_value'
require 'stakr/i18n_helpers/models/model_translation'
require 'stakr/i18n_helpers/models/self_and_descendants_in_active_resource'

::ActionController::Base.class_eval do
  include ::Stakr::I18nHelpers::Controller
end

::ActionView::Helpers.module_eval do
  include ::Stakr::I18nHelpers::Helper
  alias :t :translate
end

::ActiveRecord::Base.class_eval do
  
  def self.i18n_top_level_key
    :activerecord
  end
  
  include ::Stakr::I18nHelpers::Models::HumanAttributeDescription
  include ::Stakr::I18nHelpers::Models::HumanAttributeExample
  include ::Stakr::I18nHelpers::Models::HumanValue
  include ::Stakr::I18nHelpers::Models::ModelTranslation
end

::ActiveResource::Base.class_eval do
  
  def self.i18n_top_level_key
    :activeresource
  end
  
  include ::Stakr::I18nHelpers::Models::SelfAndDescendantsInActiveResource
  include ::Stakr::I18nHelpers::Models::HumanName
  include ::Stakr::I18nHelpers::Models::HumanAttributeName
  include ::Stakr::I18nHelpers::Models::HumanAttributeDescription
  include ::Stakr::I18nHelpers::Models::HumanAttributeExample
  include ::Stakr::I18nHelpers::Models::HumanValue
end

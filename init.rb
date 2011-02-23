require 'stakr/i18n_helpers/controller'

require 'stakr/i18n_helpers/helper'

require 'stakr/i18n_helpers/models/human_attribute_description'
require 'stakr/i18n_helpers/models/human_attribute_example'
require 'stakr/i18n_helpers/models/human_message'
require 'stakr/i18n_helpers/models/human_value'
require 'stakr/i18n_helpers/models/model_translation'

ActionController::Base.class_eval do
  include Stakr::I18nHelpers::Controller
end

ActionView::Helpers.module_eval do
  include Stakr::I18nHelpers::Helper
  alias :t :translate
end

ActiveRecord::Base.class_eval do
  include Stakr::I18nHelpers::Models::HumanAttributeDescription
  include Stakr::I18nHelpers::Models::HumanAttributeExample
  include Stakr::I18nHelpers::Models::HumanMessage
  include Stakr::I18nHelpers::Models::HumanValue
  include Stakr::I18nHelpers::Models::ModelTranslation
end

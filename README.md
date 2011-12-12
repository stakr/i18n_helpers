# Internationalization (I18n) Helpers

Written by stakr GbR (Jan Sebastian Siwy, Martin Spickermann, Henning Staib GbR; http://www.stakr.de/)

Source: https://github.com/stakr/i18n_helpers

A plugin to transform values and descriptions of a model attribute into a more humane format, using I18n.


## Example

Transforming the value of a model attribute:

    user = User.new(:name => 'John', :gender => 'male', :enabled => false)

    I18n.locale = :en
    user.human_option_name('gender')    # => 'male'
    user.human_option_name('enabled')   # => 'disabled'

    I18n.locale = :de
    user.human_option_name('gender')    # => 'maennlich'
    user.human_option_name('enabled')   # => 'gesperrt'

Transform the description of a model attribute:

    I18n.locale = :en
    User.human_attribute_description('terms')   # => 'I accept all the terms.'

    I18n.locale = :de
    User.human_attribute_description('terms')   # => 'Ich akzeptiere alle moeglichen Nutzungsbedingungen'

Auto-prefixed translation keys in controllers:

    # PostController, action edit
    t('.flash.notice')      # used translation keys:
                            #   controllers.post.update.flash.notice
                            #   controllers.application.update.flash.notice
                            #   controllers.post.flash.notice
                            #   controllers.application.flash.notice

Auto-prefixed translation keys in views and helpers:

    # View 'post/edit.html.erb'
    t('.description')       # used translation keys:
                            #   views.post.edit.description
                            #   views.shared.description

Copyright (c) 2009 stakr GbR (Jan Sebastian Siwy, Martin Spickermann, Henning Staib GbR), released under the MIT license

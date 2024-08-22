# frozen_string_literal: true

# name: samsung-dkms-01
# about: This plugin encrypt all the emails present in discouse DB and discourse logs.
# meta_topic_id: 001
# version: 0.0.1
# authors: Pankaj
# url: https://github.com/Nilay1004/samsung-dkms/blob/main/README.md
# required_version: 2.7.0

enabled_site_setting :samsung_dkms_plugin_enabled

unless defined?(::MyPluginModule)
  module ::MyPluginModule
    PLUGIN_NAME = "samsung-dkms"
  end
end

# Loads the extensions defined in the lib/extensions directory.
require_relative "lib/pii_encryption"

after_initialize do

  module ::SamsungDkms
    PLUGIN_NAME ||= "samsung-dkms-01"

    class Engine < ::Rails::Engine
      engine_name PLUGIN_NAME
      isolate_namespace SamsungDkms
    end
  end

#  require_relative 'lib/extensions/emaillog_extension'
  require_relative 'lib/extensions/emailtoken_extension'
  require_relative 'lib/extensions/emailvalidator_extension'
  require_relative 'lib/extensions/invite_extension'
  require_relative 'lib/extensions/sessioncontroller_extension'
#  require_relative 'lib/extensions/skippedemaillog_extension'
#  require_relative 'lib/extensions/user_extension'
  require_relative 'lib/extensions/useremail_extension'

  
  require_relative "lib/samsung_dkms/emaillog_patch"
  require_relative 'lib/samsung_dkms/skippedemaillog_patch'
  require_relative 'lib/samsung_dkms/user_patch'  

  reloadable_patch do |plugin|
    EmailLog.prepend(SamsungDkms::EmailLogPatch)
    SkippedEmailLog.prepend(SamsungDkms::SkippedEmailLogPatch)
    User.prepend(SamsungDkms::UserPatch)
  end
end



  
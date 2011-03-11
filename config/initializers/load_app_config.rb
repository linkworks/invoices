require 'ostruct' # To convert configuration to object

raw_config = File.read("#{Rails.root}/config/app_config.yml")
APP_CONFIG = YAML.load(raw_config)[Rails.env].symbolize_keys

AppConfig = OpenStruct.new(APP_CONFIG)
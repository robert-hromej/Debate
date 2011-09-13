require "fileutils"

config_file = "#{::Rails.root.to_s}/config/settings.yml"
template_config_file = "#{::Rails.root.to_s}/config/templates/settings.yml"

# create settings file from template if it does not exist
FileUtils.copy(template_config_file, config_file) unless File.exists?(config_file)

APP_CONFIG = YAML.load_file("#{::Rails.root.to_s}/config/settings.yml")[::Rails.env]

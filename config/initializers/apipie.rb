Apipie.configure do |config|
  config.app_name                = "ChatRails"
  config.api_base_url            = "/api/v1"
  config.doc_base_url            = "/apipie"
  config.translate               = false
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end

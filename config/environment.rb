# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
Rails.application.default_url_options = { host: '127.0.0.1:3000' }

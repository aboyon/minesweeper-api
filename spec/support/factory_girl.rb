require 'factory_girl'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

Dir[Rails.root.join('spec/factories/**/*.rb')].each { |f| require f }
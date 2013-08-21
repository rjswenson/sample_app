source 'https://rubygems.org'
ruby '2.0.0' 
#ruby-gemset=railstutorial_rails_4_0
gem 'rails', '4.0.0'
gem 'bootstrap-sass', '2.3.2.0'              #adds twitter-style sass/scss design
gem 'bcrypt-ruby', '3.0.1'                   #allows for easy pwd encription
group :development, :test do
  gem 'sqlite3', '1.3.7'
  gem 'rspec-rails', '2.13.1'                #Rspec for tests
end
group :test do
  gem 'selenium-webdriver', '2.0.0'
  gem 'capybara', '2.1.0'                    #adds db testing to rspec
end
gem 'sass-rails', '4.0.0'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.0'
gem 'jquery-rails', '2.2.1'
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'
gem 'factory_girl_rails', '4.2.1'           #creates users for testing page
group :doc do
  gem 'sdoc', '0.3.20', require: false
end
group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end
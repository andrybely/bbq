source 'https://rubygems.org'

# зависим от рельсов 4.2.*
gem 'rails', '~> 4.2.6'

gem 'devise'
gem 'devise-i18n'

gem 'russian'

gem 'omniauth'
gem 'omniauth-vkontakte', '1.3.7'

# гем, интегрирующий bootstrap
gem 'twitter-bootstrap-rails'

gem 'uglifier', '>= 1.3.0'

# для поддержки jquery
gem 'jquery-rails'

gem 'carrierwave'

gem 'rmagick'
group :production do
  gem 'pg'
end
# в продакшен сервере heroku этот гем соединяет с базой данных Postgres
group :development, :test do
  gem 'sqlite3'
  gem 'byebug'
end


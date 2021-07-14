source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby IO.read(".ruby-version").strip

gem "autoprefixer-rails",    "~> 6.6.1"
gem "barby",                 "~> 0.6.8"
gem "bibtex-ruby",           "~> 5.1.0", require: "bibtex"
gem "bootstrap-sass",        "~> 3.4.1"
gem "browser",               "~> 2.2.0"
gem "cancancan",             "~> 1.15"
gem "coffee-rails",          "~> 5.0.0"
gem "dotenv-rails",          "~> 2.7.5"
gem "font-awesome-rails",    "~> 4.7.0"
gem "htmlentities",          "~> 4.3.4"
gem "i18n-backend-advanced", "~> 0.1.3"
gem "i18n-js",               "~> 3.2.3"
gem "jbuilder",              "~> 2.6"
gem "jquery-rails",          "~> 4.1.1"
gem "jquery-tablesorter",    "~> 1.21"
gem "jquery-turbolinks",     "~> 2.1.0"
gem "jquery-ui-rails",       "~> 5.0.5"
gem "mysql2",                ">= 0.4.4"
gem "ox",                    "~> 2.8.1"
gem "parallel",              "~> 1.19"
gem "puma",                  ">= 3.11"
gem "rails",                 "~> 6.0.0"
gem "rails-html-sanitizer",  "~> 1.2.0"
gem "rails-i18n",            "~> 6.0.0"
gem "rinku",                 "~> 2.0.0"
gem "roadie-rails",          "~> 2.1.0"
gem "sass-rails",            "~> 5"
gem "simple_form",           "~> 5.0.0"
gem "slim",                  "~> 3.0"
gem "sqlite3",               "~> 1.3"
gem "turbolinks",            "~> 2.5.3"
gem "uglifier",              "~> 3.0"
gem "wicked_pdf",            "~> 2.1.0", require: false # Don't require here. Strange bug when using the account section otherwise.
gem "wkhtmltopdf-binary",    ">= 0.12.6"

gem "bootsnap", ">= 1.4.2", require: false

gem "aleph_api", "~> 0.3.0", path: "vendor/gems/aleph_api"
gem "skala", "~> 1.2.0", path: "vendor/gems/skala"

#
# rails-assets.org
#
# Better use three component version numbers (~> x.y.z) because js assets often
# change structure/behaviour within minor version updates.
#
source "https://rails-assets.org" do
  gem "rails-assets-animate.css",                 "~> 3.4.0"
  gem "rails-assets-imagesloaded",                "~> 3.2.0"
  gem "rails-assets-jaubourg--jquery-jsonp",      "~> 2.4.0"
  gem "rails-assets-lodash",                      "~> 3.0"
  gem "rails-assets-matchHeight",                 "~> 0.5"
  gem "rails-assets-ractive",                     "~> 0.7.3"
  gem "rails-assets-ractive-events-keys",         "~> 0.2.1"
  gem "rails-assets-relayfoods-jquery.sparkline", "~> 2.1.4"
  gem "rails-assets-urijs",                       "~> 1.16.1"
end

group :production do
  gem "newrelic_rpm", ">= 4.5.0"
end

group :development, :test do
  gem "letter_opener_web", "~> 1.0"
  gem "pry-byebug", ">= 3.6", platform: :mri
  gem "pry-rails",  ">= 0.3", platform: :mri
end

group :development do
  gem "capistrano",           "~> 3.11"
  gem "capistrano-bundler",   "~> 1.6.0"
  gem "capistrano-passenger", "~> 0.2.0"
  gem "capistrano-rails",     "~> 1.4.0"
  gem "capistrano-rvm",       "~> 0.1.2"
  gem "web-console",          ">= 3.3.0"
  gem "listen",               ">= 3.0.5", "< 3.2"
end

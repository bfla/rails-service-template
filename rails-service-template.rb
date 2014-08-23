include_admin if yes?("Do you want to include an admin interface for this service?")

# Create gemfile and install it all ===========================================
gem 'compass-rails'
gem 'bootstrap-sass', '~> 3.0.3.0'
gem 'slim-rails' #use SLIM markup instead of .erb

if include_admin
  gem 'devise'
end

gem 'typhoeus'
gem 'json'
gem 'unicorn'

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails', "~> 4.0"
end

gem_group :production do
  gem 'rails_12factor'
  gem 'pg'
end

run "bundle install"

# Create application.html.slim as SLIM ======================================================================
run "rm app/views/layouts/application.html.erb"
file "app/views/layouts/application.html.slim", <<-CODE
doctype html
html.fill-height
  head
    title == yield :title
    meta name="description" content=yield(:description)
    meta name="viewport" content="width=device-width, initial-scale=1.0"
    / meta tags
    == yield :head

    / styles
    == render 'shared/headstyles'
    == yield :extra_stylesheets

    / scripts
    == render 'shared/headscripts'
    == yield :head_javascripts

  body class="#{yield :body_class || fill-height.background}"
    - if notice
        .col-md-10.col-md-offset-1.pad-top-xl
            .panel.panel-primary
                .panel-heading 
                    | Notice
                    #panelClose.button.close type="button" data-dismiss="panel" aria-hidden="true" &times;
                .panel-body = notice
    - if alert
        .col-md-10.col-md-offset-1.pad-top-xl
            .panel.panel-warning
                .panel-heading 
                    | Alert
                    #panelClose.button.close type="button" data-dismiss="panel" aria-hidden="true" &times;
                .panel-body.alert = alert

    == yield :extra_modals

    / Top navbar goes here
    == render 'shared/navbar'

    .container.pad-top-lg
      / Body goes here
      == yield

    / Footer goes here
    == render 'shared/footer'
    
    == yield :end
    == render 'shared/bottomScripts'

CODE

# Add Shared Partials ===========================================================================================
run "mkdir app/views/shared"
file "app/views/shares/_bottomScripts.html.slim"
file "app/views/shared/_navbar.html.slim", <<-CODE
/ This isn't really done properly for mobile.  Should be fixed later.
nav.navbar.navbar-fixed-top.navbar-inverse.navbar-color.navbar-border role="navigation"
  .container
    / Brand and toggle get grouped for better mobile display
    .navbar-header
      button.navbar-toggle type="button" data-toggle="collapse" data-target="#bs-collapsable"
        span.sr-only Toggle navigation
        span.icon-bar
        span.icon-bar
        span.icon-bar
      a.navbar-brand.brand href=root_path SnackSleuth
      ul.nav.navbar-nav
        li = link_to 'Home', root_path
CODE

file "app/views/shared/_headstyles.html.slim", <<-CODE
= stylesheet_link_tag "application", media: "all", "data-turbolinks-track" => true
link href='http://fonts.googleapis.com/css?family=Monda' rel='stylesheet' type='text/css'
CODE

file "app/views/shared/_headscripts.html.slim", <<-CODE
= javascript_include_tag "application", "data-turbolinks-track" => true
= csrf_meta_tags
CODE

file "app/views/shared/_footer.html.slim", <<-CODE
#footer.nav.navbar.navbar-default role="navigation"
  p.navbar-text 
    | Chompy &copy; 
    = Time.now.year
  /ul.nav.navbar-nav
    /li = link_to "Terms", terms_path
CODE

# Add bootstrap to javascript ==============================================================================================
run "rm app/assets/javascripts/application.js"
file 'app/assets/javascripts/application.js', <<-CODE
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .
CODE

file 'app/assets/javascripts/shared.js.coffee', <<-CODE # Create a shared.js.coffee file
$ ->
  $("#panelClose").click ->
    $('.panel').hide()
CODE

# Add Styles using Compass ==================================================================================================
run "rm app/assets/stylesheets/application.css" # Delete original application.css file

# Add the application.scss file
file "app/assets/stylesheets/application.css.scss", <<-CODE
  
CODE

# Add the base stylesheet ====================================================================================================
file "app/assets/stylesheets/_base.css.scss", <<-CODE
// Universal styles=================================
.white {
  background:#ffffff;
  opacity:1.0;
}

.dark-grey {      color:$dark-slate-grey; }

.background {     background: $background-color; }

.subtle-text {    color: $light-grey; }

.margin-left-sm { margin-left:$sm-spacing; }

.margin-top-sm {  margin-top:$sm-spacing; }

.remove-margin-top {margin-top:0px;}

.remove-bottom-margin {margin-bottom:0px;}

.pad-heading {     padding-top: $xl-spacing; }

.pad-left-sm {    padding-left: $sm-spacing; }

.pad-top-sm {     padding-top:$sm-spacing; }

.pad-top-md {     padding-top: $md-spacing; }

.pad-top-lg {     padding-top: $md-spacing; }

.pad-top-xl {     padding-top: $xl-spacing; }

.pad-bottom-sm {  padding-bottom:$sm-spacing; }

.pad-bottom-huge { padding-bottom:200px;}

.no-spacing { 
                  padding:0px;
                  margin:0px;}

h1 {              font-family:$brand-font;}

.orange {
  color:$orange;
}

.huge {
  font-size:50px;
}

.promo-subtitle {
  font-size:24px;
}

.promo-paragraph {
  color:$dark-slate-grey;
}

.calories-form {
  height:54px;
}

.my-btn {
  background-color:$orange;
  border-color:$orange;
  &:active { 
    background-color: $dark-orange;
    border-color: $dark-orange;
  }
  &:hover {
    background-color: $dark-orange;
    border-color: $dark-orange;
  }
  &:focus {
    background-color: $dark-orange;
    border-color: $dark-orange;
  }
}

// Banner styles=================================
@import 'navbar';
.brand {
                  font-family: $brand-font;
                  color: $brand-color;
                  border: $dark-brand-color;

  &:visited {     color: $brand-color; }
  &:hover {       color: $dark-brand-color; }
}

// Footer style====================================
#footer {
                  background:none;
                  border:none;
                  box-shadow:none;
                  height:$footer-height;}

// Sticky footers==================================
.fill-height {    height:100%;} // add this to a body & html elements
#wrap {           min-height:100%;} // add this around the main page content
  
#main { // add this to the main content or container div
                  overflow:auto;
                  padding-bottom:$footer-height;}
.flush-footer { // surround footer partial with this div
                  position:relative;
                  margin-top:-$footer-height;
                  padding-top:$md-spacing;
                  clear:both;}
CODE

# Add the mixins stylesheet
file "app/assets/stylesheets/_mixins.css.scss", <<-CODE
// Spacing variables ======================
$xl-spacing: 70px;
$md-spacing: 20px;
$sm-spacing: 10px;
$top-navbar-height: 50px;
$footer-height: 50px;

// Color pallette =============================
$dark-cyan: rgb(0,143,170);
$light-grey: #b2b2b2;
$extra-light-grey: #E1E1E1;
$dark-slate-grey: #4c4d50;
$md-slate-grey: #84858a;
$orange: rgb(255,136,51);
$dark-orange: darken($orange, 5%);

// Custom colors
$brand-color: $orange;
$dark-brand-color: darken($brand-color, 5%);
// $navColor: $orange;
$nav-color: rgba(241,242,243, 0.5);
$nav-link-color: $md-slate-grey;
//$navLinkColor: $extraLightGray;
$nav-link-hover: white;
$background-color: white;

// Font variables
$brand-font: 'Verdana';

// Bootstrap mixins

CODE

# Add the scaffold stylesheet
file "app/assets/stylesheets/scaffold.css.scss", <<-CODE
.scaffold {
  h1 {
    @extend .pad-heading;
    @extend .text-center;
  }
  form {
    @extend .col-md-offset-3;
    @extend .col-md-6;
  }
}


h1 {
}

body {
  /*background-color: #fff;
  color: #333;
  font-family: verdana, arial, helvetica, sans-serif;
  font-size: 13px;
  line-height: 18px;*/
}

p, ol, ul, td {
  /*font-family: verdana, arial, helvetica, sans-serif;
  font-size: 13px;
  line-height: 18px;*/
}

pre {
  /*background-color: #eee;
  padding: 10px;
  font-size: 11px;*/
}

a {
  /*color: #000;
  &:visited {
    color: #666;
  }
  &:hover {
    color: #fff;
    background-color: #000;
  }*/
}

div {
  /*&.field {
    margin-bottom: 10px;
  }*/
}

.field {
  @extend .form-group;
  input {
    @extend .form-control;
  }
  textarea {
    @extend .form-control;
  }
}

.actions {
  input {
    @extend .btn;
    @extend .btn-primary;
    @extend .text-center;
  }
}

#notice {
  color: green;
}

.field_with_errors {
  padding: 2px;
  background-color: red;
  display: table;
}

table {
  @extend .table;
  @extend .table-striped;
}

#error_explanation {
  width: 450px;
  border: 2px solid red;
  padding: 7px;
  padding-bottom: 0;
  margin-bottom: 20px;
  background-color: #f0f0f0;
  h2 {
    text-align: left;
    font-weight: bold;
    padding: 5px 5px 5px 15px;
    font-size: 12px;
    margin: -7px;
    margin-bottom: 0px;
    background-color: #c00;
    color: #fff;
  }
  ul li {
    font-size: 12px;
    list-style: square;
  }
}
CODE

# Add Procfile ================================================================
file "Procfile", <<-CODE
web: bundle exec unicorn -p $PORT -E $RACK_ENV
CODE

# Add unicorn.rb ==============================================================
file "config/unicorn.rb", <<-CODE
# config/unicorn.rb
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
CODE

# Add static pages and controller structure... ========================================================
run "mkdir /app/controllers/api"
run "mkdir /app/controllers/api/v1"
file "app/controllers/pages_controller.rb", <<-CODE
class PagesController < ApplicationController
  #before_action :verify_authority
  #skip_before_action :verify_authority, only: [:unauthorized, :home]
  #before_action :authenticate_admin!

  def home
  end

  def unauthorized
  end
end
CODE

# Configure routes and Devise (if appropriate) ========================================================
if include_admin
  generate(:scaffold, "admin")
  rake("db:migrate")

  run "rm /config/routes.rb", <<-CODE
  devise_for :admins
  devise_scope :admin do
    get "sign_in", to: "devise/sessions#new", as:"sign_in"
  end
  namespace :api do
    namespace :v1 do
      resources :puzzles
    end
  end
  root to:"pages#home"
  get :unauthorized, to:"pages#unauthorized", as:"unauthorized"
  CODE
else
  run "rm /config/routes.rb", <<-CODE
  namespace :api do
    namespace :v1 do
      resources :puzzles
    end
  end
  root to:"pages#home"
  get :unauthorized, to:"pages#unauthorized", as:"unauthorized"
  CODE

end

# Place it under version control and commit the initial project
run "rm .gitignore"
file ".gitignore", <<-CODE
# Ignore bundler config.
/.bundle

# Ignore the default SQLite database.
/db/*.sqlite3
/db/*.sqlite3-journal

# Ignore all logfiles and tempfiles.
/log/*.log
/tmp
.DS_Store
.env
/public/images/system
CODE

git :init
git add: "."
git commit: %Q{ -m 'Initial commit' }

puts "you still need to do a few things..."
puts "1. put sqlite into the dev and test groups only"
puts "2. add authorization to actions that should require it"
puts "3. send it to your github repo!"
puts "4. deploy it to heroku"
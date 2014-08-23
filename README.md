rails-service-template
======================

Create a badass, fully-stacked, Rails service in just a few seconds.<br>
<br>
This is my preferred setup for a Rails service.  Rather than create 100 identical services, I automated the process so that I can customize only the parts that really need customization.<br>
<br>
The template lays out the basic structure for the service and is easy to customize.<br>

It includes a basic front-end for interacting with the service.<br>

<strong>Included gems</strong><br>
1. SLIM for markup<br>
3. Compass/Sass with Twitter Bootstrap (bootstrap-sass gem) for styles<br>
4. Unicorn & Heroku for deployment<br>
5. Typhoeus and JSON for API interactions (If you want something else, you can just remove these from the Gemfile. It shouldn't cause any problems.)<br>
6. (Optional) Devise admin interface<br>
7. RSpec and FactoryGirl
<br>

<strong> Getting started</strong><br>
1. Create the app: rails new my_app -m https://github.com/bfla/rails-service-template/rails-service-template.rb
2. Go to your Gemfile and move sqlite3 into the development/test group
3. 

<strong>Views</strong><br>
1. Application.html.slim: Assumes a normal but minimalist webpage layout with a navbar and footer. <br>
2. Partials that I practically always use in layouts: navbar, headscripts, headstyles, bottomScripts. <br>

<strong>Styles</strong><br>
1. Application.css.scss will import compass, bootstrap sass, _mixins.css.scss, _base.css.scss, and scaffold.css.scss. <br>
2. There are some predefined classes and styling in the _base.css.scss file.  These are basic classes that I normally use.<br>
3. Mixins sets variables that customize the look of the pages.  You can set the color scheme, etc.<br>
4. Rails scaffolds are ugly by default.  I allow for custom styling.  To add some nicer styling, just add this to the top of any scaffold view:<br>
<br>
content_for :body_class, "scaffold"<br>
<br>
<strong>Javascript</strong><br>
1. The application.js file will import Twitter Bootstrap javascript appropriately<br>
2. The shared.js.coffee file is for basic javascripts that are commonly included on multiple pages. (Initializing Bootstrap tooltips, making it so users can close panel notifications, etc...)  <br>
<br>
<strong>Controllers</strong><br><br>
1. It will create a pages_controller for your static pages: #home, #forbidden, #contact, #terms, or whatever...<br>
2. It will create a directory to store the service api controllers: '/controllers/api/v1'<br>
3. It won't put anything into the '/controllers/api/v1' directory.  Adding the model is up to you.<br>
<br>
<strong> Optional Devise admin</strong><br>
When you run the template, it will ask if you want an admin template included.  If you say yes, it will do some stuff:<br>
1. Include devise in the Gemfile<br>
2. Create an Admin scaffold<br>
3. Attach devise to the admin model and run rake db:migrate<br>
4. Create a devise route for :admins <br>
5. Scope the devise route so that you can access it at this path: example.com/sign_in
6. Include my customized devise views

<strong> Testing </strong><br>
1. RSpec: will be installed and setup to use FactoryGirl<br>
2. FactoryGirl: will be installed and factories.rb file will be created.<br>

<strong> Deployment</strong><br>
1. Heroku <br>
2. Postgres <br>
2. Unicorn (Procfile and unicorn.rb)<br>
3. To deploy: ...<br>

<strong> Version control</strong><br>
1. When you run the template, the initial project will be added to git version control and committed<br>
2. .gitignore now ignores .DS_Store, .env, and /images/system <br>

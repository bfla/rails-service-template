rails-service-template
======================

Create an badass, fully-stacked, Rails service in just a few seconds

This is my preferred setup for a Rails service.  Rather than create 100 identical services, I automated the process.

The template lays out the basic structure for the service and is easy to customize.  

It includes a basic front-end for interacting with the service.

<em>Included gems</em>
1. SLIM for markup
3. Compass/Sass with Twitter Bootstrap (bootstrap-sass gem) for styles
4. Unicorn & Heroku for deployment
5. Typhoeus and JSON for API interactions (If you want something else, you can just remove these from the Gemfile. It shouldn't cause any problems.)
6. (Optional) Devise admin interface

<em>Views</em>
1. Application.html.slim: Assumes a normal but minimalist webpage layout with a navbar and footer.  It
2. Partials that I practically always use in layouts: navbar, headscripts, headstyles, bottomScripts

<em>Styles</em>
1. Application.css.scss will import compass, bootstrap sass, _mixins.css.scss, _base.css.scss, and scaffold.css.scss
2. There are some predefined classes and styling in the _base.css.scss file.  These are basic classes that I normally use.
3. Mixins sets variables that customize the look of the pages.  You can set the color scheme, etc.
4. Rails scaffolds are ugly by default.  I allow for custom styling.  To add some nicer styling, just add this to the top of any scaffold view:

- content_for :body_class, "scaffold"

<em>Javascript</em>
1. The application.js file will import Twitter Bootstrap javascript appropriately
2. The shared.js.coffee file is for basic javascripts that are commonly included on multiple pages. (Initializing Bootstrap tooltips, making it so users can close panel notifications, etc...)  

<em>Controllers</em>
1. It will create a pages_controller for your static pages: #home, #forbidden, #contact, #terms, or whatever...
2. It will create a directory to store the service api controllers: '/controllers/api/v1'
3. It won't put anything into the '/controllers/api/v1' directory.  Adding the model is up to you.

<em> Optional Devise admin</em>
When you run the template, it will ask if you want an admin template included.  If you say yes, it will do some stuff:
1. Include devise in the Gemfile
2. Create an Admin scaffold
3. Attach devise to the admin model
4. Create a devise route for :admins 
5. Scope the devise route so that you can access it at this path: example.com/sign_in
6. Include my customized devise views

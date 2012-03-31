# Lodos

Lodos is a sample TODOS application which uses Ember.js and Ruby on Rails to achieve a simple task management goal.

It aims to be a really responsive example of a TODOS application with data persisted on a rails application.
Things are not done quite on the right way, but does the job of showing nice parts of all the technologies used.

BDD was used, via capybara-webkit and cucumber features were described in english and the tests could test even the javascript parts quite well.

I am getting used to ember-data (as well as it is getting used to the world, api is changing a lot because it's new) so I guess things here could be done better when me and ember-data are done with all that stuff.

Validations are working quite weird, because they are done both on client side and on server side, that's because I didn't want to go so deep in ember-data's behavior right now to make validations on server side reflect on the client, so I wrote them twice, as we have few fields to validate it's an ok approach.

There is absolutely no effort on security or user sessions.

There is an example application running this code: http://lodos.herokuapp.com

## Technologies and Resources

* Ruby on Rails
* MongoDB (via Mongoid)
* Ember.js
  * [ember-data](http://github.com/ember/data)
  * [ember-formbuilder](http://github.com/luan/ember-formbuilder)
  * [ember-layout](http://github.com/ghempton/ember-layout)
  * [ember-routemanager](http://github.com/ghempton/ember-routemanager)
  * [ember-flash](http://github.com/cheapRoc/ember-flash)
* RSpec, Capybara, Capybara-WebKit and Cucumber for testing
* ... some more stuff, check Gemfile.
# TestCrowd

*A pre-crowdfunding platform, which I had formerly built in Drupal (2014).*

## objectives

Crowdfunding campaigners are able to try out their crowdfunding project and upload videos, images and text. Their supporters leave feedback in the form of star ratings, endorsements and comments. This is valuable for campaigners, as it helps them improve their campaign before they go live on their crowdfunding platform of choice.

## technologies

- Ruby on Rails 5.1
- *TDD:* rspec / capybara / Factory Girl
- *user management:* devise / pundit
- Ajax
- PostgreSQL

## instructions

In order to set up a development environment and run the tests, these two database need to be present:

~~~
  ... $ psql
  ... =# CREATE DATABASE "testcrowd_test";
  ... =# CREATE DATABASE "testcrowd_development";
  ... =# \q
~~~

then generate the necessary database structure:

~~~
    ... $ rails db:migrate
~~~

make sure all gems are up to date and start the server:

~~~
	... $ bundle install
	... $ rails s
~~~

Go to your browser and you should see the site at http://localhost:3000 
If not, check the port number in the command line.


## specification

* users can register, log in, log out and manage their own user data
* users can determine whether they are logged in from the greeting message at the top, which contains their email address
* two user groups: all users can leave ratings/reviews/endorsements, project owners can also create projects
* every project has its own page containing name, description, list of reviews with reviewer name and ratings
* project names must be at least three characters long, ratings must be between 1 and 5, reviews are optional
* users can log in with Facebook

*users who are logged in are able to:*

* see the project listings page with reviews, ratings and an add review link
* create, edit and delete their own projects, but not those of other users. **at present the status of a user can only be elevated manually to project owner, by setting the admin column in the database to 'true'**
* create and delete their own reviews, but not those of other users
* add a review text and a numerical rating to a project, but not more than once
* reviews can be endorsed

### future development:

* a better way to handle admin rights
* a user name will be displayed next to each review
* through a form, users are able to embed presentations or upload media to their projects
* users cannot endorse their own reviews
* project owners can't review their own projects
* project owners cannot endorse reviews on their own project
* a superuser, who can manage access levels for users & project owners through a dashboard
* users can log in with Twitter
* notification system for project owners
# TestCrowd

*A pre-crowdfunding platform, which I had formerly built in Drupal (2014).*

## objectives

Crowdfunding campaigners are able to try out their crowdfunding project and upload videos, images and text. This will enable their supporters to leave feedback in the form of star ratings, endorsements and comments, which helps campaigners to improve their campaign before they go live on their crowdfunding platform of choice.

## technologies

- Ruby on Rails 5.0.4
- *TDD:* rspec / capybara / Factory Girl
- *user management:* devise / pundit

## specification

* users can register, log in, log out and manage their own user data
* users can determine whether they are logged in from the greeting message at the top, which contains their email address
* two different user groups: all users can leave ratings/reviews, admin users can also create projects
* every project has its own page containing name, description, list of reviews with reviewer name and ratings
* project names must be at least three characters long, ratings must be between 1 and 5, reviews are optional
* users can log in with Facebook

*users who are logged in are able to:*

* see the project listings page with reviews, ratings and an add review link
* create, edit and delete their own projects, but not those of other users
* create and delete their own reviews, but not those of other users
* add a review text and a numerical rating to a project, but not more than once
* reviews can be endorsed

### future development:

* a user name will be displayed next to each review
* through a form, users are able to embed presentations or upload media to their projects
* users can't review their own projects
* users cannot endorse their own reviews
* users can log in with Twitter
* notification system for project owner
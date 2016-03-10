# TestCrowd

*A pre-crowdfunding platform, that was formerly built on Drupal (2014).*

## objectives

Crowdfunding campaigners are able to try out their crowdfunding project and upload videos, images and text. This will enable their supporters to leave feedback in the form of star ratings, endorsements and comments, which helps campaigners to improve their campaign before they go live on their crowdfunding platform of choice.

## technologies

- Ruby on Rails 4.2.5
- rspec/capybara
- devise

## specification

* users can register, log in, log out and manage their own user data
* users can determine whether they are logged in from the greeting message at the top, which contains their email address
* there is a public project listings page with reviews, ratings and an add review link
* every project has its own page

*users who are logged in are able to:*

* create projects using a form
* edit and delete their own projects and reviews, but not those of other users
* add a review text and a numerical rating to any project, but not more than once per user 
* validations: project names must be at least three characters long, ratings must be between 1 and 5, reviews are optional

### future development:

* a project page will contain a description, list of reviews and ratings
* users can't review their own projects
* reviews can be endorsed
* a user name will be displayed next to each review
* through a form, users are able to add text, embed presentations or upload media to their projects
* users can log in with Twitter or Facebook
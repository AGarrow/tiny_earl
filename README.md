# TinyEarl

a url shortener (and a play on words re: TinyURL)

This project is deployed on heroku, and can be viewed [here](https://tinyearl.herokuapp.com)

## Setup

* clone this repository: `git clone https://github.com/AGarrow/tiny_earl.git`
* `cd tiny_earl`
* install postgresql
* create a user role for tiny_earl: 
 	* `sudo -u postgres psql`
 	* `create role tiny_earl with createdb login password 'tiny_earl';`
* install dependencies: `bundle install`
* setup db: `rails db:migrate`
* start the server: `rails s`

thats it!

### Running Tests
Tests can be run simply by running `rails test` from the root directory of the project.

run `rubocop` to ensure style is OK before committing code.


### Notes

#### Infinite Scroll

I know the spec asked for the top 100 most viewed URLs, and I had it configured this way until I thought "hey, wouldn't it be cooler if it was really infinite?" this can easily be set back to the top 100 simply by uncommenting `config.makes_pages = 4` in `kaminari_config.rb`

# podaholic

Podcast aggregator that provides a more flexible search.

## Dependencies

To run this project you need to have:

* Ruby 2.2.0 - You can use [RVM](http://rvm.io)
* [PostgreSQL](http://www.postgresql.org/)
  * OSX - [Postgress.app](http://postgresapp.com/)
  * Linux - `$ sudo apt-get install postgresql`
  * Windows - [PostgreSQL for Windows](http://www.postgresql.org/download/windows/)
* [Elasticsearch](www.elasticsearch.org)
* [Redis](www.redis.io)

## Setup the project

1. Install the dependencies above
2. `$ git clone git@github.com:nandosousafr/podaholic.git` - Clone the project
3. `$ cd podaholic` - Go into the project folder
4. `$ bin/setup` - Run the setup script
5. `$ bin/rspec` - Run the specs to see if everything is working fine

If everything goes OK, you can now run the project!

## Running the project

1. `$ bundle exec foreman start` - Opens the server
2. Open [http://localhost:3000](http://localhost:3000)

#### Running specs and checking coverage

`$ bundle exec rake spec` to run the specs.

`$ coverage=on bundle exec rake spec` to generate the coverage report then open the file `coverage/index.html` on your browser.

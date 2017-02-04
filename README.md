# LA Quake# LA Quakers

This application implements thee challenge found [in this gist](https://gist.github.com/rafiamafia/6138da6e3ae1e80cc681e99f9c238ea1). It consists of a search page which queries a database for the first ten earthquakes which could be felt in Los Angeles in a given date range.

## Getting Started

1. Clone this repo
2. Run `bundle install`
3. Run `bin/rails db:migrate`
3. Run `bin/rails earthquake:import` (it may take a full minute, see Import Discussion below)
4. Run `bin/rails s` to start the Rails server
5. Visit [http://localhost:3000](http://localhost:3000)

## Import Discussion

In order to import the earthquake data efficiently, I chose to break up the CSV data into 250 row chunks and pass them to an import job that can run asynchronously using ActiveJob. In Rails 5, ActiveJob will run asynchronously by default, but only within the process that queues the job. In the case of a Rake task, once the Rake task is complete, its process is killed and so too are the async jobs.

This is easily resolved by incorporating a queing gem like Resque, however that requires the local machine to be running Redis. Because I did not want to assume the app will run on a local machine with Redis installed, I just set the jobs to run inline.

The result is the jobs take longer to execute (they are running in serial instead of parallel). But the architecture is such that I assume in production the jobs would run in parallel, thus making the import task more efficient and much speedier.

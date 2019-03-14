# TicketApi

Authors and Articles example API app

## Prerequisites

Info about phoenix instalation can be found [here](https://phoenixframework.readme.io/docs/installation)

Redis for backgroud jobs with exq

## How to start

To start your Phoenix server:

* Install dependencies with `mix deps.get`
* Create dev.exs form dev.example.exs changing the database setup to match your PostgreSQL info. If dev.exs exists delete it and replace with dev.example.exs changing its name to dev.exs including your PostgeSQL credentials.
* Create test.exs form test.example.exs changing the database setup to match your PostgreSQL info. If test.exs exists delete it and replace with test.example.exs changing its name to dev.exs including your PostgeSQL credentials.
* Create and migrate your database with `mix ecto.setup`
* Start Phoenix server with `mix phx.server`
* You can find endpoint docs created with bureaucrat at DOCS.md
* You can can run tests with `mix test`

Now all of the API endpoints will be avabile at the adress starting with [`localhost:4000/api`](http://localhost:4000/api) from your browser.
If you deploy this program remeber to use https instead of http (can be changed in config with cert).
More info about SSL [here](https://phoenixframework.readme.io/docs/configuration-for-ssl)

## How does it work

  Basicly its a phoenix prosgresql api which uses exq with redis for backgroud jobs.
  App supports register and login with password and then returns jwt (valid for one day, could be changed)
  With a token you can among others:

* Request event list with ticket types and prices
* Reserve given number of tickets of the given type (each type of ticket can have a differend validation as provided altogether, multiple, avoid_one).
  With that the available ticket pool is decreased by the reserved amount if its valid.
* After 15 minutes the reservation is deleted (with asynch job) unless paid for by registering a payment and available ticket pool is increased.

In test enviroment the backgroud job is beeing bypassed to allow for asynch tests.

If the performance of the app isn't sufficient it could be upgraded with an otp storage that stores the state of the available tickets.
This would of course be faster than using the database as it is now.
It could also be updated with a websocket api (with longpoll support) to take advantage of its faster and countinous continuous.

Deployment tips:

* Heroku deployment is not optimal for elixir apps since the provided dynos have small core counts and ram sizes (also some blocked network stuff for more then one machnine apps)
* There are ARM based servers that offer a lot of CPU cores quite cheaply
* Remember to hide all of the secrets (one in dev is visible for ease of user)
* Provided PaymentAdapter needs to be changed to a real one

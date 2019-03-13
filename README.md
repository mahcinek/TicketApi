# TicketApi

Authors and Articles example API app

# Prerequisites

Info about phoenix instalation can be found [here](https://phoenixframework.readme.io/docs/installation)

# How to start

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

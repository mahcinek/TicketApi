{:ok, _} = Application.ensure_all_started(:ex_machina)
Bureaucrat.start(json_library: Jason, default_path: "DOCS.md")
ExUnit.start(formatters: [ExUnit.CLIFormatter, Bureaucrat.Formatter])
Ecto.Adapters.SQL.Sandbox.mode(TicketApi.Repo, :manual)

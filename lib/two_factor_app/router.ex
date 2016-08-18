defmodule TwoFactorApp.Router do
  use Plug.Router
  import Plug.Conn

  plug :match
  plug :dispatch

  get "/sms" do
    conn = fetch_query_params(conn)
    %{"Body" => body, "From" => from} = conn.params
    TwoFactorApp.Slack.post_message(body, from)

    conn
    |> send_resp(200, "")
  end

  match _ do
    conn
    |> send_resp(404, "Oops")
  end
end

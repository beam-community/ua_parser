defmodule ExampleWeb.FooController do
  use ExampleWeb, :controller

  def user_agent(conn, _params) do
    ua =
      conn
      |> Plug.Conn.get_req_header("user-agent")
      |> List.first()
      |> UAParser.parse()

    text(conn, ua)
  end
end

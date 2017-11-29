# UAParser

[![Build Status][travis-img]][travis] [![License][license-img]][license]

A simple, fast user-agent parsing library based on BrowserScope's UA database with a good default dictionary.

[travis-img]: https://travis-ci.org/doomspork/ua_parser.png?branch=master
[travis]: https://travis-ci.org/doomspork/ua_parser
[license-img]: https://img.shields.io/badge/license-Apache%202.0-blue.svg
[license]: http://opensource.org/licenses/Apache-2.0

## Installation

Add `ua_parser` to your `mix.exs` dependencies:

```elixir
def deps do
  [{:ua_parser, "~> 1.4"}]
end
```

## Usage

```elixir
iex> ua = UAParser.parse("Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Safari/530.17 Skyfire/2.0")
%UAParser.UA{
  device: %UAParser.Device{family: nil},
  family: "Skyfire",
  os: %UAParser.OperatingSystem{
    family: "Mac OS X",
    version: %UAParser.Version{major: "10", minor: "5", patch: "7", patch_minor: nil}
  },
  version: %UAParser.Version{major: "2", minor: "0", patch: nil, patch_minor: nil}
}
iex> to_string(ua)
"Skyfire 2.0"
iex> to_string(ua.os)
"Mac OS X 10.5.7"
iex> to_string(ua.device)
"Other"
```

Retrieving and parsing a user-agent string from Plug:
```elixir
ua =
  conn
  |> Plug.Conn.get_req_header("user-agent")
  |> List.first()
  |> UAParser.parse()
```

## Example

There is an example Phoenix application with a simple endpoint/route to retrieve the user agent header.
To run it, simply cd into the `example` directory, and run the following:

### Phoenix

```shell
$ mix do deps.get, compile
$ npm i && brunch build
# change the configuration to match your own postgres username/password
$ mix do ecto.create, ecto.migrate
$ iex -S mix phoenix.server
# visit localhost:4000/user_agent
```

### Plug

It can also be used as a simple plug:

```shell
mix new ua_plug
cd ua_plug
```

And now set up `mix.exs`:

```elixir
# ...
  defp deps do
    [
     {:cowboy, "~> 1.0.0"},
     {:plug, "~> 1.0"},
     {:ua_parser, git: "https://github.com/doomspork/ua_parser.git",
                  branch: "master"},
    ]
  end
# ...
```

And we get our deps and compile:

```shell
$ mix do deps.get, compile
```

And now we can make our plug:

```elixir
defmodule UAPlug do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    ua =
      conn
         |> Plug.Conn.get_req_header("user-agent")
         |> List.first()
         |> UAParser.parse()
    send_resp(200, ua)
  end
end
```

From here we can pipe requests through it in other applications or use it on its own as we please.

## License

UAParser source code is released under Apache 2.0 License.

See [LICENSE](LICENSE) for more information.

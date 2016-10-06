# WhoServed

## Running

* mix task:
  * single url: ` mix who_served https://www.raspberrypi.org/blog/the-little-computer-that-could/ `
  * multiple urls: ` mix who_served https://www.raspberrypi.org/blog/the-little-computer-that-could/ https://www.raspberrypi.org/ `
  * from docker: 
    * build container: ` docker build -t elixir-xserved  . `
    * single url: ` docker run -it elixir-xserved mix who_served https://www.raspberrypi.org/blog/the-little-computer-that-could/ `
    * multiple urls: ` docker run -it elixir-xserved mix who_served https://www.raspberrypi.org/blog/the-little-computer-that-could/ https://www.raspberrypi.org/ `


## Testing

* run: ` mix test `
* run in container: ` docker run -it elixir-xserved mix test `

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `who_served` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:who_served, git: "https://github.com/elixir-lang/foobar.git", "~> 0.1.0"}]
    end
    ```

  2. Ensure `who_served` is started before your application:

    ```elixir
    def application do
      [applications: [:who_served]]
    end
    ```
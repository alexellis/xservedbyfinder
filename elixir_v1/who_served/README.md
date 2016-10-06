# WhoServed

## Running

* mix task:
  * single url: ` mix who_served https://www.raspberrypi.org/blog/the-little-computer-that-could/ `
  * multiple urls: ` mix who_served https://www.raspberrypi.org/blog/the-little-computer-that-could/ https://www.raspberrypi.org/ `
  * from docker: **TODO: not done yet**

## Testing

* run: ` mix test `


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `who_served` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:who_served, "~> 0.1.0"}]
    end
    ```

  2. Ensure `who_served` is started before your application:

    ```elixir
    def application do
      [applications: [:who_served]]
    end
    ```
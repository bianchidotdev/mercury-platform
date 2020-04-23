# Wrangler

**TODO: Add description**

## Installation

Get the dependencies and compile the code

```
mix deps.get

iex -S mix

iex> Wrangler.hello
:world
```

## Development

### VSCode
1. Make sure docker is running on your machine
1. Open this directory in VSCode
1. Install VSCode Remote - Containers Extension
1. VSCode should prompt you if you want to reopen within a container
    1. If not, run the Remote-Containers: Open Folder in Container... command and select the local folder
1. VSCode should open within the container
1. Open a terminal within VSCode and run `iex -S mix` to test the install

**Note**: Feel free to add any dev tools you feel like you need to `./.devcontainer/Dockerfile` to enhance the development experience.

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/wrangler](https://hexdocs.pm/wrangler).


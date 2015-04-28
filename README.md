TicTacToe
=========

TicTacToe implementation in Elixir.

### Installation

To play the game you will need couple of things:

- Erlang/OTP 17.0 or greater
- Elixir 1.0.0 or greater

The easiest way to install these will be using [Homebrew](http://brew.sh/). If you do have Homebrew installed, the following commands will install both:

```
  brew update
  brew install erlang
  brew install elixir
```

If Homebrew is not an option then there are specific guidelines on the [Erlang website](http://www.erlang.org/doc/installation_guide/INSTALL.html) as well as the [Elixir one](http://elixir-lang.org/install.html).

Once the above is done run the following command to get a local copy of the game:

```
git clone git@github.com:Maikon/elixir_tic_tac_toe.git
```

### Compiling

To compile the project, first go to the root directory:

```
cd elixir_tic_tac_toe
```

Get the required dependencies with:

```
mix deps.get
```

Then run the command to compile:

```
mix compile
```

### Play

To play the game run the following task:

```
mix play
```

### Tests

To run the tests, execute the following command in the root of the directory:

```
mix test
```

### Conventions

This a guideline to some of the conventions that will be seen in the code.

Any function that starts with an `_` indicates that there's more than one definition for that function that differs on the pattern used not the argument count. The only exception to this rule are functions that have at least one public version.

# Bash Helpers

Group of commands to be added to your system, per user basis preferrably,
to extend your usage of Bash and remove the repetition of commands in chain
which are always used together like the way `mkdir` and `cd` are used together
(spoilers: new command would be `cdir`).

## Usage

```sh
git clone https://github.com/briansalehi/bash-helpers.git
cd bash-helpers
make
```

And now you can probe commands like `ctemp`, `cdir /tmp/somewhere`.

## List of Commands

* **cdir**: Change your working directory into another, even if it doesn't exist.
* **ctemp**: Create a temporary directory and move into it.
* **clip**: Copy content to clipboard from file or *standard input*.

## Collaboration

Feel free to add, change or extend any of these tools,
I really would appreciate your collaboration.

To collaborate, fork from this repository, apply your changes, push and create
a pull request. I will be responsive in a day or two.

## License

This work is under MIT license.

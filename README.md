This is a barebones implemnetation of a nix shell with a postgres db coupled with a versioned erlang and elixir. I just dont like sharing the db with the various projects I might have running my system, and I dont necessarily need docker as a dependency for many things.


1. install nix
```
sh <(curl -L https://nixos.org/nix/install)
```
2. cd into the project directory
3. run `nix-shell`


## NOTES

- it creates a directory called `db` containing the database
will trap on exit and stop the db



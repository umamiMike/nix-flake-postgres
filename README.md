## nix flake for developing local PostgreSQL

This is a barebones implementation of a nix flake with a PostgreSQL db.

- I didnt want the abstraction of a docker container.
- I didnt want to have a systemwide installation.  I can add this, with customization, and have multiple db servers running.

[![asciicast](https://asciinema.org/a/PZHsbs0OaGXe5ak918QczxhnD.svg)](https://asciinema.org/a/PZHsbs0OaGXe5ak918QczxhnD)



1. install nix

```
sh <(curl -L https://nixos.org/nix/install)
```

2. cd into the project directory
3. run `nix develop`
4. start the db with `postgres`
5. log into the db with

```sh
psql -h localhost postgres
```


## NOTES

- it creates a directory called `db` containing the database

### dirty problem

As I am only running this in my dev env, I am not worrying about researching this issue.

```sh
  warning: Git tree '/Users/mike/dev/nix-postgres' is dirty
```

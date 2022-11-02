This is a barebones implementation of a nix flake with a PostgreSQL db.

I just dont like sharing the db with the various projects I might have running my system, and I dont necessarily need docker as a dependency for many things.

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

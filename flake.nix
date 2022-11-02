{
  description = "A very basic flake";

 inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages.hello = pkgs.hello;
        devShell = pkgs.mkShell {
          buildInputs = [ pkgs.hello pkgs.cowsay  pkgs.postgresql ];
    # Put the PostgreSQL databases in the project diretory.
    shellHook = ''
  # init the db with 
  # mkdir -p ./db/
export PGDATA="$(pwd)/db"
export PGHOST="$(pwd)"
export PGPORT="5432"

if [[ ! $(grep listen_address $PGDATA/postgresql.conf) ]]; then
echo "db does not exist, creating "
initdb -D $PGDATA --no-locale --encoding=UTF8

cat >> "$PGDATA/postgresql.conf" <<-EOF
listen_addresses = 'localhost'
port = $PGPORT
unix_socket_directories = '$PGHOST'
EOF

# ...create a database using the name Postgres defaults to.
  echo "CREATE USER postgres SUPERUSER;" | postgres --single -E postgres
  echo "CREATE DATABASE postgres WITH OWNER postgres;" | postgres --single -E postgres
  fi

# postgres &

## command to access the db after start
# psql -h localhost postgres

## command to kill the db 
# pg_ctl -D ./db stop

# trap "pg_ctl -D ./db stop" EXIT
'';
};

});
}


{ mypkgs ? import <nixpkgs> {} }:

with mypkgs;

let
  inherit (lib) optional optionals;

  erlang = erlangR22;
  elixir = elixir_1_10;
  postgresql = postgresql_10;
in

mkShell {
  buildInputs = [
  elixir
  nodejs
  git
  postgresql
]
    ++ optional stdenv.isLinux inotify-tools # For file_system on Linux.
    ++ optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
      # For file_system on macOS.
      CoreFoundation
      CoreServices
    ]);

    # Put the PostgreSQL databases in the project diretory.
shellHook = ''

# init the db with 
mkdir -p ./db/
export PGDATA="$(pwd)/db"
export PGHOST="$(pwd)"
if [[ ! $(grep listen_address $PGDATA/postgresql.conf) ]]; then
echo "db does not exist, creating "
initdb
cat >> "$PGDATA/postgresql.conf" <<-EOF
listen_addresses = 'localhost'
port = 5432
unix_socket_directories = '$PGHOST'
EOF

# ...create a database using the name Postgres defaults to.
echo "CREATE DATABASE postgres;" | postgres --single -E postgres
echo "CREATE USER postgres --createdb;" | postgres --single -E postgres
fi

postgres &

## command to access the db after start
# psql -h localhost -p 5432 postgres postgres

## command to kill the db 
# pg_ctl -D ./db stop

trap "pg_ctl -D ./db stop" EXIT
    '';
}

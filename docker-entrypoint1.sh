#!/bin/bash
set -e
if [ "$1" = 'postgres' ]; then
	mkdir -p "$PGDATA"
	chmod 700 "$PGDATA"
	chown -R postgres "$PGDATA"

        mkdir -p "$PGDATA1"
	chmod 700 "$PGDATA1"
        chown -R postgres "$PGDATA1"
        echo "aaaaa">$PGDATA1/aaaa.txt

	eval "gosu postgres initdb $POSTGRES_INITDB_ARGS"
	exec gosu postgres "$@"
fi

exec "$@"

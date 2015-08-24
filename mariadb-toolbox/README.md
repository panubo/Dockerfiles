# MariaDB Toolbox

## Environment Configuration

Use `--link <mariadb container name>:mariadb` to automatically specify the required variables.

Or alternatively specify the individual variables:

- `DATABASE_HOST` = IP / hostname of MariaDB / MySQL server.
- `DATABASE_PORT` = TCP Port of MariaDB / MySQL service.
- `DATABASE_USER` = Administrative user eg root with CREATEDB privileges.
- `DATABASE_PASS` = Password of administrative user.

## Usage

Using Docker links to `mariadb` container:

```docker run --rm -i -t --link mariadb:mariadb quay.io/panubo/mariadb-toolbox```

This will display the usage information.


## Status

Work in progress.

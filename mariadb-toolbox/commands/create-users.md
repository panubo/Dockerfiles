# Create MariaDB / MySQL users and databases

Command to create MySQL / MariaDB users and correspondingly named databases.

## Environment Configuration

Use `--link <mariadb container name>:mariadb` to automatically specify the required variables.

Or alternatively specify the individual variables:

- `DATABASE_HOST` = IP / hostname of MariaDB / MySQL server.
- `DATABASE_PORT` = TCP Port of MariaDB / MySQL service.
- `DATABASE_USER` = Administrative user eg root with CREATEDB privileges.
- `DATABASE_PASS` = Password of administrative user.

### Options

- `--no-create-database` don't create databases

## Example Usage

Create `foo`, `bar` and `baz` users with full privileges to a database with the same name:

```docker run --rm -i -t -e DATABASE_HOST=172.19.66.4 -e DATABASE_USER=root -e DATABASE_PASS=foo quay.io/panubo/mariadb-toolbox create-users foo bar baz```

Using Docker links to `mariadb` container:

```docker run --rm -i -t --link mariadb:mariadb quay.io/panubo/mariadb-toolbox create-users foo bar baz```

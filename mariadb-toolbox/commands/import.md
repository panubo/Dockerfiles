# MariaDB Import Dumps

[![Docker Repository on Quay.io](https://quay.io/repository/macropin/maria-import/status "Docker Repository on Quay.io")](https://quay.io/repository/macropin/maria-import)

Docker container to import MySQL / MariaDB dumps.

## Configuration

Use `--link <mariadb container name>:mariadb` to automatically specify the required variables.

Alternatively specify the individual variables:

- `DATABASE_HOST` = IP / hostname of MariaDB / MySQL server.
- `DATABASE_USER` = Administrative user eg root with CREATEDB privileges.
- `DATABASE_PASS` = Password of administrative user.
- `DATA_SRC` = Data source. This is where your dumps are.

Requires the dumps to be mounted at `/data` (unless overriden) and named `<database>.sql.gz`.

## Usage Example

```docker run --rm -i -t -v /mnt/data00/migrations:/data -e DATABASE_HOST=172.19.66.4 -e DATABASE_USER=root -e DATABASE_PASS=foo macropin/maria-import```

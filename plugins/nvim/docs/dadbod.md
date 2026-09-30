# vim-dadbod

[tpope/vim-dadbod](https://github.com/tpope/vim-dadbod)

## What it does

Runs SQL against a database and puts the results in a scratch buffer. One interface for Postgres,
MySQL, SQLite, SQL Server, MongoDB and others, with the connection expressed as a URL.

## 80/20 usage

| Command | Does |
|---|---|
| `:DB postgresql://localhost/mydb` | set the connection for this session |
| `:DB select * from users limit 10` | run a query, results into a scratch buffer |
| `:'<,'>DB` | run the visually selected lines as a query |
| `:DB g:mydb = postgresql://...` | save a connection to a variable |
| `:DB g:mydb select 1` | run against a saved connection |
| `:DB` | with a connection set, show the schema |

The URL is the whole interface: `sqlite:path/to.db`, `mysql://user:pass@host/db`,
`mongodb://localhost/db`.

## When to use

- **Checking a query while writing the code that will run it.** Select the SQL in your source file,
  `:'<,'>DB`, read the rows — no psql window, no context switch.
- **Poking at a local dev database** without installing a GUI client for each engine you touch.
- **Iterating on a query.** Keep the SQL in a scratch buffer, tweak, re-run the selection. The
  buffer is your history.

## Related

`vim-dadbod-ui` adds a database explorer sidebar on top of this. Not installed here.

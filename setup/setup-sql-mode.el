(require 'sql)

(setq sql-postgres-login-params
      '((user :default "squid")
        (database :default "squid")
        (server :default "localhost")
        (port :default 5432)))

(provide 'setup-sql-mode)

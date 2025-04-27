
pg_dump -U postgres -d SchoolDB -F c -f SchoolDB_backup.dump

createdb -U postgres SchoolDB_restored

pg_restore -U postgres -d SchoolDB_restored -c SchoolDB_backup.dump


# RelationalDB_Bash
Relation Database with Bash script leaned from freecodecamp

## Notes

If you leave your virtual machine, your database may not be saved. You can make a dump of it by entering the following command in a bash terminal (not the psql one):

```bash
pg_dump -cC --inserts -U freecodecamp universe > universe.sql
```

This will save the commands to rebuild your database in universe.sql. The file will be located where the command was entered. If it's anything inside the project folder, the file will be saved in the VM. You can rebuild the database by entering the following command in a terminal where the .sql file is:
```bash
psql -U postgres < universe.sql
```

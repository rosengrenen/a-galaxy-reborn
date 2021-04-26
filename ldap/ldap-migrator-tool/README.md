# ldap-migrator-tool

A tool to migrate the format of old users and groups, mainly changes the `objectClass`es and removes fields accordingly.

## Migrating users

Export the `ou=people` tree from the old ldap (using phpldapadmin) and save as `users.ldif`.

Run `node users`, which outputs `new-users.ldif`, whose contents can be imported directly in the phpldapadmin interface.

## Migrating groups

Export the `ou=groups` tree from the old ldap (using phpldapadmin) and save as `groups.ldif`.

Run `node groups`, which outputs `new-groups.ldif`, whose contents can be imported directly in the phpldapadmin interface.

# ldap-auth

A server that hosts screen sessions, mainly used to persist sessions to the irc.

## Setup

### sssd

Steps from [here](https://kifarunix.com/configure-sssd-for-ldap-authentication-on-ubuntu-20-04/)

1. Install packages

```sh
sudo apt install sssd libpam-sss libnss-sss
```

2. Copy `sssd.conf` to `/etc/sssd/sssd.conf`

3. Fix permissions with `sudo chmod 600 -R /etc/sssd`

4. Add the following to `/etc/pam.d/common-session`

```conf
session required        pam_mkhomedir.so skel=/etc/skel/ umask=0022
```

5. Start and enable `sssd`

```sh
sudo systemctl enable --now sssd
```

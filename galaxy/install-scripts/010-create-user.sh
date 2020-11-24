read -p 'New user name (digit): ' name
if [ -z $name ]; then
  name="digit"
fi

adduser $name
usermod -aG sudo $name

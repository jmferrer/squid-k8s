#!/bin/bash
set -e

## Configure users
## example of users environment var
## USERS="""
## user1:password1;
## user2:password2;
## user3:password3
## """
## It is also valid:
## USERS="user1:password1;user2:password2;user3:password3"
## Be carefull with spaces.

# Check $USERS is defined
if [ -z "$USERS" ]; then
  echo "Please, define environment var USERS:"
  echo "USERS='user1:password1;user2:password2;user3:password3'"
  exit 1
fi

# Remove newline and spaces
users=$(echo -n $USERS | tr -d '\n' | tr -d '\r' | tr -d ' ')

# Create squid users file
touch /etc/squid/.squid_users
echo -n $users | awk 'BEGIN {
                        RS=";";
                        FS=":"
                      }
                      {
                        print "echo " $2 "| htpasswd -i /etc/squid/.squid_users " $1
					            }' | xargs -0 /bin/sh -c

exec "$@"

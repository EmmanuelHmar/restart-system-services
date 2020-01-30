#!/bin/bash
## check if services are running on server
## restart if Not

# set path - Ubuntu
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

##set email address
EMAIL="eman.hmar@gmail.com"

##services to check - ex:( 'one' 'two')
SERVICES=( 'mysql' )

## run the function

for i in "${SERVICES[@]}"
 do
## check service
 `systemctl is-active $i >/dev/null 2>&1`
 STATUS=$(echo $?)

 # service status - 0 is running
 if [[ $STATUS != 0  ]]

  then
  ## restart service
  service $i start

  ## check restart status
  `systemctl is-active $i >/dev/null 2>&1`
  RESTART=$(echo $?)

  if [ $RESTART == 0 ]
   # if restarted
   then

    # remove temp file if exists
    if [ -f "/tmp/$i" ];
    then
     rm /tmp/$i
    fi

    #TODO: send email
   fi
fi

done
exit 0;
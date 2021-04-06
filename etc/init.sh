#!/bin/zsh

echo "Michelle welcomes you."
R=<%= $dest %>

services=""
for i in `find $R/services/enabled -name '*.conf'`; do
    b="${i##*/}" # `basename $i`
    # b=`echo $b | sed 's/.conf$//'`
    services="${b:r},$services"
done
# services=`echo $services | sed 's/,$//'`
cat << EOF > $R/cache/supervisor_startup.conf
[group:default]
programs=`print $services | sed 's/,$//'`
priority=10
umask=022
EOF

# remove stale pid
if [ -r $R/cache/supervisord.pid ]; then
    kill -0 `cat $R/cache/supervisord.pid`
    if [ $? != 0 ]; then rm $R/cache/supervisord.pid; fi
fi
if ! [ -r $R/cache/supervisord.pid ]; then
	print "Starting services: $services"
	supervisord -c $R/supervisor.conf
    cd /mnt/c
    cmd.exe /c start http://127.0.0.1:9001
    cd -
fi

print -n "Loading environment settings... "
for i in `find $R/env.d/ -name '*.sh'`; do
	b="${i##*/}" # `basename $i`
	print -n "$b "
	. "$R/env.d/$b"
done
print
echo "Supervisor: http://127.0.0.1:9001"


#!/bin/bash
#
# nginx - This script start and stops nginx demon.
#
#chkconfig: - 85 15
#discription: Nginx chkconfig shell
#processname: nginx
#config:  /usr/local/nginx/conf/nginx.conf
#config:  /etc/sys/
#pidfile: /var/run/nginx/nginx.pid

#source function library.
. /etc/rc.d/init.d/functions

#Check that networking is up.
[ "NETWORKING" = "no" ] && exit 0

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

DESC="nginx daemon"

NAME=nginx

DAEMON=/usr/local/nginx/sbin/$NAME

CONFIGFILE=/usr/local/nginx/conf/$NAME.conf

PIDFILE=/usr/local/nginx/logs/$NAME.pid

SCRIPTNAME=/etc/init.d/$NAME

set -e 

[ -x "$DAEMON" ] || exit 0

do_star() {
$DAEMON -c $CONFIGFILE || echo -n "nginx already running"
}

do_stop() {
kill -INT `cat $PIDFILE` || echo -n "nginx not running"
}

do_reload() {
kill -HUP `cat $PIDFILE` || echo -n "nginx can't reload"
}

case "$1" in 

start)
echo -n "Starting $DESC:$NAME"
do_start
echo "."

;;

stop)
echo -n "Stopping $DESC:$NAME"
do_stop
echo "."

;;

reset)
echo -n "reseting $DESC:$NAME"
do_stop
do_start
echo "."

;;

reload)
echo -n "reloading $DESC configuration"
do_reload
echo"."

;;

*)
echo "Usage $SCRIPTNAME{start|stop|stop|reload|reset}" >&2
exit 3

;;

esac

exit 0
































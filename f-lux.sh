#!/bin/bash
 
PATH=/bin:/usr/bin:/sbin:/usr/sbin
 
case $1 in
  start)
        /usr/local/bin/xflux -l -16.3806389 -g -71.541272
    ;;
  stop)
        kill -9 `pgrep xflux`
    ;;
  restart|reload)
        $0 stop
        sleep 3
        $0 start
    ;;
  status)
        exit 4
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|reload|status}"
    exit 1
    ;;
esac
 
exit 0

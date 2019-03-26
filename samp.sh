#!/bin/bash
SAMP_DIR=/home/seanny/samp

case "$1" in
        start)
        if [ "${UID}" = "0" ]; then
            echo "ERROR: You cannot run the server as root."
            exit 1
        fi

        if [ -e samp.pid ]; then
            if ( kill -0 $(cat samp.pid) 2> /dev/null ); then
                echo "ERROR: The server is already running, try restart or stop"
                exit 1
            else
                echo "WARNING: samp.pid found, but no server running. Possibly your previously started server crashed"
                echo "WARNING: Please view server_log.txt for details."
                rm samp.pid
            fi
        fi

        echo "INFO: Starting the SA-MP server"
        $SAMP_DIR/samp03svr &
        PID=`ps -elf | grep samp03svr | grep -v grep | awk '{print $4}'`
        ps -p ${PID} > /dev/null 2>&1
        if [ "$?" -ne "0" ]; then
            echo $PID > samp.pid
            echo "INFO: SA-MP server started, for details please view $SAMP_DIR/server_log.txt"
            exit 0
        else
            echo "ERROR: The SA-MP server could not start"
            exit 1
        fi
    ;;
    stop)
                if [ -e samp.pid ]; then
                        echo -n "INFO: Stopping the SA-MP server"
                        if ( kill -TERM $(cat samp.pid) 2> /dev/null ); then
                                c=1
                                while [ "$c" -le 300 ]; do
                                        if ( kill -0 $(cat samp.pid) 2> /dev/null ); then
                                                echo -n "."
                                                sleep 1
                                        else
                                                break
                                        fi
                                        c=$(($c+1))
                                done
                        fi
                        if ( kill -0 $(cat samp.pid) 2> /dev/null ); then
                                echo "WARNING: Server is not shutting down cleanly - killing"
                                kill -KILL $(cat samp.pid)
                        else
                                echo "INFO: Done"
                        fi
                        rm samp.pid
                else
                        echo "ERROR: No server running (samp.pid is missing)"
                        exit 7
                fi
        ;;
    restart)
                $0 stop && $0 start ${COMMANDLINE_PARAMETERS} || exit 1
        ;;
    status)
                if [ -e samp.pid ]; then
                        if ( kill -0 $(cat samp.pid) 2> /dev/null ); then
                                echo "INFO: Server is running"
                        else
                                echo "INFO: Server seems to have died"
                        fi
                else
                        echo "INFO: No server running (samp.pid is missing)"
                fi
        ;;
        *)
                echo "USAGE: ${0} {start|stop|restart|status}"
                exit 2
esac
exit 0

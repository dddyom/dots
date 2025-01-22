#!/usr/bin/env sh

green=#55aa55

connect() {
	sudo wg-quick up wg0
}

disconnect() {
	sudo wg-quick down wg0
}

toggle() {
	connected_interface=$(nmcli | grep  "wireguard")
    if [[ $connected_interface ]]
    then
        disconnect
    else
        connect
        echo 1
    fi
}

print() {
	connected_interface=$(nmcli | grep  "wireguard")
    if [[ $connected_interface ]]
    then
        echo %{u"$green"}%{+u}%{T4}%{F"$green"}%{T-}%{F-} "xorek"
    else
        echo %{T4}%{T-}
    fi
}

case "$1" in
    --connect)
        connect
        ;;
    --disconnect)
        disconnect
        ;;
    --toggle)
        toggle
        ;;
    *)
        print
        ;;
esac

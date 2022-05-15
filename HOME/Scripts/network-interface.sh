a=$(ip link | grep 'state UP')
a=${a#* }
a=${a%%:*}

printf "$a"

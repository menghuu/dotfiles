#!/usr/bin/env bash

host_ip=$(cat /etc/resolv.conf | grep "nameserver" | cut -f 2 -d " ")

proxy() {
  export ALL_PROXY="http://$host_ip:10811"
  export all_proxy="$ALL_PROXY"
  export http_proxy="$ALL_PROXY"
  export https_proxy="$ALL_PROXY"
  curl myip.ipip.net
}

noproxy() {
  unset ALL_PROXY
  unset all_proxy
  unset http_proxy
  unset https_proxy
  curl myip.ipip.net
}

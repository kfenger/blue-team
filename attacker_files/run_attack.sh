#!/bin/bash
set -e

# Finn et rimelig interface som har rute til 8.8.8.8
IFACE=$(ip route get 8.8.8.8 2>/dev/null | awk '{for(i=1;i<=NF;i++){if($i=="dev"){print $(i+1); exit}}}')
PCAP="/opt/pcaps/sample_attack.pcap"

if [ -z "$IFACE" ]; then
  echo "Fant ikke nettverksinterface (ingen rute til 8.8.8.8). Bruk 'ip route' for debugging."
  exit 2
fi

if [ ! -f "$PCAP" ]; then
  echo "PCAP ikke funnet: $PCAP"
  exit 3
fi

echo "Using interface: $IFACE"
sleep 10
tcpreplay --intf1="$IFACE" --mbps=20 "$PCAP"

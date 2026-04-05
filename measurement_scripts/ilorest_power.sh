#!/bin/bash
ilorest rawget --url 192.168.3.107 -u Administrator -p LWPT9GLY /redfish/v1/Chassis/1/Power/FastPowerMeter/ 2>/dev/null | tail -n +5 | python3 -c "
import sys, json

data=json.load(sys.stdin)
power_entries=data.get('PowerDetail', [])
during_exp=power_entries[-18:]

with open('$1', 'w') as f:
  for entry in during_exp:
    f.write(f\"{entry.get('Average','')},{entry.get('Peak','')},{entry.get('Minimum','')},{entry.get('CpuWatts','')},{entry.get('DimmWatts','')}\n\")
"

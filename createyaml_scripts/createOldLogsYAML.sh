#!/bin/bash
jobs_n=(1 2 4)
for i in "${jobs_n[@]}"; do
	helm template --set jobs=$i --set mode=software ../oldchart/ > ../oldYamlFiles/sw${i}_h.yaml 
	helm template --set jobs=$i ../oldchart/ > ../oldYamlFiles/hw${i}_h.yaml
	helm template --set jobs=$i --set rank=1 --set cqi=1 --set prbs=50 --set mode=software ../oldchart/ > ../oldYamlFiles/sw${i}_l.yaml
	helm template --set jobs=$i --set rank=1 --set cqi=1 --set prbs=50 ../oldchart/ > ../oldYamlFiles/hw${i}_l.yaml
	if [[ "$i" -ne "1" ]]; then
		helm template --set jobs=$i --set mode=software --set coreDis=shared ../oldchart/ > ../oldYamlFiles/sw${i}_h_s.yaml
		helm template --set jobs=$i --set coreDis=shared ../oldchart/ > ../oldYamlFiles/hw${i}_h_s.yaml
		helm template --set jobs=$i --set rank=1 --set cqi=1 --set prbs=50 --set mode=software --set coreDis=shared ../oldchart/ > ../oldYamlFiles/sw${i}_l_s.yaml
		helm template --set jobs=$i --set rank=1 --set cqi=1 --set prbs=50 --set coreDis=shared ../oldchart/ > ../oldYamlFiles/hw${i}_l_s.yaml
	fi
done

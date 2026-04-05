#!/bin/bash
jobs_n=(1 2 4 6 8)
for i in "${jobs_n[@]}"; do
	helm template --set jobs=$i --set mode=software ../mychart/ > ../yamlLoadTestingFiles/sw${i}_h.yaml 
	helm template --set jobs=$i ../mychart/ > ../yamlLoadTestingFiles/hw${i}_h.yaml
	helm template --set jobs=$i --set rank=1 --set cqi=1 --set prbs=50 --set mode=software ../mychart/ > ../yamlLoadTestingFiles/sw${i}_l.yaml
	helm template --set jobs=$i --set rank=1 --set cqi=1 --set prbs=50 ../mychart/ > ../yamlLoadTestingFiles/hw${i}_l.yaml
	if [[ "$i" -ne "1" ]]; then
		helm template --set jobs=$i --set mode=software --set coreDis=shared ../mychart/ > ../yamlLoadTestingFiles/sw${i}_h_s.yaml
		helm template --set jobs=$i --set coreDis=shared ../mychart/ > ../yamlLoadTestingFiles/hw${i}_h_s.yaml
		helm template --set jobs=$i --set rank=1 --set cqi=1 --set prbs=50 --set mode=software --set coreDis=shared ../mychart/ > ../yamlLoadTestingFiles/sw${i}_l_s.yaml
		helm template --set jobs=$i --set rank=1 --set cqi=1 --set prbs=50 --set coreDis=shared ../mychart/ > ../yamlLoadTestingFiles/hw${i}_l_s.yaml
	fi
done

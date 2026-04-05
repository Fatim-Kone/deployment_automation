#!/bin/bash
jobs_n=(1 2 4)
for i in "${jobs_n[@]}"; do
	helm template --set jobs=$i --set mode=software ../nochart/ > ../yamlNoLogsFiles/sw${i}_h.yaml 
	helm template --set jobs=$i ../nochart/ > ../yamlNoLogsFiles/hw${i}_h.yaml
	helm template --set jobs=$i --set rank=1 --set cqi=1 --set prbs=50 --set mode=software ../nochart/ > ../yamlNoLogsFiles/sw${i}_l.yaml
	helm template --set jobs=$i --set rank=1 --set cqi=1 --set prbs=50 ../nochart/ > ../yamlNoLogsFiles/hw${i}_l.yaml
	if [[ "$i" -ne "1" ]]; then
		helm template --set jobs=$i --set mode=software --set coreDis=shared ../nochart/ > ../yamlNoLogsFiles/sw${i}_h_s.yaml
		helm template --set jobs=$i --set coreDis=shared ../nochart/ > ../yamlNoLogsFiles/hw${i}_h_s.yaml
		helm template --set jobs=$i --set rank=1 --set cqi=1 --set prbs=50 --set mode=software --set coreDis=shared ../nochart/ > ../yamlNoLogsFiles/sw${i}_l_s.yaml
		helm template --set jobs=$i --set rank=1 --set cqi=1 --set prbs=50 --set coreDis=shared ../nochart/ > ../yamlNoLogsFiles/hw${i}_l_s.yaml
	fi
done

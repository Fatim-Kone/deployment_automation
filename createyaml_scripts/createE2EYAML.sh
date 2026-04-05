#!/bin/bash
jobs_n=(1 2 4 6)
channel_n=(ul dl)
for i in "${jobs_n[@]}"; do
	for j in "${channel_n[@]}"; do
		helm template --set jobs=$i --set channel=$j --set mode=software ../e2echart/ > ../yamlE2EFiles/sw${i}_${j}.yaml 
		helm template --set jobs=$i --set channel=$j ../e2echart/ > ../yamlE2EFiles/hw${i}_${j}.yaml
		if [[ "$i" -ne "1" ]]; then
			helm template --set jobs=$i --set channel=$j --set mode=software --set coreDis=shared ../e2echart/ > ../yamlE2EFiles/sw${i}_${j}_s.yaml
			helm template --set jobs=$i --set channel=$j --set coreDis=shared ../e2echart/ > ../yamlE2EFiles/hw${i}_${j}_s.yaml
		fi
	done
done

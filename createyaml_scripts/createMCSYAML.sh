#!/bin/bash
jobs_n=(1 2 4 6)
mcs_n=(0 4 5 10 11 19 20 27)
for i in "${jobs_n[@]}"; do
	for j in "${mcs_n[@]}"; do
		helm template --set jobs=$i --set max_mcs=$j --set mode=software ./mychart/ > yamlMCSFiles/sw${i}_${j}.yaml 
		helm template --set jobs=$i --set max_mcs=$j ./mychart/ > yamlMCSFiles/hw${i}_${j}.yaml
		if [[ "$i" -ne "1" ]]; then
			helm template --set jobs=$i --set max_mcs=$j  --set mode=software --set coreDis=shared ./mychart/ > yamlMCSFiles/sw${i}_${j}_s.yaml
			helm template --set jobs=$i --set max_mcs=$j  --set coreDis=shared ./mychart/ > yamlMCSFiles/hw${i}_${j}_s.yaml
		fi
	done
done
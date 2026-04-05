#!/bin/bash
jobs_n=(1 2 4 6 8)
prbs_n=(50 100 200 250)
for i in "${jobs_n[@]}"; do
	for j in "${prbs_n[@]}"; do
		helm template --set jobs=$i --set rank=4 --set cqi=15 --set max_mcs=27 --set ul_prbs=$j --set dl_prbs=$j --set mode=software ./varyingchart/ > yamlPRBFiles/sw${i}_${j}.yaml 
		helm template --set jobs=$i --set rank=4 --set cqi=15 --set max_mcs=27 --set ul_prbs=$j --set dl_prbs=$j ./varyingchart/ > yamlPRBFiles/hw${i}_${j}.yaml
		if [[ "$i" -ne "1" ]]; then
			helm template --set jobs=$i --set rank=4 --set cqi=15 --set max_mcs=27 --set ul_prbs=$j --set dl_prbs=$j --set mode=software --set coreDis=shared ./varyingchart/ > yamlPRBFiles/sw${i}_${j}_s.yaml
			helm template --set jobs=$i --set rank=4 --set cqi=15 --set max_mcs=27 --set ul_prbs=$j --set dl_prbs=$j --set coreDis=shared ./varyingchart/ > yamlPRBFiles/hw${i}_${j}_s.yaml
		fi
	done
done

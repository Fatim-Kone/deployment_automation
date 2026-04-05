#!/bin/bash
jobs_n=(1 2)
concur_n=(0 2 4 8 12)
for i in "${jobs_n[@]}"; do
	for j in "${concur_n[@]}"; do
		helm template --set jobs=$i --set concurPDSCH=$j --set channel=pdsch  --set mode=software ../concurrencychart/ > ../yamlConcurrencyFiles/pdsch/sw${i}_${j}.yaml 
		helm template --set jobs=$i --set concurPUSCH=$j  --set channel=pusch --set mode=software ../concurrencychart/ > ../yamlConcurrencyFiles/pusch/sw${i}_${j}.yaml 
		if [[ "$j" -ne "0" ]]; then
			helm template --set jobs=$i --set concurPDSCH=$j --set channel=pdsch  ../concurrencychart/ > ../yamlConcurrencyFiles/pdsch/hw${i}_${j}.yaml
			helm template --set jobs=$i --set concurPUSCH=$j --set channel=pusch  ../concurrencychart/ > ../yamlConcurrencyFiles/pusch/hw${i}_${j}.yaml
		fi 
		
		if [[ "$i" -ne "1" ]]; then
			helm template --set jobs=$i --set concurPDSCH=$j --set channel=pdsch  --set mode=software --set coreDis=shared ../concurrencychart/ > ../yamlConcurrencyFiles/pdsch/sw${i}_${j}_s.yaml
			helm template --set jobs=$i --set concurPUSCH=$j  --set channel=pusch --set mode=software --set coreDis=shared ../concurrencychart/ > ../yamlConcurrencyFiles/pusch/sw${i}_${j}_s.yaml
			if [[ "$j" -ne "0" ]]; then
				helm template --set jobs=$i --set concurPDSCH=$j --set channel=pdsch  --set coreDis=shared ../concurrencychart/ > ../yamlConcurrencyFiles/pdsch/hw${i}_${j}_s.yaml
				helm template --set jobs=$i --set concurPUSCH=$j --set channel=pusch  --set coreDis=shared ../concurrencychart/ > ../yamlConcurrencyFiles/pusch/hw${i}_${j}_s.yaml
			fi
		fi
	done
done
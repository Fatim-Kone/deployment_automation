#!/bin/bash
jobs_n=(1 2 4 6)
iter_n=(2 4 6 8 10)
for i in "${jobs_n[@]}"; do
	for j in "${iter_n[@]}"; do
		helm template --set jobs=$i --set max_mcs=27 --set iter=$j --set mode=software ../mychart/ > ../yamlDecoderIterationFiles/sw${i}_${j}.yaml 
		helm template --set jobs=$i --set max_mcs=27 --set iters=$j ../mychart/ > ../yamlDecoderIterationFiles/hw${i}_${j}.yaml
		if [[ "$i" -ne "1" ]]; then
			helm template --set jobs=$i --set max_mcs=27 --set iter=$j  --set mode=software --set coreDis=shared ../mychart/ > ../yamlDecoderIterationFiles/sw${i}_${j}_s.yaml
			helm template --set jobs=$i --set max_mcs=27 --set iter=$j  --set coreDis=shared ../mychart/ > ../yamlDecoderIterationFiles/hw${i}_${j}_s.yaml
		fi
	done
done
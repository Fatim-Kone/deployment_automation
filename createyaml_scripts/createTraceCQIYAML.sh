#!/bin/bash
jobs_n=(1 2 4 6)
tracefiles_n=("cqi_trace_Ujwal_01012023_1.txt" "cqi_trace_Ujwal_01012023_2.txt" "cqi_trace_Ujwal_triangular_01062023_1.txt" "out_mac_realistic_spin_cqi.txt" "cqi_car_20mph_3min.txt" "random_1.txt")
for i in "${jobs_n[@]}"; do
	for j in "${tracefiles_n[@]}"; do
		helm template --set jobs=$i --set cqi_trace=cqis/${j} --set mode=software ./tracechart/ > yamlTraceFiles/sw${i}_${j}.yaml 
		helm template --set jobs=$i --set cqi_trace=cqis/${j} ./tracechart/ > yamlTraceFiles/hw${i}_${j}.yaml
		if [[ "$i" -ne "1" ]]; then
			helm template --set jobs=$i --set cqi_trace=cqis/${j}  --set mode=software --set coreDis=shared ./tracechart/ > yamlTraceFiles/sw${i}_${j}_s.yaml
			helm template --set jobs=$i --set cqi_trace=cqis/${j}  --set coreDis=shared ./tracechart/ > yamlTraceFiles/hw${i}_${j}_s.yaml
		fi
	done
done
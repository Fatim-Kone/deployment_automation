#!/bin/bash
jobs_n=(1 2)
for i in "${jobs_n[@]}"; do
	helm template --set jobs=$i --set mode=software ./smtchart/ > yamlSMTFiles/sw${i}_h.yaml 
	helm template --set jobs=$i ./smtchart/ > yamlSMTFiles/hw${i}_h.yaml
	helm template --set jobs=$i --set rank=1 --set cqi=1 --set prbs=50 --set mode=software ./smtchart/ > yamlSMTFiles/sw${i}_l.yaml
	helm template --set jobs=$i --set rank=1 --set cqi=1 --set prbs=50 ./smtchart/ > yamlSMTFiles/hw${i}_l.yaml
	if [[ "$i" -ne "1" ]]; then
		helm template --set jobs=$i --set mode=software --set coreDis=shared ./smtchart/ > yamlSMTFiles/sw${i}_h_s.yaml
		helm template --set jobs=$i --set coreDis=shared ./smtchart/ > yamlSMTFiles/hw${i}_h_s.yaml
		helm template --set jobs=$i --set rank=1 --set cqi=1 --set prbs=50 --set mode=software --set coreDis=shared ./smtchart/ > yamlSMTFiles/sw${i}_l_s.yaml
		helm template --set jobs=$i --set rank=1 --set cqi=1 --set prbs=50 --set coreDis=shared ./smtchart/ > yamlSMTFiles/hw${i}_l_s.yaml
	fi
done


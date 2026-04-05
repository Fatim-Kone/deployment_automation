#!/bin/bash
jobs_n=(1 2)
mode=(h l)
for i in "${jobs_n[@]}"; do
	for j in "${mode[@]}"; do
		# Software Shared Cores
		if [[ "$i" -ne "1" ]]; then
			sshpass -p netsys@5g ssh netsys@10.0.0.5 "vmstat -S K 1 1 | awk 'NR>2 { print \$4 }'" > /home/fatim/fatim/old_logs/mem_sw${i}_${j}_s.log
			kubectl apply -f ../yamlOldLogFiles/sw${i}_${j}_s.yaml -n fatim
			for p in $(seq 0 $((i-1))); do
				kubectl wait --for=condition=Ready pod/srsran-gnb-${p} --timeout=180s -n fatim
			done
			kubectl wait --for=condition=Ready pod/profiler --timeout=180s -n fatim

			sleep 240
			./ilorest_power.sh /home/fatim/fatim/old_logs/sw${i}_${j}_power_s.csv
			for p in $(seq 0 $((i-1))); do
				kubectl exec srsran-gnb-${p} -n fatim -- pkill -TERM -f './build/apps/gnb/gnb'
			done

			for p in $(seq 0 $((i-1))); do
				kubectl cp srsran-gnb-${p}:/tmp/gnb.log /home/fatim/fatim/old_logs/sw${i}_${j}_pod${p}_s_tmp.log -n fatim
			done
			
			kubectl cp profiler:cpu.log /home/fatim/fatim/old_logs/sw${i}_${j}_cpu_s.log -n fatim
			kubectl cp profiler:energy.csv /home/fatim/fatim/old_logs/sw${i}_${j}_energy_s.csv -n fatim
			kubectl cp profiler:mem.csv /home/fatim/fatim/old_logs/sw${i}_${j}_mem_s.csv -n fatim
			kubectl cp profiler:cache.log /home/fatim/fatim/old_logs/sw${i}_${j}_cache_s.log -n fatim
		
			kubectl delete -f ../yamlOldLogFiles/sw${i}_${j}_s.yaml -n fatim
			for p in $(seq 0 $((i-1))); do
				kubectl wait --for=delete pod srsran-gnb-${p} --timeout=180s -n fatim
			done
			kubectl wait --for=delete pod profiler --timeout=180s -n fatim
			sleep 10
            for p in $(seq 0 $((i-1))); do
				grep "\[METRICS \]" /home/fatim/fatim/old_logs/sw${i}_${j}_pod${p}_s_tmp.log > /home/fatim/fatim/old_logs/sw${i}_${j}_pod${p}_s.log
			done
		fi

		# Software Distributed Cores
		sshpass -p netsys@5g ssh netsys@10.0.0.5 "vmstat -S K 1 1 | awk 'NR>2 { print \$4 }'" > /home/fatim/fatim/old_logs/mem_sw${i}_${j}.log
		kubectl apply -f ../yamlOldLogFiles/sw${i}_${j}.yaml -n fatim
		for p in $(seq 0 $((i-1))); do
			kubectl wait --for=condition=Ready pod/srsran-gnb-${p} --timeout=180s -n fatim
		done
		kubectl wait --for=condition=Ready pod/profiler --timeout=180s -n fatim

		sleep 240
		./ilorest_power.sh /home/fatim/fatim/old_logs/sw${i}_${j}_power.csv
		for p in $(seq 0 $((i-1))); do
			kubectl exec srsran-gnb-${p} -n fatim -- pkill -TERM -f './build/apps/gnb/gnb'
		done

		for p in $(seq 0 $((i-1))); do
			kubectl cp srsran-gnb-${p}:/tmp/gnb.log /home/fatim/fatim/old_logs/sw${i}_${j}_pod${p}_tmp.log -n fatim
		done
			
		kubectl cp profiler:cpu.log /home/fatim/fatim/old_logs/sw${i}_${j}_cpu.log -n fatim
		kubectl cp profiler:energy.csv /home/fatim/fatim/old_logs/sw${i}_${j}_energy.csv -n fatim
		kubectl cp profiler:mem.csv /home/fatim/fatim/old_logs/sw${i}_${j}_mem.csv -n fatim
		kubectl cp profiler:cache.log /home/fatim/fatim/old_logs/sw${i}_${j}_cache.log -n fatim

		kubectl delete -f ../yamlOldLogFiles/sw${i}_${j}.yaml -n fatim
		for p in $(seq 0 $((i-1))); do

  		 	kubectl wait --for=delete pod srsran-gnb-${p} --timeout=180s -n fatim
		done
		kubectl wait --for=delete pod profiler --timeout=180s -n fatim
		sleep 10
        for p in $(seq 0 $((i-1))); do
            grep "\[METRICS \]" /home/fatim/fatim/old_logs/sw${i}_${j}_pod${p}_tmp.log > /home/fatim/fatim/old_logs/sw${i}_${j}_pod${p}.log
        done

		# Hardware Shared Cores
		if [[ "$i" -ne "1" ]]; then
			sshpass -p netsys@5g ssh netsys@10.0.0.5 "vmstat -S K 1 1 | awk 'NR>2 { print \$4 }'" > /home/fatim/fatim/old_logs/mem_hw${i}_${j}_s.log
			kubectl apply -f ../yamlOldLogFiles/hw${i}_${j}_s.yaml -n fatim
			for p in $(seq 0 $((i-1))); do
				kubectl wait --for=condition=Ready pod/srsran-gnb-${p} --timeout=180s -n fatim
			done
			kubectl wait --for=condition=Ready pod/profiler --timeout=180s -n fatim

			sleep 240
			./ilorest_power.sh /home/fatim/fatim/old_logs/hw${i}_${j}_power_s.csv
			for p in $(seq 0 $((i-1))); do
				kubectl exec srsran-gnb-${p} -n fatim -- pkill -TERM -f './build/apps/gnb/gnb'
			done

			for p in $(seq 0 $((i-1))); do
				kubectl cp srsran-gnb-${p}:/tmp/gnb.log /home/fatim/fatim/old_logs/hw${i}_${j}_pod${p}_s_tmp.log -n fatim
			done

			kubectl cp profiler:cpu.log /home/fatim/fatim/old_logs/hw${i}_${j}_cpu_s.log -n fatim
			kubectl cp profiler:energy.csv /home/fatim/fatim/old_logs/hw${i}_${j}_energy_s.csv -n fatim
			kubectl cp profiler:mem.csv /home/fatim/fatim/old_logs/hw${i}_${j}_mem_s.csv -n fatim
			kubectl cp profiler:cache.log /home/fatim/fatim/old_logs/hw${i}_${j}_cache_s.log -n fatim

			kubectl delete -f ../yamlOldLogFiles/hw${i}_${j}_s.yaml -n fatim
			for p in $(seq 0 $((i-1))); do
				kubectl wait --for=delete pod srsran-gnb-${p} --timeout=180s -n fatim
			done
			kubectl wait --for=delete pod profiler --timeout=180s -n fatim
			sleep 10
            for p in $(seq 0 $((i-1))); do
				grep "\[METRICS \]" /home/fatim/fatim/old_logs/hw${i}_${j}_pod${p}_s_tmp.log > /home/fatim/fatim/old_logs/hw${i}_${j}_pod${p}_s.log
                rm /home/fatim/fatim/old_logs/hw${i}_${j}_pod${p}_s_tmp.log
			done
		fi

		# Hardware Distributed Cores
		sshpass -p netsys@5g ssh netsys@10.0.0.5 "vmstat -S K 1 1 | awk 'NR>2 { print \$4 }'" > /home/fatim/fatim/old_logs/mem_hw${i}_${j}.log
		kubectl apply -f ../yamlOldLogFiles/hw${i}_${j}.yaml -n fatim
		for p in $(seq 0 $((i-1))); do
			kubectl wait --for=condition=Ready pod/srsran-gnb-${p} --timeout=180s -n fatim
		done
		kubectl wait --for=condition=Ready pod/profiler --timeout=180s -n fatim
		
		sleep 240
		./ilorest_power.sh /home/fatim/fatim/old_logs/hw${i}_${j}_power.csv
		for p in $(seq 0 $((i-1))); do
			kubectl exec srsran-gnb-${p} -n fatim -- pkill -TERM -f './build/apps/gnb/gnb'
		done

		for p in $(seq 0 $((i-1))); do
			kubectl cp srsran-gnb-${p}:/tmp/gnb.log /home/fatim/fatim/old_logs/hw${i}_${j}_pod${p}_tmp.log -n fatim
		done

		kubectl cp profiler:cpu.log /home/fatim/fatim/old_logs/hw${i}_${j}_cpu.log -n fatim
		kubectl cp profiler:energy.csv /home/fatim/fatim/old_logs/hw${i}_${j}_energy.csv -n fatim
		kubectl cp profiler:mem.csv /home/fatim/fatim/old_logs/hw${i}_${j}_mem.csv -n fatim
		kubectl cp profiler:cache.log /home/fatim/fatim/old_logs/hw${i}_${j}_cache.log -n fatim

		kubectl delete -f ../yamlOldLogFiles/hw${i}_${j}.yaml -n fatim
		for p in $(seq 0 $((i-1))); do
  			kubectl wait --for=delete pod srsran-gnb-${p} --timeout=180s -n fatim
		done
		kubectl wait --for=delete pod profiler --timeout=180s -n fatim
		sleep 10
        for p in $(seq 0 $((i-1))); do
            grep "\[METRICS \]" /home/fatim/fatim/old_logs/hw${i}_${j}_pod${p}_tmp.log > /home/fatim/fatim/old_logs/hw${i}_${j}_pod${p}.log
        done
	done
done
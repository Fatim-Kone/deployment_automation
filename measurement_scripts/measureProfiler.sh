mode=$1
channel=$2
protocol=$3
sshpass -p netsys@5g ssh netsys@10.0.0.5 "vmstat -S K 1 1 | awk 'NR>2 { print \$4 }'" > /home/fatim/fatim/realue_logs/initial_mem_${mode}_${channel}_${protocol}.log
kubectl apply -f deployProfiler.yaml -n fatim
sleep 240
./ilorest_power.sh /home/fatim/fatim/realue_logs/${mode}_${channel}_${protocol}_power.csv
sshpass -p netsys@5g scp netsys@10.0.0.5:/tmp/gnb.log /home/fatim/fatim/realue_logs/${mode}_${channel}_${protocol}_gnb.log

kubectl cp profiler:cpu.log /home/fatim/fatim/realue_logs/${mode}_${channel}_${protocol}_cpu.log -n fatim
kubectl cp profiler:energy.csv /home/fatim/fatim/realue_logs/${mode}_${channel}_${protocol}_energy.csv -n fatim
kubectl cp profiler:mem.csv /home/fatim/fatim/realue_logs/${mode}_${channel}_${protocol}_mem.csv -n fatim
kubectl cp profiler:onCPU.log /home/fatim/fatim/realue_logs/${mode}_${channel}_${protocol}_onCPU.log -n fatim
kubectl cp profiler:offCPU.log /home/fatim/fatim/realue_logs/${mode}_${channel}_${protocol}_offCPU.log -n fatim
kubectl cp profiler:cache.log /home/fatim/fatim/realue_logs/${mode}_${channel}_${protocol}_cache.log -n fatim

kubectl delete -f deployProfiler.yaml -n fatim
kubectl wait --for=delete pod profiler --timeout=180s -n fatim



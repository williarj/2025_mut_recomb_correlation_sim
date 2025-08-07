#!/bin/bash

muts=(1e-9 2e-9 3e-9 4e-9)
rhos=(1e-7 2e-7 4e-7 6e-7)
sels=(-0.0001 -0.001 -0.01)
N=5000
G=2500
replicates=20 
final_file="combined_results.csv"
run_num=1

for mut in "${muts[@]}";
do
 for rho in "${rhos[@]}";
 do
  for s in "${sels[@]}";
  do
   for rep in $(seq 1 $replicates);
    do
	/work/williarj/williarj/slim/slim -d N=$N -d G=$G -d TIME=10 -d MU=$mut -d RHO=$rho -d S=$s -d "FILE='run${run_num}.out'" ../../src/mut_recomb_correl_sim.slim&
	if ((run_num % 15 == 0));
	then
		#every 15 processes wait for the last one to finish before starting more
		wait $!
		#echo "paused at ${run_num}"
	fi
	((run_num++))
done
done
done
done

#Wait for all subprocesses to finish
wait

#combine the results into one file
#get the first file with the header included
cp run1.out $final_file
mv run1.out TEMPrun1.out
#get the rest of the output
tail -n 1 -q run*.out >> $final_file
#restore the run1 file
mv TEMPrun1.out run1.out

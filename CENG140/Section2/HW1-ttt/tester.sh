#!/bin/bash

sayim=0
chmod +x ttt
deneme_sayisi=0

# Remove old comparisons
rm -r generator_output/binden_gelen
rm -r generator_output/custom_gelen

mkdir generator_output/binden_gelen &> /dev/null
mkdir generator_output/custom_gelen &> /dev/null

while [ $sayim -lt 200 ]; do
  ./ttt_binary_olan < generator_output/input_file_$sayim > generator_output/binden_gelen/output_$sayim
  ./ttt < generator_output/input_file_$sayim > generator_output/custom_gelen/output_$sayim
  


  diff_out=$(diff generator_output/binden_gelen/output_$sayim generator_output/custom_gelen/output_$sayim)
  state=$?
  
  
  if [ $state -eq 0 ]; then
    echo "Test $sayim success..."
    deneme_sayisi=0
    sayim=$(($sayim+1))
  else
    if [ $deneme_sayisi -gt 20 ]; then # kimin once basladigi rasgele geliyor, 20 kez deneyelim bakalim
      echo $diff_out
      exit 1
    else
      deneme_sayisi=$(($deneme_sayisi+1))
    fi
  fi
  
done
# Remove old comparisons
rm -r generator_output/binden_gelen
rm -r generator_output/custom_gelen


echo "Done!"


exit 0

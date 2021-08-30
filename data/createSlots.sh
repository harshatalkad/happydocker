#!/bin/bash
hrs=(15 16 17 18 19 20 21 22 23)

for i in ${!hrs[@]};
do
   startDate=$3T${hrs[$i]}:00:00Z
   endDate=$3T${hrs[$i]}:45:00Z
   echo $startDate - $endDate
   ./createSlot.sh $1 $2 $startDate $endDate
done

#!/bin/bash
hrs=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23)
if [ ! -z "$4" ] && [ "$4" = "-h1" ]
then
	hrs=(15 16 17 18)
fi
if [ ! -z "$4" ] && [ "$4" = "-h2" ]
then
	hrs=(19 20 21 22 23)
fi
echo $hrs

for i in ${!hrs[@]};
do
   startDate=$3T${hrs[$i]}:00:00Z
   endDate=$3T${hrs[$i]}:45:00Z
   echo $startDate - $endDate
   ./createSlot.sh $1 $2 $startDate $endDate
done

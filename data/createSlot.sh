#!/bin/bash

sed "s/\${practitionerId}/$1/g" ./template/schedule.template.json > "/tmp/$1-$2.json"
sed -i'.original' -e "s/\${facilityId}/$2/g" "/tmp/$1-$2.json"
sed -i'.original' -e "s/\${startDate}/$3/g" "/tmp/$1-$2.json"
sed -i'.original' -e "s/\${endDate}/$4/g" "/tmp/$1-$2.json"

scheduleId=$(curl -s -X POST -H "Content-Type: application/fhir+json" -d @/tmp/$1-$2.json http://localhost:8090/fhir/Schedule | jq -r '.id')
echo 'Schedule' $scheduleId 'created'

if [ ! -z $scheduleId ]
then
	sed "s/\${scheduleId}/$scheduleId/g" ./template/slot.template.json > "/tmp/$scheduleId.json"
	sed -i'.original' -e "s/\${startDate}/$3/g" "/tmp/$scheduleId.json"
	sed -i'.original' -e "s/\${endDate}/$4/g" "/tmp/$scheduleId.json"


	slotId=$(curl -s -X POST -H "Content-Type: application/fhir+json" -d @/tmp/$scheduleId.json http://localhost:8090/fhir/Slot | jq -r ".id")
	echo "Slot" $slotId "created"
fi

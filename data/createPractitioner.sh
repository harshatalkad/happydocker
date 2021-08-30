#!/bin/bash
sed "s/\${npi}/$1/g" ./template/practitioner.template.json > "/tmp/req.json"

sed -i'.original' -e "s/\${name}/$2/g" "/tmp/req.json"
sed -i'.original' -e "s/\${familyname}/$3/g" "/tmp/req.json"
sed -i'.original' -e "s/\${gender}/$4/g" "/tmp/req.json"

practitionerId=$(curl -s -X POST -H "Content-Type: application/fhir+json" -d @/tmp/req.json http://localhost:8090/fhir/Practitioner | jq -r '.id')
echo 'Practitioner' $practitionerId 'created'

#!/bin/bash

sed "s/\${orgId}/$1/g" ./template/location.template.json > "/tmp/req.json"

sed -i'.original' -e "s/\${name}/$2/g" "/tmp/req.json"
sed -i'.original' -e "s/\${address1}/$3/g" "/tmp/req.json"
sed -i'.original' -e "s/\${city}/$4/g" "/tmp/req.json"
sed -i'.original' -e "s/\${state}/$5/g" "/tmp/req.json"
sed -i'.original' -e "s/\${postalCode}/$6/g" "/tmp/req.json"
sed -i'.original' -e "s/\${country}/$7/g" "/tmp/req.json"

locationId=$(curl -s -X POST -H "Content-Type: application/fhir+json" -d @/tmp/req.json http://localhost:8090/fhir/Location | jq -r '.id')
echo 'Location' $locationId 'created'

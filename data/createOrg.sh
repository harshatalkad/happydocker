#!/bin/bash

sed "s/\${sfOrgId}/$1/g" ./template/organization.template.json > "/tmp/req.json"
sed -i'.original' -e "s/\${orgName}/$2/g" "/tmp/req.json"

orgId=$(curl -s -X POST -H "Content-Type: application/fhir+json" -d @/tmp/req.json http://localhost:8090/fhir/Organization | jq -r '.id')
echo 'Organization' $orgId 'created'

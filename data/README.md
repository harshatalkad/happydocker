# HAPI Data Generator Scripts


This is not a full fledged script, but it is easy to generate test data for simple testing. Feel free to contribute make this script more dynamic.
The slots will be created with below listed code. If need different code, we need to enhance it further.

- serviceCategory code as "17" for "General Practice"
- serviceType code as "57" for "Immunization"
- specialty code as "408480009" for "Clinical immunology"
- appointmentType as code "CHECKUP"

Run the commands from data directory.

## Commands and Examples

### Create Organization
- `$ sh createOrg.sh <OrganizationId> <OrganizationName>`
	- Example : `$  sh createOrg.sh 'OrgId1' 'Talkad HealthCare'`
- Get the internal organization id  ( here it is 1)
```
 "entry": [ {
    "fullUrl": "http://localhost:8080/fhir/Organization/1",
    "resource": {
      "resourceType": "Organization",
      "id": "1",
```
	
### Create Facility/Location	
- `$ sh createLocation.sh <InternalOrgId> <FaclityName> <FacilityStreet> <FacilityCity> <FacilityState> <FacilityPostal> <FacilityCountry>`
	- Example :  `$ sh ./createLocation.sh '1' 'Talkad HealthCare' '50 Fremont St' 'SanFrancisco' 'CA'
'95000' 'USA'`
- Get the internal Facility id (here it is 2)
```
 "entry": [ {
    "fullUrl": "http://localhost:8080/fhir/Location/2",
    "resource": {
      "resourceType": "Location",
      "id": "2",
```

### Create Pracititioner
- `$ sh creaetPractitioner.sh <NPI> <FirstName> <LastName> <Gender>`
	- Example : `$ sh ./createPractitioner.sh 'NPI1' 'Harsha' 'Talkad' 'male'`
- Get the internal practitioner id (here it is 3)
```
  "entry": [ {
    "fullUrl": "http://localhost:8080/fhir/Practitioner/3",
    "resource": {
      "resourceType": "Practitioner",
      "id": "3",
```

### Create Slots for a day
- `$ sh createSlots.sh <PractitionerId> <FacilityId> <Date>' `
- Example : `$ sh createSlots.sh '3' '2' '2021-08-30T00:00:00Z' `  
  
### Create one slot
- `$ sh createSlot.sh <PractitionerId> <FacilityId> <StartTime> <EndTime>' `
- Example : `$ sh createSlot.sh '3' '2' '2021-08-29T00:00:00Z' '2021-08-29T01:00:00Z' `  `  

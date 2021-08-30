# hapi-data-gen
This is not a full fledged script, but it is easy to generate test data for simple testing. Feel free to contribute make this script more dynamic.
The slots will be created with below listed code. If need different code, we need to enhance it further.

- serviceCategory code as "17" for "General Practice"
- serviceType code as "57" for "Immunization"
- specialty code as "408480009" for "Clinical immunology"
- appointmentType as code "CHECKUP"

# Prerequisite 
You must have Practitioner, Location in HAPI sandbox. (I am planning create new script for createing practioner and location)

# Command
cd <cloned dir>/hapi-data
  
./createSlot.sh P1 P2 P3 P4

- P1 - external-practitioner-id
- P2 - external-facility-id
- P3 - slot-start-time in UTC
- P4 - slot-end-time in UTC

# To create multiple slots for given day

./createSlots.sh P1 P2 P3 P4

- P1 - external-practitioner-id
- P2 - external-facility-id
- P3 - day (example: 2021-04-25)
- P4 - Optional field. If not passed, it will generate 45 minues slots from UTC time 15:00 to 23:00. If pass "-h1", it will generate 45 minutes slots from UTC time 15:00 to 18:00. If pass "-h2", it will generate 45 minutes slots for UTC time 19:00 to 23:00.


![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+)Note: Tested on mac os.

# Example:  
./createSlot.sh 1912758 1912740 2021-06-25T21:00:00Z 2021-06-25T21:45:00Z


# Existing Practitioner and Facility Id on HAPI
- ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) It may get reset anytime by HAPI

| Practitioner | Practitioner Id |  Practitioner NPI  |
| :---:   | :---:   | :-: |
| Charles | 1912758 | 324234 |
| Anna | 1912759 | 4243424243 |
| April | 1912760 | 3242423 |

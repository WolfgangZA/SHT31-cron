#!/bin/sh 

#All values in Celcuis and RH percentage
Identifier="Name of Server Room"

MaxTemp=27.00
MinTemp=18.00

MaxHumidity=60.00
MinHumidity=40.00
 
TempOutput=$(python /etc/apcupsd/SHT31/SHT31-Temp.py)
HumidityOutput=$(python /etc/apcupsd/SHT31/SHT31-Humidity.py)


#Check if Temp is above or equal to MaxTemp
if ! awk "BEGIN{ exit ($TempOutput >= $MaxTemp) }"
then
    echo $(date '+%d/%m/%Y %H:%M:%S') "WARNING! $Identifier Temperature is currently at $TempOutput C which is above the specified value of $MaxTemp C" | mail -s "WARNING! $Identifier Temperature is currently at $TempOutput C which is above the specified value of $MaxTemp C" test@test.com
    echo $(date '+%d/%m/%Y %H:%M:%S') "WARNING! $Identifier Temperature is currently at $TempOutput C which is above the specified value of $MaxTemp C" >> "/home/pi/Desktop/SHT31.events" 
fi

#Check if Temp is below or equal to MinTemp
if ! awk "BEGIN{ exit ($TempOutput <= $MinTemp) }"
then
    echo $(date '+%d/%m/%Y %H:%M:%S') "WARNING! $Identifier Temperature is currently at $TempOutput C which is below the specified value of $MinTemp C" | mail -s "WARNING! $Identifier Temperature is currently at $TempOutput C which is below the specified value of $MinTemp C" test@test.com
    echo $(date '+%d/%m/%Y %H:%M:%S') "WARNING! $Identifier Temperature is currently at $TempOutput C which is below the specified value of $MinTemp C" >> "/home/pi/Desktop/SHT31.events" 
fi

#Check if Humidity is above or equal to MaxHumidity
if ! awk "BEGIN{ exit ($HumidityOutput >= $MaxHumidity) }"
then
    echo $(date '+%d/%m/%Y %H:%M:%S') "WARNING! $Identifier Humidity is currently at $HumidityOutput %RH which is above the specified value of $MaxHumidity" | mail -s "WARNING! $Identifier Humidity is currently at $HumidityOutput %RH which is above the specified value of $MaxHumidity" test@test.com
    echo $(date '+%d/%m/%Y %H:%M:%S') "WARNING! $Identifier Humidity is currently at $HumidityOutput %RH which is above the specified value of $MaxHumidity" >> "/home/pi/Desktop/SHT31.events" 
fi

#Check if Humidity is above or equal to MaxHumidity
if ! awk "BEGIN{ exit ($HumidityOutput <= $MinHumidity) }"
then
    echo $(date '+%d/%m/%Y %H:%M:%S') "WARNING! $Identifier Humidity is currently at $HumidityOutput %RH which is below the specified value of $MinHumidity" | mail -s "WARNING! $Identifier Humidity is currently at $HumidityOutput %RH which is below the specified value of $MinHumidity" test@test.com
    echo $(date '+%d/%m/%Y %H:%M:%S') "WARNING! $Identifier Humidity is currently at $HumidityOutput %RH which is below the specified value of $MinHumidity" >> "/home/pi/Desktop/SHT31.events" 
fi





echo $(date '+%d/%m/%Y %H:%M:%S') "Temperature is: $TempOutput C | Humidity is: $HumidityOutput %RH" >> "/home/pi/Desktop/SHT31.events"  
  


echo "Output was $TempOutput and $HumidityOutput"

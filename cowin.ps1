[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

function CheckCowin($DisID){
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Accept", "application/json")
$Date = Get-Date -Format "dd-MM-yyyy"
$cowinstr = 'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict?district_id='+$DisID+'&date='+$Date+'' 
$response = Invoke-RestMethod $cowinstr  -Method 'GET' -Headers $headers -ErrorAction SilentlyContinue
$RawMessage = ''
if($response.centers.Count -gt 0){
for($i=0;$i-lt $response.centers.Count;$i++){
for($j=0;$j-lt $response.centers[$i].sessions.Count;$j++){
if($response.centers[$i].sessions[$j].available_capacity -eq 0){
$RawMessage +=
'
<strong>COWIN Available Alert</strong>
Center:<strong>'+$response.centers[$i].name+'</strong>
Address:<strong>'+$response.centers[$i].address+'</strong>
State:<strong>'+$response.centers[$i].state_name+'</strong>
District:<strong>'+$response.centers[$i].district_name+'</strong>
BlockName:<strong>'+$response.centers[$i].block_name+'</strong>
DATE:<strong>'+$response.centers[$i].sessions[$j].date+'</strong>
VaccineName:<strong>'+$response.centers[$i].sessions[$j].vaccine+'</strong>
Fee-Type:<strong>'+$response.centers[$i].fee_type+'</strong>
AvailableCapacity:<strong>'+$response.centers[$i].sessions[$j].available_capacity+'</strong>
Min_Age_Limit:<strong>'+$response.centers[$i].sessions[$j].min_age_limit+'+</strong>
Dose1:<strong>'+$response.centers[$i].sessions[$j].available_capacity_dose1+'</strong>
Dose2:<strong>'+$response.centers[$i].sessions[$j].available_capacity_dose2+'</strong>
@
'
}
}
}
} 

$Message = $RawMessage.split("@")

function SendFive($min,$max){
    $TempMSG=''
    for($i=$min;$i-lt$max;$i++){
    $TempMSG+=$Message[$i]    
    }
    Telegram($TempMSG)
    if($max -lt $Message.Count){
      SendFive -min $max -max ($max+5)
    }
}

if($Message.Count-ge 5){
SendFive -min 0 -max 5
}
else{
  if($Message[0] -eq ''){
  Write-Host "No Centers Are Active"
  exit(0)
  }
  else{
  if(($Message.Count -gt 0) -and ($Message.Count -le 5)){
  $TempSecond=''
  for($i=0;$i-le$Message.Count;$i++){
  $TempSecond+=$Message[$i]
  }
  Telegram($TempSecond)
  exit(0)
  }
  }
    }

}


function Telegram($msg){
$botid = "" ### TG Bot ID
$chatid = "" ### Group/Channel Chat ID

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 
$telstr = 'https://api.telegram.org/bot'+$botid+'/sendMessage?chat_id=-'+$chatid+'&text='+$msg+'&parse_mode=html' 
$response = Invoke-RestMethod $telstr -Method 'GET' -Headers $headers
Write-Host "Sent"
}

#####MAIN
cls
CheckCowin -DisID 610 ##Warangal Urban (DISID)-610

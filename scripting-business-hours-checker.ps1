$currentDay = (Get-Date).DayOfWeek
$currentHour = (Get-Date).Hour

$isWeekDay = $currentDay -ge 1 -and $currentDay -le 5

$isBusinessHours = $currentHour -ge 9 -and $currentHour -lt 17

if ($currentDay -eq "Wednesday" -and $currentHour -ge 1 -and $currentHour -lt 15) {
    write-host "team meeting time"
} elseif ($isWeekDay -and $isBusinessHours) {
    write-host "business hours"
} else {
    write-host "off hours"
}
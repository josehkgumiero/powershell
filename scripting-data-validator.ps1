$userDate = read-host "Please enter a date in the format YYYY-MM-DD"

if ($userDate -as [string]) {
    write-host "Good start! You entered a string!"

    if ($userDate -like "????-??-??"){
        write-host "Fantastic! That is the correct format"
    } else {
        write-host "Nice try, but that is not quite the rigth format. Remember, we need YYYY-MM-DD"
    }

} else {
    write-host "Oops! That is not even a string. Try again!"
    exit
}
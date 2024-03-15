

/*
	TIME & DATE & TIME & DATE & TIME & DATE & TIME & DATE & TIME & DATE & TIME & DATE & TIME & DATE & TIME & DATE & 
*/



// Finally we are able to get the local time and date <3
// ----------------------------------------------------------------------------------------------------------------------------

/*
	hour = 20, minute = 40, dayofweek = 1, year = 2020, daylightsavings	= 0, second = 19, dayofyear = 341, month = 12, day = 7
*/

::GetLocalTime <- function(){
	local timeTable = {}
	LocalTime(timeTable)
	return timeTable
}




// Returns a table with the long name of a day and the abreviation ( param = daynumber )
// ----------------------------------------------------------------------------------------------------------------------------

::getWeekDay <- function(daynum){
	
	local days = [
		{ Long = "Sunday", Short = "Sun" }
		{ Long = "Monday", Short = "Mon" }
		{ Long = "Tuesday", Short = "Tue" }
		{ Long = "Wednesday", Short = "Wed" }
		{ Long = "Thursday", Short = "Thu" }
		{ Long = "Friday", Short = "Fri" }
		{ Long = "Saturday", Short = "Sat" }
	]
	if(daynum >= 0 && daynum <= 6){
		return days[daynum]
	}else{
		return false
	}
}




// Returns a table with the long name of a month and the abreviation ( param = monthnumber )
// ----------------------------------------------------------------------------------------------------------------------------

::getMonth <- function(monthnum){
	local months = [
		{ Long = "January", Short = "Jan" }
		{ Long = "February", Short = "Feb" }
		{ Long = "March", Short = "Mar" }
		{ Long = "April", Short = "Apr" }
		{ Long = "May", Short = "May" }
		{ Long = "June", Short = "Jun" }
		{ Long = "July", Short = "Jul" }
		{ Long = "August", Short = "Aug" }
		{ Long = "September", Short = "Sep" }
		{ Long = "October", Short = "Oct" }
		{ Long = "November", Short = "Nov" }
		{ Long = "December", Short = "Dec" }
	]
	if(monthnum >= 1 && monthnum <= 12){
		return months[monthnum -1]
	}else{
		return false
	}
}

local ordinals = 
[
	"1st"
	"2nd"
	"3rd"
	"4th"
	"5th"
	"6th"
	"7th"
	"8th"
	"9th"
	"10th"
	"11th"
	"12th"
	"13th"
	"14th"
	"15th"
	"16th"
	"17th"
	"18th"
	"19th"
	"20th"
	"21st"
	"22nd"
	"23rd"
	"24th"
	"25th"
	"26th"
	"27th"
	"28th"
	"29th"
	"30th"
	"31st"
]




function GetRatioBoxTimeString(){
	
	local timeTable = GetLocalTime()
	local customTable = { hour = timeTable.hour, minute = timeTable.minute, second = timeTable.second }
	
	// Thats our custom table with min 2-digit numbers
	foreach(key,val in customTable){
		if(val.tostring().len() == 1){
			customTable[key] <- ("0" + val)
		}
	}
	
	local dateString =  getWeekDay(timeTable.dayofweek).Long + ", " + getMonth(timeTable.month).Long  + " " + ordinals[timeTable.day-1] + ", " + timeTable.year
	local timeString = customTable["hour"] + ":" + customTable["minute"] + ":" + customTable["second"]
	
	return { Date = dateString, Time = timeString }
}


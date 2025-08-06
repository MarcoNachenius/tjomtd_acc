extends Node

var RESULT_TEXT: String = ""
var FINAL_MAZE_LENGTH: float = 0.0
var FINAL_MAZE_DAMAGE: float = 0.0
var FINAL_MAZE_COMPLETION_TIME: float = 0.0
var FINAL_SCORE: int = 0
var WAVES_COMPLETED: int = 0

## Converts seconds to a human-readable time string showing only necessary units
## Examples: 
##   10 → "10s"
##   60 → "1m" 
##   71 → "1m11s"
##   3200 → "1h"
##   3201 → "1h1s"
func format_time(seconds_float: float) -> String:
    var remaining_seconds: int = int(round(seconds_float))
    
    # Create placeholder values
    var hour_string: String = ""
    var minute_string: String = ""
    var second_string: String = ""

    # Define base values
    const BASE_HOUR: int = 3600
    const BASE_MINUTE: int = 60

    # Calculate hours
    if remaining_seconds >= BASE_HOUR:
        var hours: int = remaining_seconds / BASE_HOUR
        hour_string = "%dh" % hours
        remaining_seconds = remaining_seconds % BASE_HOUR

    # Calculate minutes
    if remaining_seconds >= BASE_MINUTE:
        var minutes: int = remaining_seconds / BASE_MINUTE
        minute_string = "%dm" % minutes
        remaining_seconds = remaining_seconds % BASE_MINUTE
    
    # Remaining seconds
    if remaining_seconds > 0 or (hour_string == "" and minute_string == ""):
        second_string = "%ds" % remaining_seconds
    
    return hour_string + minute_string + second_string
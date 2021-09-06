extends Label

func _process(delta):
	var dt = OS.get_datetime()
	var weekday = get_weekday(dt)
	var month = get_month(dt)
	var day = dt["day"]
	var year = dt["year"]
	text = "%s, %s %02d, %04d" % [weekday, month, day, year]
	pass

func get_month(dt):
	var month = dt["month"]
	match month:
		OS.MONTH_JANUARY: return "Jan"
		OS.MONTH_FEBRUARY: return "Feb"
		OS.MONTH_MARCH: return "Mar"
		OS.MONTH_APRIL: return "Apr"
		OS.MONTH_MAY: return "May"
		OS.MONTH_JUNE: return "Jun"
		OS.MONTH_JULY: return "Jul"
		OS.MONTH_AUGUST: return "Aug"
		OS.MONTH_SEPTEMBER: return "Sep"
		OS.MONTH_OCTOBER: return "Oct"
		OS.MONTH_NOVEMBER: return "Nov"
		OS.MONTH_DECEMBER: return "Dec"

func get_weekday(dt):
	var weekday = dt["weekday"]
	match weekday:
		OS.DAY_SUNDAY: return "Sunday"
		OS.DAY_MONDAY: return "Monday"
		OS.DAY_TUESDAY: return "Tuesday"
		OS.DAY_WEDNESDAY: return "Wednesday"
		OS.DAY_THURSDAY: return "Thursday"
		OS.DAY_FRIDAY: return "Friday"
		OS.DAY_SATURDAY: return "Saturday"
		_: return ""

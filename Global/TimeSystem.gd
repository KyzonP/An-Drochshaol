extends Node

const weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
const seasons = ["Spring", "Summer", "Autumn", "Winter"]
const am_pm = ["am", "pm"]
const minute_intervals = ["00", "10", "20", "30", "40", "50"]

onready var player = get_node("/root/Farm/Player")

export (int) var second = 21600
export (int) var minute = 0
export (int) var hour = 0
export (int) var day = 0
export (int) var month = 1
export (int) var year = 1845
export (int) var event_tracker = 0
export(String) var weekday = "Sat."
export (int) var weekday_counter = 6
export(String) var season = "Spring"
export(String) var noon = "am"
export (String) var minute_interval = "00"

export (int) var seasonLength = 14

#Lose conditions
export var moneyLost = false
export var foodLost = false

#time based stuff
const default_time_speed = 160
var day_processed = false
var time_speed = 160

#trackers for food/money
export (int) var money = 5
export(int) var food = 66

#trackers for the cost of money/food
export (int) var moneyCost = 200
export(int) var foodCost = 16

#trackers for the amount of seeds etc
export (int) var oatSeed = 15
export (int) var potatoSeed = 15
export (int) var barleySeed = 0

#trackers for the cost of seeds and bread
export(int) var oatSeedCost = 1
export(int) var potatoSeedCost = 2
export(int) var barleySeedCost = 3
export(int) var breadCost = 2

var rng = RandomNumberGenerator.new()

#tracker for the rate of blight in the field
export (float) var blightRate = 0.0
export (float)var blightIncrease = 0.25

#tracker for the chances of successfully sailing away
export(int) var survivalRate = 0

#tracker for rent payment in the farm file
export (bool) var rentPaid = false

#tracker for if the player has too much food
export (bool) var foodExcess = false

signal new_day_start
signal refresh_tiles

func _ready():
	time_speed = default_time_speed
	
func _process(delta):
	if hour == 0 and day_processed == false and time_speed > 0:
		refresh_day()
		
	if hour == 0:
		emit_signal("refresh_tiles");
		
	if hour > 0:
		day_processed = false
		
		
	if time_speed > 0:
		second += int(floor(delta * time_speed))
		minute = (int(second) / 60) % 60
		hour = (int(second) / (60 * 60)) % 24
		noon = am_pm[hour/12]
		minute_interval = minute_intervals[minute/10]
		
func refresh_day():
	second = 21600
	minute = 0
	hour = 0
	day += 1
	day_processed = true
	#Increase tracker for the Farm page for letters, newspapers etc
	event_tracker += 1
	
	#food is eaten
	food = food - foodCost
	
	blightRate += blightIncrease
	
	emit_signal("new_day_start")
	
	# current month should end below:
	if day > seasonLength:
		month += 1
		day = 1
		
		#Rent payment is taken
		money = money - moneyCost
		
		#blight rate increase
		blightIncrease += 1
		
		#if they still have money left then their 'survival rate' increases as does rent
		if money > 0:
			survivalRate += 1
			moneyCost += (money/2)+oatSeed+(barleySeed*1.5)
			rentPaid = true

		
		#Bread cost increases slightly up until about 25
		if breadCost < 24:
			rng.randomize()
			breadCost += rng.randi_range(1, 3)
		
		# current year should end below:
		if month > 4:
			year += 1
			month = 1
			
		season = seasons[month-1]
			
	weekday_counter = int(day) % 7 - 1
	weekday = weekdays[weekday_counter]
	
	if day > 1:
		pass
		#player.global_position = Vector2(267,90)
	
	#Detecting if the player has lost or not (i.e. they failed to eat or pay rent)
	if food < 0:
		foodLost = true
	elif money < 0:
		moneyLost = true
		
		
	###CODE HERE TO CHECK IF THEY HAVE TOO MUCH FOOD
		
	if food > (foodCost * 10):
		foodExcess = true
	

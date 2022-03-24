extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Time.hour < 13:	
		$hour.text = str(Time.hour)
	else:
		$hour.text = str(Time.hour - 12)
		
	$minutes.text = str(Time.minute)
	$seconds.text = str(Time.second)
	$day.text = (str(Time.day) + " / 14 of ")
	$month.text = str(Time.month)
	$year.text = str(Time.year)
	
	$weekday.text = str(Time.weekday)
	$season.text = str(Time.season)
	$noon.text = str(Time.noon)
	$minute_interval.text = ":" + str(Time.minute_interval)
	
	$food.text = str(Time.food)
	$foodCost.text = str(Time.foodCost)
	$money.text = str(Time.money)
	$moneyCost.text = str(Time.moneyCost)
	
	$oatSeed.text = str(Time.oatSeed)
	$potatoSeed.text = str(Time.potatoSeed)
	$barleySeed.text = str(Time.barleySeed)
	
	#$darkness.module.a = 0.2

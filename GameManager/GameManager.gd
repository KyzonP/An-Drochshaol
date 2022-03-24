extends Node2D

var rng = RandomNumberGenerator.new()

#ready player for audio queue
onready var player = get_node("/root/Farm/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Quit_pressed():
	Time.time_speed = 0
	
	###GOING TO AMERICA
	var goToAmerica = rng.randi_range(1, 10)
	if goToAmerica <= Time.survivalRate:
		$AmericaWin.visible = true
	else:
		$AmericaLose.visible = true
		
	player._on_gameOver()
		
	$QuitButton.visible = true
	$PlayAgain.visible = true

func _on_PlayAgain_pressed():
	Time.second = 21600
	Time.day = 1
	Time.month = 1
	Time.season = Time.seasons[Time.month-1]
	Time.year = 1844
	Time.event_tracker = 0
	Time.blightRate = 0
	Time.blightIncrease = 0.25
	Time.food = 50
	Time.money = 5
	Time.moneyCost = 200
	Time.breadCost = 2
	Time.survivalRate = 0
	Time.oatSeed = 15
	Time.potatoSeed = 15
	Time.barleySeed = 0
	Time.foodLost = false
	Time.moneyLost = false
	Time.time_speed = Time.default_time_speed

	get_tree().change_scene(get_tree().current_scene.filename)

func _on_QuitButton_pressed():
	get_tree().quit()
	
func _on_Food_Lost():
	$FoodLose.visible = true
	$QuitButton.visible = true
	$PlayAgain.visible = true
	
func _on_Money_Lost():
	$MoneyLose.visible = true
	$QuitButton.visible = true
	$PlayAgain.visible = true

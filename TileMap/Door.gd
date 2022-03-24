extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_Door_body_entered(body):
	if body.name =="Player":
		$YesButton.visible = true
		$NoButton.visible = true
		$Sleep.visible = true
		$PotatoButton.visible = true
		Time.time_speed = 0
	
func _on_PotatoButton_pressed():
	if Time.potatoSeed > 0:
		Time.potatoSeed -= 1
		Time.food += 1
	pass # Replace with function body.

func _on_YesButton_pressed():
	$YesButton.visible = false
	$NoButton.visible = false
	$Sleep.visible = false
	$PotatoButton.visible = false
	Time.time_speed = Time.default_time_speed
	Time.refresh_day()
	pass # Replace with function body.

func _on_NoButton_pressed():
	$YesButton.visible = false
	$NoButton.visible = false
	$Sleep.visible = false
	$PotatoButton.visible = false
	Time.time_speed = Time.default_time_speed
	
	pass # Replace with function body.

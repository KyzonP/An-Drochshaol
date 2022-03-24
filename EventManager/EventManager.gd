extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_CloseButton_pressed():
	$Paper.play()
	
	$CloseButton.visible = false
	$CloseButtonImage.visible = false
	$letterTemplate.visible = false
	$newspaperTemplate.visible = false
	
	$letterRent.visible = false
	$letterDay1.visible = false
	$letterDay2.visible = false
	$letterLandLeft.visible = false
	$letterLandRight.visible = false
	$letterFoodStolen.visible = false
	
	$newspaper1.visible = false
	$newspaper2.visible = false
	$newspaper3.visible = false
	$newspaper4.visible = false
	$newspaper5.visible = false
	$newspaper6.visible = false
	$newspaper7.visible = false
	$newspaper8.visible = false
	$newspaper9.visible = false
	$newspaper10.visible = false
	
	Time.time_speed = Time.default_time_speed
	
func _on_Day1():
	Time.time_speed = 0
	
	$Paper.play()
	$CloseButtonImage.visible = true
	$CloseButton.visible = true
	$letterDay1.visible = true
	
func _on_Day2():
	Time.time_speed = 0
	
	$Paper.play()
	$CloseButtonImage.visible = true
	$CloseButton.visible = true
	$letterDay2.visible = true
	
func _on_Land_Left():
	Time.time_speed = 0
	
	$Paper.play()
	$CloseButtonImage.visible = true
	$CloseButton.visible = true
	$letterLandLeft.visible = true
	
func _on_Land_Right():
	Time.time_speed = 0
	
	$Paper.play()
	$CloseButtonImage.visible = true
	$CloseButton.visible = true
	$letterLandRight.visible = true
	
func _on_Rent():
	Time.time_speed = 0
	
	$Paper.play()
	$CloseButtonImage.visible = true
	$CloseButton.visible = true
	$letterRent.visible = true
	
func _on_Food_Stolen():
	Time.time_speed = 0
	
	$Paper.play()
	$CloseButtonImage.visible = true
	$CloseButton.visible = true
	$letterFoodStolen.visible = true
	
func _on_newspaper1():
		Time.time_speed = 0
	
		$Paper.play()
		$CloseButtonImage.visible = true
		$CloseButton.visible = true
		$newspaper1.visible = true
		
func _on_newspaper2():
		Time.time_speed = 0
	
		$Paper.play()
		$CloseButtonImage.visible = true
		$CloseButton.visible = true
		$newspaper2.visible = true
		
		
func _on_newspaper3():
		Time.time_speed = 0
	
		$Paper.play()
		$CloseButtonImage.visible = true
		$CloseButton.visible = true
		$newspaper3.visible = true

func _on_newspaper4():
		Time.time_speed = 0
	
		$Paper.play()
		$CloseButtonImage.visible = true
		$CloseButton.visible = true
		$newspaper4.visible = true

func _on_newspaper5():
		Time.time_speed = 0
	
		$Paper.play()
		$CloseButtonImage.visible = true
		$CloseButton.visible = true
		$newspaper5.visible = true
		
func _on_newspaper6():
		Time.time_speed = 0
	
		$Paper.play()
		$CloseButtonImage.visible = true
		$CloseButton.visible = true
		$newspaper6.visible = true
		
func _on_newspaper7():
		Time.time_speed = 0
	
		$Paper.play()
		$CloseButtonImage.visible = true
		$CloseButton.visible = true
		$newspaper7.visible = true
		
func _on_newspaper8():
		Time.time_speed = 0
	
		$Paper.play()
		$CloseButtonImage.visible = true
		$CloseButton.visible = true
		$newspaper8.visible = true
		
func _on_newspaper9():
		Time.time_speed = 0
	
		$Paper.play()
		$CloseButtonImage.visible = true
		$CloseButton.visible = true
		$newspaper9.visible = true
		
func _on_newspaper10():
		Time.time_speed = 0
	
		$Paper.play()
		$CloseButtonImage.visible = true
		$CloseButton.visible = true
		$newspaper10.visible = true

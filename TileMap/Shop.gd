extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Shop_body_entered(body):
	if body.name =="Player":
		Time.time_speed = 0
		
		$Menu.visible = true
		$Back.visible = true
		$GoToStore.visible = true
		$EatPotato.visible = true
		$Quit.visible = true	

func _on_Shop_body_exited(body):
	if body.name =="Player":
		Time.time_speed = Time.default_time_speed

func _on_Back_pressed():
		#Make all the buttons invisible
		$Menu.visible = false
		$Back.visible = false
		$GoToStore.visible = false
		$EatPotato.visible = false
		$Quit.visible = false
		
		#Start up time again
		Time.time_speed = Time.default_time_speed

### Shop buttons - adds the purchased item but deducts the cost from your money
func _on_BuyBread_pressed():
	if Time.money >= Time.breadCost:
		Time.food += 2
		Time.money -= Time.breadCost

func _on_BuyOat_pressed():
	if Time.money >= Time.oatSeedCost:
		Time.oatSeed += 1
		Time.money -= Time.oatSeedCost
	
func _on_BuyPotato_pressed():
	if Time.money >= Time.potatoSeedCost:
		Time.potatoSeed += 1
		Time.money -= Time.potatoSeedCost

func _on_BuyBarley_pressed():
	if Time.money >= Time.barleySeedCost:
		Time.barleySeed += 1
		Time.money -= Time.barleySeedCost

func _on_Button_pressed():
	if Time.potatoSeed > 0:
		Time.potatoSeed -= 1
		Time.food += 1

func _on_GoToStore_pressed():
	#Make all the store buttons visible
	$Store.visible = true
	$BuyBread.visible = true
	$BuyOat.visible = true
	$BuyBarley.visible = true
	$LeaveStore.visible = true	
	$BreadCost.visible = true
	
	#Potatoes are only available if the blight isn't around
	if Time.blightRate > 40:
		$Blight.visible = true
	else:
		$BuyPotato.visible = true
	
	###Update the bread cost
	if Time.breadCost == 1:
		$BreadCost.animation = '1'
	elif Time.breadCost == 2:
		$BreadCost.animation = '2'
	elif Time.breadCost == 3:
		$BreadCost.animation = '3'		
	elif Time.breadCost == 4:
		$BreadCost.animation = '4'			
	elif Time.breadCost == 5:
		$BreadCost.animation = '5'			
	elif Time.breadCost == 6:
		$BreadCost.animation = '26'			
	elif Time.breadCost == 7:
		$BreadCost.animation = '7'		
	elif Time.breadCost == 8:
		$BreadCost.animation = '8'		
	elif Time.breadCost == 9:
		$BreadCost.animation = '9'		
	elif Time.breadCost == 10:
		$BreadCost.animation = '10'				
	elif Time.breadCost == 11:
		$BreadCost.animation = '11'		
	elif Time.breadCost == 12:
		$BreadCost.animation = '12'		
	elif Time.breadCost == 13:
		$BreadCost.animation = '13'		
	elif Time.breadCost == 14:
		$BreadCost.animation = '14'		
	elif Time.breadCost == 15:
		$BreadCost.animation = '15'		
	elif Time.breadCost == 16:
		$BreadCost.animation = '16'		
	elif Time.breadCost == 17:
		$BreadCost.animation = '17'		
	elif Time.breadCost == 18:
		$BreadCost.animation = '18'		
	elif Time.breadCost == 19:
		$BreadCost.animation = '19'																		
	elif Time.breadCost == 20:
		$BreadCost.animation = '20'		
	elif Time.breadCost == 21:
		$BreadCost.animation = '21'				
	elif Time.breadCost == 22:
		$BreadCost.animation = '22'				
	elif Time.breadCost == 23:
		$BreadCost.animation = '23'				
	elif Time.breadCost == 24:
		$BreadCost.animation = '24'				
	elif Time.breadCost == 25:
		$BreadCost.animation = '25'				
	
	#Make the menu buttons invisible
	$Menu.visible = false
	$Back.visible = false
	$GoToStore.visible = false
	$EatPotato.visible = false
	$Quit.visible = false

func _on_LeaveStore_pressed():
	#Make all the store buttons invisible
	$Store.visible = false
	$BuyBread.visible = false
	$BuyOat.visible = false
	$BuyBarley.visible = false
	$LeaveStore.visible = false	
	$BreadCost.visible = false
	
	if Time.blightRate > 40:
		$Blight.visible = false
	else:
		$BuyPotato.visible = false
	
	$Menu.visible = true
	$Back.visible = true
	$GoToStore.visible = true
	$EatPotato.visible = true
	$Quit.visible = true	
	


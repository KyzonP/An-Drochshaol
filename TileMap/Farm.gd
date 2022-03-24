extends TileMap

onready var player = $Player
var tile_pos_infront_of_player

onready var toolSelector = $ToolSelector
var currentTool = "Hoe"

var day1 = true
var day2 = true
var landLeft = true
var landRight = true
var newspaper1 = true
var newspaper2 = true
var newspaper3 = true
var newspaper4 = true
var newspaper5 = true
var newspaper6 = true
var newspaper7 = true
var newspaper8 = true
var newspaper9 = true
var newspaper10 = true
var eventOccuring = false

var stillPlaying = true

onready var CowGrassLeft = $CowGrassLeft
onready var LeftFence = get_node("/root/Farm/CowGrassLeft/CowFenceLeft/StaticBody2D/LeftFence")
onready var CowGrassRight = $CowGrassRight
onready var RightFence = get_node("/root/Farm/CowGrassRight/CowFenceRight/StaticBody2D/RightFence")

signal harvestSignal #NEW

var rng = RandomNumberGenerator.new()
var blightRate = 0

# TMP TEST
var crop_data_potato = {"pk": 1, 
				"object_name":"Potato",
				"phase_days": [1, 1, 1, 1, INF],
				"current_phase": 0,
				"day_of_current_phase": 0,
				"crop_age": 0}

var crop_data_oat = {"pk": 2, 
				"object_name":"Oat",
				"phase_days": [1, 1, 1, INF],
				"current_phase": 0,
				"day_of_current_phase": 0,
				"crop_age": 0}
				
var crop_data_barley = {"pk": 3, 
				"object_name":"Barley",
				"phase_days": [1, 1, 1, 1, 1, INF],
				"current_phase": 0,
				"day_of_current_phase": 0,
				"crop_age": 0}
				
var crop_data_blighted_potato = {"pk": 4, 
				"object_name":"BlightedPotato",
				"phase_days": [1, 1, 1, 1, INF],
				"current_phase": 0,
				"day_of_current_phase": 0,
				"crop_age": 0}

# Called when the node enters the scene tree for the first time.
func _ready():
	Time.connect("refresh_tiles", self, "refresh_tiles")
	connect("harvestSignal", self, "signal_handler") #NEW
	pass # Replace with function body.
	
func _physics_process(delta):
	# if there is a player, we put the grid helper (irish flag) on the tile in front of him - or close enough
	if player:
		var player_pos = player.global_position
		var tile_pos_player_is_on = world_to_map(player_pos + Vector2(0,4))
		# Here we need to use Face Direction to determine where to put grid helper
		tile_pos_infront_of_player = tile_pos_player_is_on + player.face_direction
		# tile_pos_infront_of_player is relative tile position which start from (0,0), to (0,1) ...
		$GridHelper.global_position = tile_pos_infront_of_player * 16 # tile size
		
	#1845:
	##### Triggering 'events' on certain days #####
	#newspaper1 - blight in europe
	if Time.event_tracker == 4 and newspaper1 == true:
		newspaper1 = false
		$EventManager._on_newspaper1()
		eventOccuring = true
	
	#land about to be sold
	if Time.event_tracker == 8 and landLeft == true:
		landLeft = false
		$EventManager._on_Land_Left()
		eventOccuring = true
		
	if Time.event_tracker == (Time.seasonLength+1):
		LeftFence.set_disabled(false)
		CowGrassLeft.visible = true
		eventOccuring = true
		
	#newspaper2 - blight in ireland
	if Time.event_tracker == 16 and newspaper2 == true:
		Time.blightRate += 5
		newspaper2 = false
		$EventManager._on_newspaper2()
		eventOccuring = true
		
	#letter2 - blight in ireland
	if Time.event_tracker == 18 and day2 == true:
		day2 = false
		$EventManager._on_Day2()
		eventOccuring = true
		
	#land about to be sold
	if Time.event_tracker == 22 and landRight == true:
		Time.blightRate += 5
		landRight = false
		$EventManager._on_Land_Right()	
		eventOccuring = true
	
	#day 29
	if Time.event_tracker == ((2 * (Time.seasonLength))+1):
		RightFence.set_disabled(false)
		CowGrassRight.visible = true
		eventOccuring = true
		
	#newspaper 3 - Food export ban rejected
	if Time.event_tracker == 35 and newspaper3 == true:
		Time.blightRate += 5
		Time.blight
		newspaper3 = false
		$EventManager._on_newspaper3()
		eventOccuring = true
	
	#newspaper 4 - foreign aid
	if Time.event_tracker == 49 and newspaper4 == true:
		Time.blightRate += 5
		newspaper4 = false
		$EventManager._on_newspaper4()
		eventOccuring = true
	
	#1846:
	#newspaper 5 
	if Time.event_tracker == 63 and newspaper5 == true:
		Time.blightRate += 5
		newspaper5 = false
		$EventManager._on_newspaper5()
		eventOccuring = true
		
	#newspaper 6
	if Time.event_tracker == 77 and newspaper6 == true:
		Time.blightRate += 5
		newspaper6 = false
		$EventManager._on_newspaper6()
		eventOccuring = true
		
	#newspaper 7 - foreign aid
	if Time.event_tracker == 91 and newspaper7 == true:
		Time.blightRate += 5
		newspaper7 = false
		$EventManager._on_newspaper7()
		eventOccuring = true
		
	#newspaper 8 - foreign aid
	if Time.event_tracker == 105 and newspaper8 == true:
		Time.blightRate += 5
		newspaper8 = false
		$EventManager._on_newspaper8()
		eventOccuring = true
		
	#newspaper 9 - foreign aid
	if Time.event_tracker == 119 and newspaper9 == true:
		Time.blightRate += 5
		newspaper9 = false
		$EventManager._on_newspaper9()
		eventOccuring = true
		
	#newspaper 10 - foreign aid
	if Time.event_tracker == 133 and newspaper10 == true:
		Time.blightRate += 5
		newspaper10 = false
		$EventManager._on_newspaper10()
		eventOccuring = true
		
	#do food thing if nothing else is happening
	if Time.foodExcess == true and eventOccuring == false:
		Time.foodExcess = false
		Time.food = (Time.food / 2)
		$EventManager._on_Food_Stolen()
		
	eventOccuring = false
	
	#######################################################
		
	#Detect for game over
	if Time.foodLost == true and stillPlaying == true:
		stillPlaying = false
		Time.time_speed = 0
		$Player._on_gameOver()
		$GameManager._on_Food_Lost()
	elif Time.moneyLost == true:
		$Player._on_gameOver()
		Time.time_speed = 0
		$GameManager._on_Money_Lost()
	
	#Detecting for a rent payment
	if Time.rentPaid == true and stillPlaying == true:
		stillPlaying = true
		Time.rentPaid = false
		$EventManager._on_Rent()
		
func refresh_tiles():
	# dry out the wet tiles (called each morning)
	var wet_dirts = get_used_cells_by_id(CONSTANTS.WET_DIRT_ID)
	for tile_pos in wet_dirts:
		set_cellv(tile_pos, get_tileset().find_tile_by_name(CONSTANTS.SOWN_DIRT_NAME))

func _input(event):
	if day1 == true:
		day1 = false
		$EventManager._on_Day1()
	
	# tracking player actions
	if event.is_action_pressed("action"):
		if Time.time_speed > 0:	
			# harvest crops
			if currentTool == "Harvest":
				emit_signal("harvestSignal")
				
			# hoe the ground - changes dirt to scratched dirt
			elif currentTool == "Hoe":
				if self.get_cellv(tile_pos_infront_of_player) == CONSTANTS.DIRT_ID:
					self.set_cellv(tile_pos_infront_of_player, self.get_tileset().find_tile_by_name(CONSTANTS.SCRATCHED_DIRT_NAME))
				if self.get_cellv(tile_pos_infront_of_player) == CONSTANTS.WET_DIRT_ID:
					self.set_cellv(tile_pos_infront_of_player, self.get_tileset().find_tile_by_name(CONSTANTS.SCRATCHED_DIRT_NAME))
					
			# water the soil - changes sown dirt to wet first
			elif currentTool == "Water":	
				if self.get_cellv(tile_pos_infront_of_player) == CONSTANTS.SOWN_DIRT_ID:
					self.set_cellv(tile_pos_infront_of_player, self.get_tileset().find_tile_by_name(CONSTANTS.WET_DIRT_NAME))
		
			# plant the various crops (instance a crop if the soil is scratched - and changes it to sown
			elif currentTool == "Oat":
				if Time.oatSeed > 0:
					if self.get_cellv(tile_pos_infront_of_player) == CONSTANTS.SCRATCHED_DIRT_ID:
						Time.oatSeed -= 1
						var crop_path = "res://Crops/Oat.tscn"
						var crop = load(crop_path).instance()
						crop.initialize(crop_data_oat)
						crop.global_position = tile_pos_infront_of_player * 16
						crop.connect("harvestSignal", self, "signal_handler") #NEW
						add_child(crop)
						
						#TURN THE TILE INTO SOWN DIRT, SO AS TO PREVENT DOUBLE PLANTING
						self.set_cellv(tile_pos_infront_of_player, self.get_tileset().find_tile_by_name(CONSTANTS.SOWN_DIRT_NAME))
						
			elif currentTool == "Potato":
				if Time.potatoSeed > 0:
					if self.get_cellv(tile_pos_infront_of_player) == CONSTANTS.SCRATCHED_DIRT_ID:
						Time.potatoSeed -=1
							
						#Code for deciding blight or not!
						if Time.blightRate > 100:
							blightRate = 100
						else:
							blightRate = Time.blightRate
							
						rng.randomize()
						var blightChance = rng.randf_range(0, 100)
						
						if blightRate > blightChance:
							var crop_path = "res://Crops/BlightedPotato.tscn"
							var crop = load(crop_path).instance()
							crop.initialize(crop_data_blighted_potato)
							crop.global_position = tile_pos_infront_of_player * 16
							crop.connect("harvestSignal", self, "signal_handler") ##NEW
							add_child(crop)
						else:
							var crop_path = "res://Crops/Potato.tscn"
							var crop = load(crop_path).instance()
							crop.initialize(crop_data_potato)
							crop.global_position = tile_pos_infront_of_player * 16
							crop.connect("harvestSignal", self, "signal_handler") ##NEW
							add_child(crop)
							
						self.set_cellv(tile_pos_infront_of_player, self.get_tileset().find_tile_by_name(CONSTANTS.SOWN_DIRT_NAME))
				
			elif currentTool == "Barley":
				if Time.barleySeed >0:
				
					if self.get_cellv(tile_pos_infront_of_player) == CONSTANTS.SCRATCHED_DIRT_ID:
						Time.barleySeed -=1
						var crop_path = "res://Crops/Barley.tscn"
						var crop = load(crop_path).instance()
						crop.initialize(crop_data_barley)
						crop.global_position = tile_pos_infront_of_player * 16
						#crop.connect("harvestSignal", self, "signal_handler") #NEW
						add_child(crop)
						
						self.set_cellv(tile_pos_infront_of_player, self.get_tileset().find_tile_by_name(CONSTANTS.SOWN_DIRT_NAME))
						
	# if the game is not paused, player can change the equipped tool
	if Time.time_speed > 0:	
		if Input.is_action_pressed("ui_1"):
			toolSelector.global_position = Vector2(32, 284)
			currentTool = "Harvest"
		
		if Input.is_action_pressed("ui_2"):
			toolSelector.global_position = Vector2(64, 284)
			currentTool = "Hoe"
			
		elif Input.is_action_pressed("ui_3"):
			toolSelector.global_position = Vector2(96, 284)
			currentTool = "Water"
			
		elif Input.is_action_pressed("ui_4"):
			toolSelector.global_position = Vector2(128, 284)
			currentTool = "Oat"
			
		elif Input.is_action_pressed("ui_5"):
			toolSelector.global_position = Vector2(160, 284)
			currentTool = "Potato"
			
		elif Input.is_action_pressed("ui_6"):
			toolSelector.global_position = Vector2(192, 284)
			currentTool = "Barley"
		
		if event.is_action_pressed("harvest"):
			emit_signal("harvestSignal")

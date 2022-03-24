extends "Plant.gd"

# Nonshared Variables
export (Array) var phase_days = []
var destroyable = true
var rng = RandomNumberGenerator.new()
onready var farm = get_node("/root/Farm")
onready var gridhelper = get_node("/root/Farm/GridHelper")

var crop_data_blighted_potato = {"pk": 4, 
				"object_name":"BlightedPotato",
				"phase_days": [1, 1, 1, INF],
				"current_phase": 0,
				"day_of_current_phase": 0,
				"crop_age": 0}

func _ready():
	Time.connect("new_day_start", self, "_on_new_day_start")
	check_dirt_status()
	check_plant_status(phase_days)

func initialize(crop_data):
	.initialize(crop_data)
	phase_days = crop_data.get("phase_days")
	
	$Anim.play(str(current_phase))
	
func _on_new_day_start():
	Time.blightRate += 1
	check_dirt_status()
	check_plant_status(phase_days)
	
	if Time.event_tracker == (Time.seasonLength + 1):
		if self.global_position.x < 206:
			self.queue_free()
			
	if Time.event_tracker == ((2 * Time.seasonLength) + 1):
		if self.global_position.x > 304 and self.global_position.y < 114:
			self.queue_free()
		
func _on_Hurtbox_area_entered(area):
	destroyable = true

func _on_Hurtbox_area_exited(area):
	destroyable = false
	
func _input(event):
	#If harvest is pressed while the crop is fully grown, destroy the crop in the front of the player
	if (event.is_action_pressed("harvest") and destroyable == true and current_phase > 2) or (event.is_action_pressed("action") and farm.currentTool == "Harvest" and destroyable == true and current_phase > 2):
		var crop_pos = self.global_position
		var tile_crop_is_on = farm.world_to_map(crop_pos)
		if gridhelper.global_position == tile_crop_is_on * 16:
			self.queue_free()
			
			#Turn the tile beneath the crop back into dirt
			farm.set_cellv(tile_crop_is_on, farm.get_tileset().find_tile_by_name(CONSTANTS.DIRT_NAME))
			
	if event.is_action_pressed("action") and farm.currentTool == "Hoe":
		var crop_pos = self.global_position
		var tile_crop_is_on = farm.world_to_map(crop_pos)
		if gridhelper.global_position == tile_crop_is_on * 16:
			self.queue_free()
			
			Time.blightRate -= 1
			
			#Turn the tile beneath the crop back into dirt
			farm.set_cellv(tile_crop_is_on, farm.get_tileset().find_tile_by_name(CONSTANTS.DIRT_NAME))

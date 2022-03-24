extends KinematicBody2D

var velocity = Vector2.ZERO
export var speed = 100
var face_direction = Vector2(0, 1)
var currentTool = "Hoe"

# State Machine
enum STATES {WALK, IDLE, HOE, WATER, HARVEST}
var state = 1 # 1 means IDLE, index of states, default

onready var anim = $AnimationPlayer

func _ready():
	_change_state(STATES.IDLE)
	
func _change_state(new_state):
	# What the player does when switching to each state
	match new_state:
		STATES.IDLE:
			velocity = Vector2.ZERO
		STATES.WALK:
			pass
		STATES.HOE:
			velocity = Vector2.ZERO
		STATES.WATER:
			velocity = Vector2.ZERO
		STATES.HARVEST:
			velocity = Vector2.ZERO
	state = new_state

func get_input_direction():
	# Take direction input and put into input direction vector
	var input_direction = Vector2(
		int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")),
		int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
		)
	return input_direction

func _physics_process(delta):
		#Tracking which tool is used
		if Input.is_action_pressed("ui_1"):
			currentTool = "Harvest"
		if Input.is_action_pressed("ui_2"):
			currentTool = "Hoe"
		elif Input.is_action_pressed("ui_3"):
			currentTool = "Water"
		elif Input.is_action_pressed("ui_4"):
			currentTool = "Oat"
		elif Input.is_action_pressed("ui_5"):
			currentTool = "Potato"
		elif Input.is_action_pressed("ui_6"):
			currentTool = "Barley"
	
		#State Machine
		match state:
			STATES.IDLE:
				# If game is not paused
				if Time.time_speed > 0:	
					# check if player has movement action when in IDLE
					var input_direction = get_input_direction()
					if input_direction:
						_change_state(STATES.WALK)
						return
					
					#check if player tries to harvest while in idle
					if Input.is_action_pressed("harvest"):
						_change_state(STATES.HARVEST)
						
					if Input.is_action_pressed("action"):
						if currentTool == "Harvest":
							_change_state(STATES.HARVEST)
						if currentTool == "Hoe":
							_change_state(STATES.HOE)	
						elif currentTool == "Water":
							_change_state(STATES.WATER)
					
					# change idle animation depending on player's facing
					if face_direction.y == -1 and face_direction.x in [1, 0]:
						$AnimatedSprite.animation = 'farmer_idle_up'
					elif face_direction.y == 1 and face_direction.x in [-1, 0]:
						$AnimatedSprite.animation = "farmer_idle_down"
					elif face_direction.x == 1 and face_direction.y in [0, 1]:
						$AnimatedSprite.animation = 'farmer_idle_side'
						$AnimatedSprite.flip_v = false
						$AnimatedSprite.flip_h = false
					elif face_direction.x == -1 and face_direction.y in [0, -1]:
						$AnimatedSprite.animation = "farmer_idle_side"
						$AnimatedSprite.flip_v = false
						$AnimatedSprite.flip_h = true
				
			STATES.WALK:
				if Time.time_speed > 0:
					# check if player has no movement
					var input_direction = get_input_direction()
					if not input_direction:
						$Walking.stop()
						_change_state(STATES.IDLE)
						return
					elif !$Walking.playing:
						#Play walking audio
						$Walking.play()	
						
					#check if player tries to harvest while in idle
					if Input.is_action_pressed("harvest"):
						_change_state(STATES.HARVEST)	
					
					if Input.is_action_pressed("action"):
						if currentTool == "Harvest":
							_change_state(STATES.HARVEST)
						elif currentTool == "Hoe":
							_change_state(STATES.HOE)	
						elif currentTool == "Water":
							_change_state(STATES.WATER)
							
					# changing animation based on facing (and making face_direction variable for idle animation)
					if input_direction.y == -1 and input_direction.x in [1, 0]:
						$AnimatedSprite.play('farmer_walk_up')
					elif input_direction.y == 1 and input_direction.x in [-1, 0]:
						$AnimatedSprite.animation = 'farmer_walk_down'
					elif input_direction.x == 1 and input_direction.y in [0, 1]:
						$AnimatedSprite.animation = 'farmer_walk_side'
						$AnimatedSprite.flip_v = false
						$AnimatedSprite.flip_h = false
					elif input_direction.x == -1 and input_direction.y in [0, -1]:
						$AnimatedSprite.animation ="farmer_walk_side"
						$AnimatedSprite.flip_v = false
						$AnimatedSprite.flip_h = true
					input_direction = input_direction.normalized()
					face_direction = input_direction
					velocity = input_direction * speed
					move_and_slide(velocity, Vector2.ZERO)
					
			STATES.HOE:
				if Time.time_speed > 0:	
					# hoe animation
					if face_direction.y == -1 and face_direction.x in [1, 0]:
						$AnimatedSprite.animation = 'farmer_hoe_up'
					elif face_direction.y == 1 and face_direction.x in [-1, 0]:
						$AnimatedSprite.animation = "farmer_hoe_down"
					elif face_direction.x == 1 and face_direction.y in [0, 1]:
						$AnimatedSprite.animation = 'farmer_hoe_side'
						$AnimatedSprite.flip_v = false
						$AnimatedSprite.flip_h = false
					elif face_direction.x == -1 and face_direction.y in [0, -1]:
						$AnimatedSprite.animation = "farmer_hoe_side"
						$AnimatedSprite.flip_v = false
						$AnimatedSprite.flip_h = true
				
			STATES.WATER:
				if Time.time_speed > 0:	
					# water animation
					if face_direction.y == -1 and face_direction.x in [1, 0]:
						$AnimatedSprite.animation = 'farmer_water_up'
					elif face_direction.y == 1 and face_direction.x in [-1, 0]:
						$AnimatedSprite.animation = "farmer_water_down"
					elif face_direction.x == 1 and face_direction.y in [0, 1]:
						$AnimatedSprite.animation = 'farmer_water_side'
						$AnimatedSprite.flip_v = false
						$AnimatedSprite.flip_h = false
					elif face_direction.x == -1 and face_direction.y in [0, -1]:
						$AnimatedSprite.animation = "farmer_water_side"
						$AnimatedSprite.flip_v = false
						$AnimatedSprite.flip_h = true
					
			STATES.HARVEST:
				if Time.time_speed > 0:	
					# harvest animation
					if face_direction.y == -1 and face_direction.x in [1, 0]:
						$AnimatedSprite.animation = 'farmer_harvest_up'
					elif face_direction.y == 1 and face_direction.x in [-1, 0]:
						$AnimatedSprite.animation = "farmer_harvest_down"
					elif face_direction.x == 1 and face_direction.y in [0, 1]:
						$AnimatedSprite.animation = 'farmer_harvest_side'
						$AnimatedSprite.flip_v = false
						$AnimatedSprite.flip_h = false
					elif face_direction.x == -1 and face_direction.y in [0, -1]:
						$AnimatedSprite.animation = "farmer_harvest_side"
						$AnimatedSprite.flip_v = false
						$AnimatedSprite.flip_h = true
					#Harvest animation are tied to the function below
				
		#Play tool's sound whenever the player uses the action and tool is equipped
		if Input.is_action_pressed("action"):
			if Time.time_speed > 0:
				if currentTool == "Harvest":
					if !$Harvest.playing:
						$Harvest.play()
				elif currentTool == "Hoe":
					if !$Hoe.playing:
						$Hoe.play()
				elif currentTool == "Water":
					if !$Water.playing:
						$Water.play()
				elif currentTool == "Oat" and Time.oatSeed > 0:
					if !$Plant.playing:
						$Plant.play()
				elif currentTool == "Potato" and Time.potatoSeed > 0:
					if !$Plant.playing:
						$Plant.play()
				elif currentTool == "Barley" and Time.barleySeed > 0:
					if !$Plant.playing:
						$Plant.play()
						
		# stop sounds if game is paused
		if Time.time_speed == 0:
			$Harvest.stop()
			$Hoe.stop()
			$Water.stop()
			$Plant.stop()
			$Walking.stop()
				
					
func _on_AnimatedSprite_animation_finished():
	_change_state(STATES.IDLE)
	
func _on_gameOver():
	$Music.stop()
	$MusicGameOver.play()

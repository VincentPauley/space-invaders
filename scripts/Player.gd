extends KinematicBody2D

export(PackedScene) var projectile

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SPEED = 500
const EDGE_PADDING = 5 # < want to keep the player off of the edge entirely
var screen_size

onready var sprite = $Sprite
onready var timer = $Timer
var half_sprite_size

var player_min_x
var player_max_x

var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size.x
	half_sprite_size = sprite.texture.get_width() / 2
	
	player_min_x = 0 + half_sprite_size + EDGE_PADDING
	player_max_x = screen_size - half_sprite_size - EDGE_PADDING

func _process(delta):
	if Input.is_action_pressed('left'):
		position.x -= SPEED * delta
	if Input.is_action_pressed('right'):
		position.x += SPEED * delta

	position.x = clamp(position.x, player_min_x, player_max_x)
	
	if can_shoot and Input.is_action_pressed('shoot'):
		# generate a new scene instance and add it to the parent
		var new_projectile = projectile.instance()
		
		new_projectile.position = position
		# NOTE: don't add to player or they will move horizontally with the player
		get_parent().add_child(new_projectile)
		can_shoot = false
		timer.start()

func _on_Timer_timeout():
	can_shoot = true

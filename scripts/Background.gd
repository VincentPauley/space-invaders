extends Node2D

const MOVE_SPEED = 500
const OFFSET = 64

onready var topBackground = $TopBackground
onready var bottomBackground = $BottomBackground

var top_position
var bottom_position

# Called when the node enters the scene tree for the first time.
func _ready():
	top_position = topBackground.position.y
	bottom_position = get_viewport_rect().size.y

func _process(delta):
	# move both background panels down at a constant rate
	topBackground.position.y += MOVE_SPEED * delta
	bottomBackground.position.y += MOVE_SPEED * delta

	
	if topBackground.position.y >= bottom_position + OFFSET:
		topBackground.position.y = top_position
	elif bottomBackground.position.y >= bottom_position + OFFSET:
		bottomBackground.position.y = top_position

extends Area2D

export var speed = 1300
export var damage = 10

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect('area_entered', self, '_on_area_entered')

func _process(delta):
	position.y -= speed * delta
	# Ensure that projectile is removed once
	# it's offscreen and irrelevant
	if position.y < -2000:
		queue_free()

func _on_area_entered(area):
	if area.is_in_group('Enemies'):
		area.add_damage(damage)
		queue_free()
		

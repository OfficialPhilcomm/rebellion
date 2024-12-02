extends Node3D

var right = true
var velocity = Vector3(0, 0, 0)
var speed = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if right:
		velocity = Vector3(speed, 0, 0)
	else:
		velocity = Vector3(-speed, 0, 0)
		
	translate(velocity * delta)
	
	if abs(position.x) > 8:
		right = !right

extends Node3D

@onready var mesh_instance = $MeshInstance3D

var speed = 1
var lifespan = 0
var material: StandardMaterial3D

# Called when the node enters the scene tree for the first time.
func _ready():
	mesh_instance.set_surface_override_material(0, material)
	#look_at(Vector3(0, 0, 0), Vector3.UP)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lifespan += delta
	
	if lifespan > 10:
		queue_free()
	
	translate(Vector3.FORWARD * delta * speed)
	

extends Node3D

@export var delay: float = 0
@export var interval: float = .5
@export var cannons: int = 4
@export var material: StandardMaterial3D
@export var outline_material: Material
@onready var body = $MeshInstance3D2
@onready var intercept = $MeshInstance3D5

signal componentClicked(component)

var lastShot = 0

var laser = preload("res://objects/laser.tscn")
var target : Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	lastShot -= delay
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lastShot += randf_range(0, delta)

	if not target:
		return

	if target:
		#look_at(target.global_position, Vector3.UP)
		var i = get_intercept(global_position, 5, target.global_position, target.velocity)
		intercept.global_position = i
		look_at(i, Vector3.UP)
	
	if lastShot > interval:
		var laserInstance = laser.instantiate()
		laserInstance.speed = 5
		laserInstance.transform = global_transform
		laserInstance.material = material
		get_tree().root.add_child(laserInstance)
		lastShot = 0

func get_intercept(shooter_pos:Vector3,
					bullet_speed:float,
					target_position:Vector3,
					target_velocity:Vector3) -> Vector3:
	var a:float = bullet_speed*bullet_speed - target_velocity.dot(target_velocity)
	var b:float = 2*target_velocity.dot(target_position-shooter_pos)
	var c:float = (target_position-shooter_pos).dot(target_position-shooter_pos)
	# Protect against divide by zero and/or imaginary results
	# which occur when bullet speed is slower than target speed
	var time:float = 0.0
	
	if bullet_speed > target_velocity.length():
		time = (b+sqrt(b*b+4*a*c)) / (2*a)
		print("yes")
	#print(target_position, time, target_velocity, target_velocity.length())
	return target_position+time*target_velocity

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if Input.is_action_just_pressed("mouse_right"):
		componentClicked.emit(self)

func _on_mouse_entered():
	body.material_overlay = outline_material

func _on_mouse_exited():
	body.material_overlay = null

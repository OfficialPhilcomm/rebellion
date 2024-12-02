extends Node3D

@export var target: Node3D
@export var highlight_shader: Material
@onready var turrets = [$Turret, $Turret2, $Turret3, $Turret4, $Turret5, $Turret6]
@onready var highlight = $Highlight
@onready var body = $Body
var MAX_SPEED = 0.5
@export var speed : float = 1

signal shipClicked(ship)
signal componentClicked(component, right_click)

# Called when the node enters the scene tree for the first time.
func _ready():
	if target:
		#turrets.all(func(turret): turret.target = target)
		for turret in turrets:
			turret.target = target
		
		print(Vector3.FORWARD)

func set_target(t):
	for turret in turrets:
		turret.target = t

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#rotate_y(.5 * delta * 0.2)
	translate(Vector3.FORWARD * delta * (speed * MAX_SPEED))
	pass

func select():
	highlight.visible = true
	#body.material_overlay = outline_shader

func unselect():
	highlight.visible = false
	#body.material_overlay = null

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if Input.is_action_just_pressed("mouse_left"):
		shipClicked.emit(self, false)
	elif Input.is_action_just_pressed("mouse_right"):
		shipClicked.emit(self, true)

func _on_component_clicked(component):
	componentClicked.emit(component)


func _on_mouse_entered():
	body.material_overlay = highlight_shader

func _on_mouse_exited():
	body.material_overlay = null

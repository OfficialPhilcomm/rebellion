extends Node3D

@onready var test_target = $TestTarget
@onready var camera = $Camera3D

var ships = []
var star_destroyer = preload("res://objects/star_destroyer.tscn")
var selected_ship = null

# Called when the node enters the scene tree for the first time.
func _ready():
	#var shipInstance = star_destroyer.instantiate()
	#add_child(shipInstance)
	#ships.append(shipInstance)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	test_target.translate(Vector3(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"), 0) * delta * 10)
	pass


func _on_component_clicked(component):
	if selected_ship:
		selected_ship.set_target(component)
	pass # Replace with function body.


func _on_ship_clicked(ship, right_click):
	if not right_click:
		if selected_ship == ship:
			selected_ship.unselect()
			selected_ship = null
		else:
			if selected_ship:
				selected_ship.unselect()
			
			ship.select()
			selected_ship = ship
	else:
		if selected_ship:
			selected_ship.set_target(ship)

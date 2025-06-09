extends Camera3D
@export var player:CharacterBody3D
@onready var zea : playerza=$Player.Pivot
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#rotate_y(0.01)
	#position=Vector3(0,0,1)
	position = zea
	#look_at(target, Vector3.UP)Pivot

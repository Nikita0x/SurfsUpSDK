# extends Node3D

# @export var speed_deg: Vector3 = Vector3(25, 50, 75)

# func _process(delta: float) -> void:
# 	var rad = speed_deg * delta * (PI / 180)
	
# 	# Rotation calls …
# 	rotate_object_local(Vector3.RIGHT,   rad.x)
# 	rotate_object_local(Vector3.UP,      rad.y)
# 	rotate_object_local(Vector3.FORWARD, rad.z)
	
# 	# Debug prints must be inside the function where rad exists
# 	print("rad: x", rad.x)
# 	print("rad: y", rad.y)
# 	print("rad: z", rad.z)



extends Node3D

@export var min_speed_deg := Vector3(120, 120, 120)
@export var max_speed_deg := Vector3(120, 120, 120)

var speed_deg := Vector3.ZERO
var rng := RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	speed_deg = Vector3(
		rng.randf_range(min_speed_deg.x, max_speed_deg.x),
		rng.randf_range(min_speed_deg.y, max_speed_deg.y),
		rng.randf_range(min_speed_deg.z, max_speed_deg.z)
	)
	print("Random speed = ", speed_deg)

func _process(delta: float) -> void:
	var rad = speed_deg * delta * (PI / 180)
	rotate_object_local(Vector3.RIGHT,   rad.x)
	rotate_object_local(Vector3.UP,      rad.y)
	rotate_object_local(Vector3.FORWARD, rad.z)

extends DirectionalLight3D

@export var degrees_per_second: float = 5.0  # speed  – adjustable in the editor
@export var axis: Vector3 = Vector3(0, 0, 1)  # rotate around Z-axis by default

func _process(delta: float) -> void:
	rotate(axis.normalized(), deg_to_rad(degrees_per_second) * delta)

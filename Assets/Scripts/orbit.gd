extends Node3D

@export var target: Node3D     # The object to orbit around (assign in Inspector)
@export var radius: float = 10.0
@export var angular_speed: float = 30.0  # Degrees per second

var angle_deg := 0.0

func _process(delta: float) -> void:
    if not target:
        return

    # Increment angle, wrap at 360°
    angle_deg = fmod(angle_deg + angular_speed * delta, 360.0)
    _update_position()

func _ready() -> void:
    # Initialize position at the specified radius from target
    if target:
        angle_deg = 0.0
        _update_position()
    else:
        push_warning("No target assigned — orbiting won't work!")

func _update_position() -> void:
    # Calculate orbit offset in local XZ plane
    var rad = deg_to_rad(angle_deg)
    var offset = Vector3(cos(rad), 0, sin(rad)) * radius
    # Set global position so we orbit at the desired radius
    global_position = target.global_position + offset
    # Optionally face the target:
    look_at(target.global_position, Vector3.UP)


# var initial_height: float

# func _ready() -> void:
#     initial_height = global_position.y
#     _update_position()

# func _update_position() -> void:
#     var rad = deg_to_rad(angle_deg)
#     var offset = Vector3(cos(rad), 0, sin(rad)) * radius
#     global_position = target.global_position + offset
#     global_position.y = initial_height

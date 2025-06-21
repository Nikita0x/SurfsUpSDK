extends Node3D

@export var distance := 1.0
@export var speed := 1.0

var traveled := 0.0

func _process(delta):
    var step = speed * delta
    if traveled + step >= distance:
        step = distance - traveled  # don’t overshoot
    position += Vector3(0, 0, step)
    traveled += step
    if traveled >= 10:
        set_process(false)  # stop moving

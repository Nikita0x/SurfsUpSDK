extends Node3D

@export var target: Node3D
@export var use_elliptical_orbit: bool = false  # Toggle for elliptical/tilted orbit
@export var angular_speed: float = 1.0          # Orbit angular speed in radians per second

var initial_offset: Vector3      # initial position offset from target
var base_radius: float          # horizontal distance (radius) from target
var angle: float = 0.0          # accumulated rotation angle

func _ready() -> void:
    if target == null:
        push_error("Orbit script has no target assigned.")
        return
    # Calculate the initial offset from target in global coordinates.
    # This uses the node's position as set in the editor relative to the target.
    initial_offset = global_position - target.global_position
    base_radius = Vector2(initial_offset.x, initial_offset.z).length()
    # No movement done here; we only record initial state to avoid overriding editor placement.

func _physics_process(delta: float) -> void:
    if target == null:
        return  # No target to orbit
    
    # Increment the orbit angle based on speed (frame-rate independent)
    angle += angular_speed * delta

    if use_elliptical_orbit:
        # Elliptical or tilted orbit path
        var radius_x = base_radius
        var radius_z = base_radius
        # Allow different X/Z radii if initial offset has distinct components
        if abs(initial_offset.x) > 0.01:
            radius_x = abs(initial_offset.x)
        if abs(initial_offset.z) > 0.01:
            radius_z = abs(initial_offset.z)
        # Compute phase offset so orbit starts at the initial position (approximately)
        var phase0 := 0.0
        if radius_x != 0 and radius_z != 0:
            phase0 = atan2(initial_offset.z / radius_z, initial_offset.x / radius_x)
        # Parametric elliptical coordinates relative to target
        var orbit_x = radius_x * cos(angle + phase0)
        var orbit_z = radius_z * sin(angle + phase0)
        # Vertical position oscillation (tilt): keep initial height offset as cosine amplitude
        var orbit_y = initial_offset.y
        if abs(initial_offset.y) > 0.01:
            orbit_y = initial_offset.y * cos(angle + phase0)
        # Update global position relative to target
        global_position = target.global_position + Vector3(orbit_x, orbit_y, orbit_z)

    else:
        # Flat circular orbit in XZ plane (constant radius, constant height)
        # Rotate the initial offset vector around the global Y-axis by `angle`
        var rotated_vec: Vector3 = initial_offset.rotated(Vector3.UP, angle)
        # Set new position: target's position + rotated offset
        global_position = target.global_position + rotated_vec

extends OmniLight3D

# TODO: doesnt work
@export var enable_random := true              # Toggle color changing
@export var change_interval := 2.0             # Seconds between picking a new color
@export var interp_speed := 3.0                # Speed of color interpolation

var target_color: Color = light_color
var timer := 0.0

func _ready() -> void:
    randomize()
    if enable_random:
        _pick_random_color()

func _process(delta: float) -> void:
    if enable_random:
        timer += delta
        if timer >= change_interval:
            timer = 0.0
            _pick_random_color()

    # Smoothly interpolate current light_color toward target
    light_color = light_color.lerp(target_color, clamp(delta * interp_speed, 0.0, 1.0))

func _pick_random_color() -> void:
    # Generate a visually pleasing random color using HSV
    target_color = Color.from_hsv(
        randf(),                 # Random hue
        randf_range(0.5, 1.0),   # Bright saturation
        randf_range(0.7, 1.0)    # Brightness value
    )
    print("🌈 New target color:", target_color)  # Debug output

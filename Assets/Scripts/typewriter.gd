extends Label3D

@export var letters_per_second := 15.0
@export var pause_seconds := 15.0

@export var lines: Array[String] = [
    "GOOGOO GAGA MENTALITY",
    "https://steamcommunity.com/id/NikitaChc/"
]

var current_index := 0
var text_chars := ""
var total_chars := 0
var elapsed := 0.0
var is_typing := false
var is_deleting := false
var pause_timer := 0.0

func _ready():
    _start_typing_line(current_index)

func _process(delta: float) -> void:
    if is_typing:
        elapsed += delta * letters_per_second
        var show = min(int(elapsed), total_chars)
        text = text_chars.substr(0, show)
        if show >= total_chars:
            is_typing = false
            pause_timer = 0.0
            is_deleting = true
            elapsed = total_chars
    elif is_deleting:
        pause_timer += delta
        if pause_timer >= pause_seconds:
            elapsed -= delta * letters_per_second
            var show = max(int(elapsed), 0)
            text = text_chars.substr(0, show)
            if show == 0:
                is_deleting = false
                pause_timer = 0.0
                current_index = (current_index + 1) % lines.size()
                _start_typing_line(current_index)
    else:
        # fallback to be safe
        pause_timer += delta

func _start_typing_line(index: int) -> void:
    text_chars = lines[index]
    total_chars = text_chars.length()
    elapsed = 0.0
    is_typing = true
    is_deleting = false
    pause_timer = 0.0



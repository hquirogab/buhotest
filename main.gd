extends Control

@onready var timer = $Timer
@onready var label = $TimerLabel
@onready var start_button = $StartButton
@onready var buho = $Buho as AnimatedSprite2D


var total_seconds = 25 * 1

func _ready():
	label.text = format_time(total_seconds)
	timer.timeout.connect(update_time)
	buho.play("idle")
	
func start_pomodoro():
	print("🔵 Se presionó el botón Pomodoro")
	start_button.disabled = true
	timer.start()
	buho.play("estudiar")
	
func format_time(seconds):
	var mins = seconds / 60
	var secs = seconds % 60
	return "%02d:%02d" % [mins, secs]

func update_time():
	if total_seconds > 0:
		total_seconds -= 1
		label.text = format_time(total_seconds)
	else:
		timer.stop()
		label.text = "¡Así se hace! +10 peces"
		start_button.disabled = false
		total_seconds = 25 * 60
		buho.play("idle")

extends Control

@onready var timer = $Timer
@onready var label = $TimerLabel
@onready var start_button = $StartButton
@onready var buho = $Buho as AnimatedSprite2D
@onready var fish_label = $FishLabel
@onready var tienda_ventana = $TiendaVentana
@onready var tienda_button = $TiendaButton
@onready var buy_text_timer = $BuyTextTimer
@onready var buy_text = $BuyTextLabel

var total_seconds = 5 * 1
var peces = 10
var inventario = []

func _ready():
	label.text = format_time(total_seconds)
	update_fish()
	timer.timeout.connect(update_time)
	buho.play("idle")
	tienda_button.pressed.connect(toggle_tienda)
	
func start_pomodoro():
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
		peces += 10
		update_fish()
		start_button.disabled = false
		total_seconds = 5 * 1
		buho.play("idle")
		
func update_fish():
	fish_label.text = str(peces)
	
func toggle_tienda():
	tienda_ventana.visible = not tienda_ventana.visible
	
func comprar_cama():
	var costo = 2
	var item_Name = "cama"
	if peces >= costo:
		peces -= costo
		inventario.append("cama")
		update_fish()
		buy_item_label(item_Name)
	else:
		print("No tienes suficientes peces")
		
func buy_item_label(item_Name):
	buy_text_timer.start()
	buy_text.show()
	buy_text.text = "¡Compraste una " + item_Name + "!"
	
func hide_item_label():
	buy_text.hide()

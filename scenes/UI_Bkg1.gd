extends Control

#Variable global porque necesitamos acceso para todo el programa.
var player_words = []
var prompts = ["un nombre", "un sustantivo", "un adverbio", "un adjetivo"]
var storia = "Me llamo %s. Soy un %s y mato %s. Valgo %s."
#onready sirve para avisarle a Godot que esta variable existirá más abajito.
onready var PlayerText = $VBoxContainer/HBoxContainer/playerText
onready var DisplayText = $VBoxContainer/guion1

func _ready():
	DisplayText.text = "Bienvenido, puto."
	#Enfoca la caja de input.
	PlayerText.grab_focus()
	check_player_words_length()

func add_to_player_words():
	player_words.append(PlayerText.text)
	DisplayText.text = ""
	PlayerText.clear()
	check_player_words_length()

func is_story_done():
	#nada corre debajo de return.
	return player_words.size() == prompts.size()

func check_player_words_length():
	if is_story_done():
		end_game()
	else:
		prompt_player()

func tell_story():
	DisplayText.text = storia % player_words

func prompt_player():
	DisplayText.text += "Podrías darme un"+prompts[player_words.size()] + ",pofabó."

func _on_TextureButton_pressed():
	print("Botón presionado")
	if is_story_done():
		print("Se acabó el juego.")
		#get_tree toma toda la escena y podemos modificarla.
		get_tree().reload_current_scene()
	else:
		add_to_player_words()

func _on_playerText_text_entered(new_text):
	add_to_player_words()

func end_game():
	#queue_free LIBERA el elemento de la memoria. Ésto permite optimizar el juego.
	PlayerText.queue_free()
	$VBoxContainer/HBoxContainer/btn_texto.text = "Ko"
	tell_story()

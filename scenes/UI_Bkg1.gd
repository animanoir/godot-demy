extends Control

#Variable global porque necesitamos acceso para todo el programa.
var player_words = []
#Para usar un diccionario se usan llaves, en lugar de corchetes que son para 
#arreglos.

#var template = [
#		{
#		#Diccionario 1
#		"prompts": ["un nombre", "un sustantivo", "un adverbio", "un adjetivo"],
#		"story": "Tu nombre es %s. Eres un %s. Coges %s. Vales %s."
#		},
#		#Diccionario 2
#		{
#		"prompts": ["zebra", "lagarto", "pene", "vagina"],
#		"story": "Sexo %s anal y %s en %s. %s"
#		},
#		#Diccionario 3
#		{
#		"prompts": ["cebolla", "artes", "pito", "México"],
#		"story": "Jajaja %s jojojo %s en %s. %s"
#		}
#	]
	
var current_story = {}

#onready sirve para avisarle a Godot que esta variable existirá más abajito.
onready var PlayerText = $VBoxContainer/HBoxContainer/playerText
onready var DisplayText = $VBoxContainer/guion1

func _ready():
	pick_current_story()
	DisplayText.text = "Bienvenido, puto."
	#Enfoca la caja de input.
	PlayerText.grab_focus()
	check_player_words_length()

func pick_current_story():
	#randi() debe "modularse" con un número. Comienza desde 0; si queremos que
	#comience desde 1, le sumamos un 1 al número.
	randomize() #randomize se aproxima al azar (para que no salga lo mismo 
	#siempre }).
#	current_story = template[ randi() % template.size() ]
	#Obtiene cuántos hijos tiene un nodo.
	var stories = $StoryBook.get_child_count()
	var selected_story = randi() % stories
	current_story.prompts = $StoryBook.get_child(selected_story).prompts
	current_story.story = $StoryBook.get_child(selected_story).story

func add_to_player_words():
	player_words.append(PlayerText.text)
	DisplayText.text = ""
	PlayerText.clear()
	check_player_words_length()

func is_story_done():
	#nada corre debajo de return.
	return player_words.size() == current_story.prompts.size()

func check_player_words_length():
	if is_story_done():
		end_game()
	else:
		prompt_player()

func tell_story():
	DisplayText.text = current_story.story % player_words

func prompt_player():
	DisplayText.text += "Podrías darme un"+current_story.prompts[player_words.size()] + ",pofabó."

func _on_TextureButton_pressed():
	print("Botón presionado")
	if is_story_done():
		print("Se acabó el juego.")
		#get_tree toma toda la escena y podemos modificarla.
		get_tree().reload_current_scene()
	else:
		add_to_player_words()

func _on_playerText_text_entered(_new_text):
	add_to_player_words()

func end_game():
	#queue_free LIBERA el elemento de la memoria. Ésto permite optimizar el juego.
	PlayerText.queue_free()
	$VBoxContainer/HBoxContainer/btn_texto.text = "Ko"
	tell_story()

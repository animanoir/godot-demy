extends Control

#Variable global porque necesitamos acceso para todo el programa.
var player_words = []
var nombres = ["Óscar", "Ita", "Jasso"]
var storia = "Beso mortal entre %s y %s. Desprecio total de %s."
#onready sirve para avisarle a Godot que esta variable existirá más abajito.
onready var PlayerText = $VBoxContainer/HBoxContainer/playerText
onready var DisplayText = $VBoxContainer/guion1

#func _ready():
#	DisplayText.text = storia % nombres
	
func _on_playerText_text_entered(new_text):
	add_to_player_words(new_text)

func _on_TextureButton_pressed(new_words):
	add_to_player_words(new_words)

func add_to_player_words(new_words):
	player_words.append(PlayerText.text)

func is_story_done():
	#nada corre debajo de return.
	return player_words.size() == nombres.size()

func check_player_words_length():
	if is_story_done():
		tell_story()
	else:
		prompt_player()

func tell_story():
	DisplayText.text = storia % nombres 

func prompt_player():
	DisplayText.text = "May I have "+nombres[player_words.size()] + "pofabó."

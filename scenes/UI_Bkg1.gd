extends Control

#Variable global porque necesitamos acceso para todo el programa.
var player_words = []
var nombres = ["Óscar", "Ita", "Jasso"]
var storia = "Beso mortal entre %s y %s. Desprecio total de %s."
#onready sirve para avisarle a Godot que esta variable existirá más abajito.
onready var PlayerText = $VBoxContainer/HBoxContainer/playerText
onready var DisplayText = $VBoxContainer/guion1

func _ready():
	DisplayText.text = storia % nombres
	
func _on_TextureButton_pressed():
	var newWords = $VBoxContainer/HBoxContainer/playerText.text
	updateDisplayText(newWords)

func updateDisplayText(words):
	DisplayText.text = words
	PlayerText.clear()

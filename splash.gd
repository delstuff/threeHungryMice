
extends Node2D



func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func startGame():
	get_tree().change_scene("res://game.scn")

func _on_TextureButton_pressed():
	get_node("aniTitle").play("start")
	
	


extends Control

var input_states = preload("res://input_states.gd")
var enter = input_states.new("ui_accept")
var esc = input_states.new("ui_cancel")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	
func _process(delta):
	
	
	var cScore = get_parent().get_node("mouse").score
	get_node("score").set_text(str(cScore))
	
	if esc.check() == 3 and get_parent().get_node("mouse").death == false:
		get_node("Popup").set_exclusive(true)
		get_node("Popup").popup()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().set_pause(true)
		
	#	get_tree().set_pause(true)
	#	if enter.check() == 3:
	#		get_tree().set_pause(false)
	#	if esc.check() == 3:
	#		get_tree().change_scene("res://spash.scn")
	
	



func _on_continue_pressed():
	get_tree().set_pause(false)
	get_node("Popup").set_exclusive(false)
	get_node("Popup").hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	


func _on_exit_pressed():
	get_tree().set_pause(false)
	get_tree().change_scene("res://spash.scn")
	print("e")

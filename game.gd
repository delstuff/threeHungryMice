
extends Node2D

var time = 0.0
var catAp = 0
var catAttack = false
var thirty = false
var fortyfive = false
var sixty = false

func _ready():
	set_process(true)
	Input.warp_mouse_pos(Vector2(240,720))
	
func _process(delta):
	time = time + 1 * delta
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	if get_node("mouse").score == 1000:
		if catAttack == false:
			catAp = randi() % 4
			catAttack = true
			if catAp == 0:
				pass
			elif catAp == 1:
				pass
			elif catAp == 2:
				pass
			elif catAp == 3:
				pass
			
	if time > 30.0 and thirty == false:
		get_node("mouse").speed += 10
		thirty = true
	if time > 45.0 and fortyfive == false:
		get_node("mouse").speed += 20
		fortyfive = true
	if time > 60.0 and sixty == false:
		get_node("mouse").speed += 30
		sixty = true
		
		
	
	
	



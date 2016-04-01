
extends KinematicBody2D

var padPos
var playerPos
var headLPos
var headRPos
var headLch = false
var headL = null
var headRch = false
var headR = null

func _ready():
	set_fixed_process(true)
	headL = get_node("heads/headLsprite")
	headR = get_node("heads/headRsprite")
	
func _fixed_process(delta):
	
	padPos = get_parent().get_node("pad").get_pos()
	playerPos = get_parent().get_node("mouse").get_pos()
	headLPos = headL.get_global_pos()
	headRPos = headR.get_global_pos()
	
	move_to(Vector2(padPos.x,732))
	
	headL.look_at(playerPos)
	headR.look_at(playerPos)
	
	if headLPos.x > playerPos.x:
		if headLch == false:
			headL.set_frame(1)
			headLch = true
	else:
		headLch = false
		headL.set_frame(0)
		
	if headRPos.x > playerPos.x:
		if headRch == false:
			headR.set_frame(1)
			headRch = true
	else:
		headRch = false
		headR.set_frame(0)
	
	
	
	
	
	
	




extends KinematicBody2D

var taken = false
var cheeseTaken = preload("res://cheeseTaken.scn")
var cheeseTakenCount = 0
var inst = false

func _ready():
	set_process(true)
	
func _process(delta):
	
	if taken == true:
		get_node("cheeseSprite").hide()
		if has_node("CollisionShape2D"):
			get_node("CollisionShape2D").queue_free()
		if inst == false:
			
			cheeseTakenCount += 1
			var cheeseTakenInst = cheeseTaken.instance()
			cheeseTakenInst.set_name("cheese"+str(cheeseTakenCount))
			add_child(cheeseTakenInst)
			#get_node("cheese"+str(cheeseTakenCount)).set_pos(get_pos())
			inst = true




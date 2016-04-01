
extends RigidBody2D

var touch = false
var speed = 310

var resetTimer = 0
var death = false

var score = 0
var lives = 3

var pos = Vector2()
var oldPos = Vector2()
var movement = Vector2()
var leftRight = ""
var leftRightPre = ""
var leftRightNext = "right"
var upDown = ""
var upDownPre = ""
var upDownNext = "down"

var rot = 0.0
var oldRot = 0.0
var rotChange = 0.0
var highRot = false

var aniPlayer = null
var ani = ""
var aniNew = ""

var complete = false

#var cheeseTaken = preload("res://cheeseTaken.scn")
#var cheeseTakenCount = 0



func _ready():

	set_fixed_process(true)
	
	aniPlayer = get_node("aniMouse")
	
func _fixed_process(delta):
	
	upDownPre = upDown
	upDown = upDownNext
	
	leftRightPre = leftRight
	leftRight = leftRightNext
	
	if ani != aniNew:
		aniNew = ani
		aniPlayer.play(ani)
	
	#movement detect
	pos = get_pos()
	movement = (pos - oldPos)
	oldPos = pos
	
	if movement.x < 0:
		leftRightNext = "left"
	else:
		leftRightNext = "right"
	if movement.y < 0:
		upDownNext = "up"
	else:
		upDownNext = "down"
		
	#rotation detect
	rot = get_rot()
	rotChange = rot-oldRot
	if rotChange > 0.1 or rotChange < -0.1:
		highRot = true
	else:
		highRot = false
	oldRot = rot
	
	#orientation
	#left-right
	if leftRight == "right" and leftRightNext == "left" and death == false:
		set_scale(get_scale() * Vector2(-1,get_scale().y))
	elif leftRight == "left" and leftRightNext == "right" and death == false:
		set_scale(get_scale() * Vector2(1,get_scale().y))
		
	#up-down
	if upDown == "down" and upDownNext == "up" and death == false:
		set_scale(get_scale() * Vector2(get_scale().x,-1))
	elif upDown == "up" and upDownNext == "down" and death == false:
		set_scale(get_scale() * Vector2(get_scale().x,1))
		
	if highRot == true:
		ani = "rot"
	else:
		ani = "idle"
	
	if score == 2600 and complete == false:
		get_parent().get_node("hud/complete").show()
		if Input.is_action_pressed("ui_accept"):
			get_tree().reload_current_scene()
		if Input.is_action_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().change_scene("res://spash.scn")
		set_angular_velocity(get_angular_velocity()*15)
		complete = true
	

func _integrate_forces(state):
	
	if touch == true:
		var mousePos = get_global_pos()
		var padPos = get_parent().get_node("pad").get_global_pos()
		var padToMouse = (mousePos - padPos).normalized()
		set_linear_velocity(padToMouse * speed)
		touch = false
		
		


func _on_RigidBody2D_body_enter( body ):
	if body.is_in_group("pad"):
		touch = true
		get_parent().get_node("Camera2D/camShaker").play("pad")
		get_node("sfx").play("pad")
		#var randHop = randi() % 3
		#if randHop == 1:
		#	get_node("sfx").play("hop")
		
	if body.is_in_group("cheese"):
		score += 100
		get_parent().get_node("Camera2D/camShaker").play("camShake")
		body.taken = true
		get_node("sfx").play("cheese")
		#var randCheese = randi() % 3
		#if randCheese == 1:
		#	get_node("sfx").play("yeah")
		
	if body.is_in_group("cheese200"):
		score += 200
		set_linear_velocity(get_linear_velocity() * 1.2)
		body.queue_free()
	
	if body.is_in_group("death"):
		resetTimer += 1
		set_linear_velocity(Vector2(0,0))
		if death == false and complete == false:
			get_parent().get_node("Camera2D/camShaker").play("death")
			lives -= 1
			get_node("sfx").play("no")
			get_node("sfx").play("hit")
			get_node("blood").set_emitting(true)
			death = true
			get_parent().get_node("hud/gameOver").show()
		if Input.is_action_pressed("ui_accept"):
			get_tree().reload_current_scene()
		if Input.is_action_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			#get_tree().quit() #todo: change_scene to spashscreen
			get_tree().change_scene("res://spash.scn")
		if resetTimer > 30:
			hide()
			
	if body.is_in_group("stage"):
		get_parent().get_node("Camera2D/camShaker").play("smallShake")
		get_node("sfx").play("hit")
		

extends CharacterBody3D
#@onready var _cam = $CameraPivot/SpringArm3D/Camera3D as Camera3D
@onready var _cam = $Pivot/Character/CameraPivot/Camera3D as Camera3D
@onready var _collision = $CollisionShape3D as CollisionShape3D
# How fast the player moves in meters per second.
@export var speed:float = 0
@export var speedback:float = 0
@export var velo = Vector3()
#@export var targetcam = target_velocity
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 200
var angle:float = 0
var my_basis = Basis.IDENTITY
var anglespeedl:float =0
var anglespeedr:float =0
##
var aaa = 0
func _physics_process(delta):
	# We create a local variable to store the input direction.
	var target_velocity = Vector3()
													# We check for each move input and update the direction accordingly.
	#aaa-=0.001
	_cam.position = Vector3(0,0,0)
	
	#_cam.rotate_y(0.001)
	if Input.is_action_pressed("move_forward"): #&& speedback==0:
		speedback+=1
		if speedback>=0:	
			while speed < 150:
				speed+=1
				break
			
			
	if speed > 0:
		if Input.is_action_pressed("move_left"):
			while anglespeedl < 0.05:
				anglespeedl+=0.003
				break
			angle=angle+speed*0.00005 + anglespeedl
			
				
		if Input.is_action_pressed("move_right"):
			while anglespeedr < 0.05:
				anglespeedr+=0.005
				break
			angle=angle-anglespeedr
			
	
	if Input.is_action_pressed("move_back"):
		speed-=0.5
		if speed<=0:	
			while speedback > -150:
				speedback-=1
				break
				
				
	if speedback < 0:
		if Input.is_action_pressed("move_left"):
			angle-=0.05
			
				
		if Input.is_action_pressed("move_right"):
			angle+=0.05
			

	
	if (Input.is_action_pressed("move_forward") == false):
		while speed > 0 :
			speed -= 1
			break
					
	if (Input.is_action_pressed("move_back") == false):
		while speedback < 0 :
			speedback += 1
			break		
					
	if (Input.is_action_pressed("move_left") == false):
		anglespeedl=0	
	if (Input.is_action_pressed("move_right") == false):
		anglespeedr=0	
	
	#
	if Input.is_action_pressed("jump"):
		#angle +=5
		target_velocity.y += 5 
	
	
	$Pivot.basis = basis.rotated(Vector3.UP, angle)
	_collision.basis = basis.rotated(Vector3.UP, angle)
	#$player.basis = basis.rotated(Vector3.UP, angle)
	
	
	
												# Ground Velocity

	target_velocity.x = (speed + speedback) * delta
	target_velocity = target_velocity.rotated(Vector3.UP, angle)#.normalized()
	
		
												# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
												#target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		target_velocity.y = target_velocity.y -  (fall_acceleration * delta)
												# Moving the Character
	
	velocity = target_velocity
	move_and_slide()

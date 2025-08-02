extends CharacterBody2D

@export var moveSpeed: float = 150.0 
@export var upwardSpeed: float = 40.0
@export var movementEnabled: bool = true
var canDie:bool = true
@onready var animSprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	
	if not movementEnabled:
		return

	var direction = 0.0
	if Input.is_action_pressed("left"):
		direction -= 1
	elif Input.is_action_pressed("right"):
		direction += 1

	velocity.x = direction * moveSpeed
	velocity.y = -upwardSpeed 

	move_and_slide()

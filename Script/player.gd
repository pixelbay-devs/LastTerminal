extends CharacterBody2D

@export var movementEnabled: bool = true
@export var moveSpeed: float = 150.0
@export var playerLabel: Label
@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var cam: Camera2D = $Camera2D2
var canMove:bool = true
var isHidden: bool = false
var score: int = 0
func _physics_process(delta: float) -> void:
	if isHidden:
		visible = false
	if isHidden == false: 
		visible = true
	if !movementEnabled:
		animatedSprite.play("idle")
	if movementEnabled && isHidden==false:
		move()

func move():
	var inputVector := Vector2.ZERO
	inputVector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	inputVector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	inputVector = inputVector.normalized()
	velocity = inputVector*moveSpeed
	if inputVector.length_squared()>0:
		velocity = inputVector*moveSpeed
		playWalkAnim(inputVector)
	else:
		velocity = Vector2.ZERO
		animatedSprite.play("idle")
	move_and_slide()

func playWalkAnim(dir: Vector2):
	if abs(dir.x)>abs(dir.y):
		animatedSprite.play("right")
		animatedSprite.flip_h=dir.x<0
	else:
		if dir.y<0: 
			animatedSprite.play("up")
		else:
			animatedSprite.play("down")
		animatedSprite.flip_h = false

func isPlayerHidden() -> bool:
	return isHidden
func flipMovement()-> bool:
	return movementEnabled!=movementEnabled

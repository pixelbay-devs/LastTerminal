extends Area2D

@export var isFakeDoor: bool = false 
@export var doorOpened: bool = false 
@export var tentacleManager: NodePath   
@export var isdoorMat: bool = false
@export var tpTarget: Node2D
@onready var doorSound: AudioStreamPlayer2D= $AudioStreamPlayer2D
@onready var animPlayer: AnimationPlayer = $AnimationPlayer
@onready var animSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interactPrompt: CanvasItem = $Label
@onready var interactionArea: CollisionShape2D = $CollisionShape2D
@export var player: CharacterBody2D
@onready var fakeSound: AudioStreamPlayer2D = $AudioStreamPlayer2D2
var playerInArea: bool = false

func _ready():
	fakeSound.stream = preload("res://Music/heavy-breathing-14431.ogg")
	interactPrompt.visible = false
	interactionArea.disabled = false
	if not isdoorMat:
		interactPrompt.text = "Press E to go to next room"
	if isdoorMat:
		interactPrompt.text = "Press E to go to previous room"
	if isFakeDoor :
		print("playing")
		fakeSound.play()
	
	

func _process(delta):
	

	if playerInArea and Input.is_action_just_pressed("interact"):
		if isFakeDoor:
			triggerFakeDoor()
		else:
			openDoor()

func openDoor():
	doorSound.play()
	animSprite.play("doorOpen")
	teleportToTarget()

func triggerFakeDoor():
	interactPrompt.visible = false
	if tentacleManager != null:
		var tm = get_node(tentacleManager)
		if tm.has_method("showMiniGame"):
			tm.showMiniGame()
			playerInArea = false
func _on_body_entered(body):
	if body.name == "Player":
		playerInArea = true
		player.playerLabel.text = "Press E"
		
func _on_body_exited(body):
	if body.name == "Player":
		playerInArea = false
		player.playerLabel.text = ""
func teleportToTarget():
	if tpTarget == null:
		return



	if animPlayer:
		animPlayer.play("transition")
		await get_tree().create_timer(0.2).timeout
		player.global_position = tpTarget.global_position
	else:
		player.global_position = tpTarget.global_positions

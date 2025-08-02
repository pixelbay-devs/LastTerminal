extends Area2D

@export var promptLabel: Label
@onready var rect: ColorRect = $ColorRect
var isPlayerInside: bool = false
@export var playerRef: CharacterBody2D = null

func _ready():

	promptLabel.visible = false

func _process(delta):
	if isPlayerInside:
		if Input.is_action_pressed("interact"):  
			playerRef.isHidden = true
			rect.visible = true
			$AudioStreamPlayer2D.play()
		else:
			playerRef.isHidden = false
			rect.visible = false

func _on_body_entered(body):
	print(body)
	print(playerRef)
	if body == playerRef:
		playerRef.playerLabel.text = "Hold E to hide"
		isPlayerInside = true
		promptLabel.visible = true

func _on_body_exited(body):
	if body.name == "Player":
		playerRef.playerLabel.text = ""
	if body == playerRef:
		isPlayerInside = false
		playerRef.isHidden = false
		promptLabel.visible = false

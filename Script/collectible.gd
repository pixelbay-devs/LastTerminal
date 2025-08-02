extends Area2D

signal collected
@export var coll: Sprite2D
@export var a: Sprite2D
@export var b: Sprite2D
@export var c: Sprite2D
@export var d: Sprite2D
@export var e: Sprite2D
@export var s: AudioStreamPlayer2D

@export var scaleAmplitude: float = 0.1 
@export var rotationAmplitude: float = 10.0 
@export var speed: float = 2.0 
var baseScale: Vector2
var time: float = 0.0
var playerIsNearby: bool = false
@export var player: CharacterBody2D

func _ready() -> void:
	await get_tree().process_frame
	baseScale = coll.scale
	print(baseScale)
func _process(delta: float) -> void:
	time += delta
	var scaleFactor = 0.2+sin(time * speed) * scaleAmplitude
	scale = baseScale * scaleFactor
	rotation = deg_to_rad(sin(time * speed) * rotationAmplitude)
	
	
	if playerIsNearby and Input.is_action_just_pressed("interact"):
		emit_signal("collected") 
		s.play()
		player.score+=1
		if self.name == "a":
			a.visible= true
		if self.name == "b":
			b.visible= true
		if self.name == "c":
			c.visible= true
		if self.name == "d":
			d.visible= true
		if self.name == "e":
			e.visible= true
		queue_free() 

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		playerIsNearby = true

func _on_body_exited(body: Node) -> void:
	if body.name == "Player":
		playerIsNearby = false

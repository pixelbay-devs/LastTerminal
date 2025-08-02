extends Node2D

@export var scrollSpeed: float = 100.0
func _ready() -> void:
	
	$AnimatedSprite2D.play("attack")

func _process(delta):
	position.y += scrollSpeed * delta




func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player2" && body.canDie:
		await $AnimatedSprite2D.animation_finished
		get_tree().change_scene_to_file("res://Scene/gameover2.tscn")

extends Node2D
@export var x: Node
@export var tnt: Node
@export var player: CharacterBody2D
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name =="Player":
		$AnimatedSprite2D.play("default")
		player.movementEnabled = false
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		tnt.showMiniGame()
		$AnimatedSprite2D.visible = false
		x.visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	queue_free()

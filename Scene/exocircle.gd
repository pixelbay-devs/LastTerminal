extends Area2D

@export var player: CharacterBody2D
@export var tnt: Node
var can:bool = true
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" && can:
		
		if player.score == 5:
			can = false
			$Sprite2D2.visible = true
			$Sprite2D3/Area2D.monitoring = true
			$Label.visible = false
			player.playerLabel.visible = false
			tnt._on_timer_timeout()
			if $thump:
				$thump.play()
				await $thump.finished
				$thump.queue_free()
		if player.score!=5:
			player.playerLabel.text = "Collect all shards"
			player.playerLabel.visible = true
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Scene/chase_scene.tscn")
	

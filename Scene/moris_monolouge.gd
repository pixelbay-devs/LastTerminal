extends Node2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		get_tree().change_scene_to_file("res://Scene/test_cutscene.tscn")

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scene/test_cutscene.tscn")

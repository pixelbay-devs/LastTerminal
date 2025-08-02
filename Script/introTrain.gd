extends Node2D
@export var ap: AnimationPlayer
@export var pp: PostProcess





func _on_h_timer_timeout() -> void:
	ap.play("heart")


func _on_e_timer_timeout() -> void:
	ap.play("exo")


func _on_l_timer_timeout() -> void:
	ap.play("locker")


func _on_r_timer_timeout() -> void:
	ap.play("reset")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		get_tree().change_scene_to_file("res://Scene/test_scene_2.tscn")

func _on_timer_2_timeout() -> void:
	get_tree().change_scene_to_file("res://Scene/test_scene_2.tscn")


extends Node2D


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/test_scene_2.tscn")


func _on_button_mouse_entered() -> void:
	$AudioStreamPlayer2D.play()

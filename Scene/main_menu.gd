extends Control


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/moris_monolouge_v_2.tscn")


func _on_button_mouse_entered() -> void:
	$hover.play()

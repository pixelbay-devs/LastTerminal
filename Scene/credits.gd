extends Control


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "new_animation":
		get_tree().change_scene_to_file("res://Scene/main_menu.tscn")

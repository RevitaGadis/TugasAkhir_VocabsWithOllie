extends Node2D

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/dialogue.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_load_game_pressed() -> void:
	pass

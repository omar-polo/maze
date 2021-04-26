extends Control

func _ready() -> void:
	yield(get_tree().create_timer(1), 'timeout')
	get_tree().change_scene("res://src/main/Game/Game.tscn")

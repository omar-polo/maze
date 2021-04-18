extends CenterContainer


func _on_play() -> void:
	var _t = get_tree().change_scene("res://src/main/Game.tscn")

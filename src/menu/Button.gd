extends CenterContainer

func _ready() -> void:
	$VBoxContainer/play.grab_focus()

func _on_play_pressed() -> void:
	var _t = get_tree().change_scene("res://src/main/Game.tscn")


func _on_quit_pressed() -> void:
	var _t = get_tree().quit()

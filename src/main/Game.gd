extends Node2D

const sprite_size = 64


func _ready() -> void:
	var width: int = $Maze.width
	var height: int = $Maze.height
	$Portal.position = Vector2(width - 1, height - 1) * sprite_size * 2
	$Portal.position += Vector2(sprite_size, sprite_size) / 2

	$Player.set_process(true)


func _on_Portal_entered(body) -> void:
	print("body is ", body)
	if body is KinematicBody2D:
		$Player.set_process(false)
		$Player.set_physics_process(false)
		yield(get_tree().create_timer(2), 'timeout')
		var _t = get_tree().change_scene("res://src/menu/Menu.tscn")

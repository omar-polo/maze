extends Node2D

const sprite_size = 64


func _ready() -> void:
	var width: int = $Maze.width
	var height: int = $Maze.height

	var player: Vector2
	var portal: Vector2

	while true:
		player = Vector2(int(randf() * width), int(randf() * height))
		portal = Vector2(int(randf() * width), int(randf() * height))

		if player.distance_to(portal) > float(width) / 2:
			break

	# each point occupies two places in the grid (per direction, so
	# actually four), hence the multiplication.  Then multiply to
	# sprite_size to get an actual position on the world.
	$Portal.position = portal * 2 * sprite_size

	# patch the portal position so it appears centered in the grid.
	$Portal.position += Vector2(sprite_size, sprite_size) / 2

	$Player.position = player * sprite_size * 2 + Vector2(32, 32)

	$Player.set_process(true)


func _on_Portal_entered(body) -> void:
	print("body is ", body)
	if body is KinematicBody2D:
		$Player.set_process(false)
		$Player.set_physics_process(false)
		yield(get_tree().create_timer(2), 'timeout')
		var _t = get_tree().change_scene("res://src/menu/Menu.tscn")

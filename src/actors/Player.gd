extends KinematicBody2D

var velocity := Vector2()
export (int) var speed := 350


func _physics_process(_delta: float) -> void:
	var dir := Vector2.ZERO
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	dir = dir.normalized()
	velocity = move_and_slide(dir * speed)

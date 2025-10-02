class_name Projectile
extends Node2D


@export var speed: float = 100.0
var _move_dir: Vector2 = Vector2.ZERO


func _process(delta: float) -> void:
	if not _move_dir:
		return

	global_position += delta * speed * _move_dir


func set_move_dir(dir: Vector2) -> void:
	_move_dir = dir


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_hitbox_component_hit(_node: Node2D) -> void:
	queue_free()

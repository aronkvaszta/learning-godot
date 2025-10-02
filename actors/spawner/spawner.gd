class_name Spawner
extends Node2D


@export var spawnable_enemies: Array[PackedScene] = []

@export var spawn_time: float = 2.0
@export var max_spawn_amount: int = 3
var _spawn_amount: int = 0
var _timer: float = 0.0

@export var spawn_distance: float = 100.0

var player: Player = null

func _ready() -> void:
	player = get_tree().get_first_node_in_group(&'player')


func _process(delta: float) -> void:
	_timer += delta
	if _timer >= spawn_time:
		_timer = 0
		spawn_enemies()


func spawn_enemies() -> void:
	_spawn_amount = randi_range(1, max_spawn_amount)

	for i in _spawn_amount:
		var new_enemy: Enemy = spawnable_enemies.pick_random().instantiate()
		var spawn_pos: Vector2 = player.global_position + Vector2(
			cos(randf_range(-PI, PI)),
			sin(randf_range(-PI, PI))
		).normalized() * spawn_distance

		new_enemy.global_position = spawn_pos
		get_tree().current_scene.add_child(new_enemy)

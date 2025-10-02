class_name Player
extends CharacterBody2D


@onready var sprite: Sprite2D = $Sprite2D


@export_group('Movement')
## Maximum speed the player can move at
@export var move_speed: float = 75.0
## The speed at which the player reaches their maximum movement speed.
@export_range(1.0, 20.0, 0.5) var acceleration: float = 16.0
## The speed at which the player stops when there's no input.
@export_range(1.0, 20.0, 0.5) var deceleration: float = 16.0
## Movement direction
var _input_dir: Vector2 = Vector2.ZERO

@export_group('Shooting')
@export var fire_rate: float = 1.0
@export var projectile_scene: PackedScene = null
var _fire_timer: float = 0.0
var _target: Enemy = null


func _process(delta: float) -> void:
	_gather_movement_input()
	_flip_sprite()

	_apply_friction(delta)

	_fire_timer += delta
	if _fire_timer >= fire_rate:
		_fire_timer = 0.0
		shoot()

	move_and_slide()


func _flip_sprite() -> void:
	if _input_dir.x < 0:
		sprite.flip_h = true
	elif _input_dir.x > 0:
		sprite.flip_h = false


## Applies friction to the player's velocity. Linearly interpolated.
func _apply_friction(dt: float) -> void:
	if _input_dir:
		velocity = lerp(velocity, _input_dir * move_speed, dt * acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, dt * deceleration)


## Sets [member _input_dir] to whatever the WASD inputs' values are. Normalized.
func _gather_movement_input() -> void:
	_input_dir = Vector2.ZERO

	if Input.is_action_pressed(&'left'):
		_input_dir.x -= 1
	if Input.is_action_pressed(&'right'):
		_input_dir.x += 1
	if Input.is_action_pressed(&'up'):
		_input_dir.y -= 1
	if Input.is_action_pressed(&'down'):
		_input_dir.y += 1

	_input_dir = _input_dir.normalized()



func shoot() -> void:
	if not _target:
		return

	var new_projectile: Projectile = projectile_scene.instantiate()
	new_projectile.global_position = global_position

	var direction_to_target: Vector2 = (_target.global_position - global_position).normalized()
	var rot: float = atan2(direction_to_target.y, direction_to_target.x) + PI * 0.5
	new_projectile.rotation = rot

	new_projectile.set_move_dir(direction_to_target)
	get_tree().current_scene.call_deferred(&'add_child', new_projectile)


func _on_detection_range_area_closest_enemy_changed(enemy: Enemy) -> void:
	_target = enemy

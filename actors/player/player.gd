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


func _process(delta: float) -> void:
	_gather_movement_input()
	_flip_sprite()

	_apply_friction(delta)

#	Enables the player to move
#	the speed at which it moves is determined by velocity
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
#	Resetting movement input to 0 every frame
	_input_dir = Vector2.ZERO

#	Getting input values for WASD movement
	if Input.is_action_pressed(&'left'):
		_input_dir.x -= 1
	if Input.is_action_pressed(&'right'):
		_input_dir.x += 1
	if Input.is_action_pressed(&'up'):
		_input_dir.y -= 1
	if Input.is_action_pressed(&'down'):
		_input_dir.y += 1

#	Normalizing the input, so the length is always 1 unit long or 0.
	_input_dir = _input_dir.normalized()

#	↓ This is the same as the thing above
	#_input_dir = Input.get_vector(&'left', &'right', &'up', &'down')

#	↓ So is this
	#_input_dir = Vector2(
		#Input.get_axis(&'left', &'right'),
		#Input.get_axis(&'up', &'down')
	#).normalized()

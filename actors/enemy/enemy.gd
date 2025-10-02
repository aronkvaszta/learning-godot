class_name Enemy
extends CharacterBody2D


@onready var enemy_name: Label = $EnemyName
@onready var sprite: Sprite2D = $Sprite2D
var player: Player = null


@export_group('Movement Settings')
@export var move_speed: float = 50.0
var _move_dir: Vector2 = Vector2.ZERO


func _ready() -> void:
	_find_player()
	enemy_name.text = name


func _process(_delta: float) -> void:
#	Find the direction towards the player
	_move_dir = (player.global_position - global_position).normalized()
	_flip_sprite()

#	↓ This does the exact same thing as above
#	I just like not calling functions for no reason, as they add some processing time overhead.
#	That time is miniscule, but if there were a 1_000 enemies, or even 10_000 somehow, it'd add up quickly.
	#_move_dir = global_position.direction_to(player.global_position)

	velocity = _move_dir * move_speed
	move_and_slide()

##	Flips the enemy's sprite based on the [member player]'s x position.
func _flip_sprite() -> void:
#	Makes it look like the enemy is always facing towards the player.
	sprite.flip_h = player.global_position.x < global_position.x


## Tries to find the player character. If it fails, this object is freed.
func _find_player(max_tries: int = 10) -> void:
	var tries: int = 0

	while not player and tries < max_tries:
		player = get_tree().get_first_node_in_group(&'player')
		tries += 1
	if not player:
		queue_free()

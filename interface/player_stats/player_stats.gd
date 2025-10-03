class_name PlayerStats
extends Control


@onready var player_health_bar: ProgressBar = $MarginContainer/PlayerHealthBar


var player: Player = null


func _ready() -> void:
	player = get_tree().get_first_node_in_group(&'player')
	player.health_component.health_changed.connect(_on_health_changed)


func _on_health_changed(max_health: float, current_health: float) -> void:
	player_health_bar.value = (current_health / max_health)

class_name HealthComponent
extends Node


@export var max_health: float = 10.0
var _current_health: float = 0.0 :
	set(value):
		var previous: float = _current_health
		_current_health = value
		if _current_health != previous:
			health_changed.emit(max_health, _current_health)


signal health_changed(max: float, current: float)
signal died()


func _ready() -> void:
	_current_health = max_health


func take_damage(amount: float) -> void:
	_current_health -= amount

	if _current_health <= 0:
		_current_health = 0
		died.emit()

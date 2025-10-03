class_name HitboxComponent
extends Area2D


@export var damage: float = 1.0


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


signal hit(node: Node2D)


func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		area.damage_dealer = self
		area.try_take_damage()
		hit.emit(area)


func _on_area_exited(area: Area2D) -> void:
	if area is HurtboxComponent:
		area.damage_dealer = null

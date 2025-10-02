class_name HitboxComponent
extends Area2D


@export var damage: float = 1.0


signal hit(node: Node2D)


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:
	if area is HurtboxComponent:
		area.health_component.take_damage(damage)
		hit.emit(area)

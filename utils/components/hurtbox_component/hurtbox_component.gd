class_name HurtboxComponent
extends Area2D


@export var health_component: HealthComponent = null
var damage_dealer: HitboxComponent = null


@export_group('Coninuous Damage')
@export var allow_continuous_damage: bool = false
@export var damage_cooldown: float = 0.0
var cooldown: float = 0.0


func _process(delta: float) -> void:
	if not allow_continuous_damage:
		return

	cooldown += delta
	if cooldown >= damage_cooldown:
		try_take_damage()
		cooldown = 0.0


func try_take_damage() -> void:
	if not damage_dealer:
		return
	health_component.take_damage(damage_dealer.damage)


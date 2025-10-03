extends Node2D


const WHITE_HIT = preload('uid://bduqsdc35gnfj')

signal hit_effect_applied(sprite: Sprite2D)
signal hit_effect_removed(sprite: Sprite2D)


func apply_hit_effect(sprite: Sprite2D, duration: float = 0.2) -> void:
	await get_tree().process_frame

	if not sprite:
		return

	var shader_mat: ShaderMaterial = ShaderMaterial.new()
	shader_mat.shader = WHITE_HIT
	sprite.material = shader_mat

	hit_effect_applied.emit(sprite)
	get_tree().create_timer(duration).timeout.connect(remove_hit_effect.bind(sprite))


func remove_hit_effect(sprite: Sprite2D) -> void:
	sprite.material = null
	hit_effect_removed.emit(sprite)

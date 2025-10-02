class_name DetectionRangeArea
extends Area2D


var enemies_in_range: Array[Enemy] = []
var closest_enemy: Enemy = null :
	set(value):
		closest_enemy = value
		closest_enemy_changed.emit(closest_enemy)


signal closest_enemy_changed(enemy: Enemy)


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _process(_delta: float) -> void:
	if enemies_in_range.size() == 0:
		closest_enemy = null
		return
	elif enemies_in_range.size() == 1:
		closest_enemy = enemies_in_range[0]
		return
	else:
		enemies_in_range.sort_custom(_sort_enemy_distance)
		closest_enemy = enemies_in_range[0]


func _on_body_entered(body: Node2D) -> void:
	if not body is Enemy:
		return
	if enemies_in_range.has(body):
		return

	enemies_in_range.append(body)


func _on_body_exited(body: Node2D) -> void:
	if not body is Enemy:
		return

	enemies_in_range.erase(body)


func _sort_enemy_distance(a: Enemy, b: Enemy) -> bool:
	var a_dist: float = (a.global_position - global_position).length_squared()
	var b_dist: float = (b.global_position - global_position).length_squared()
	return a_dist < b_dist


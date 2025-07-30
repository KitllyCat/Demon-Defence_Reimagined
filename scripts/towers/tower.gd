extends StaticBody2D

@export var bullet_scene : PackedScene

var current_target
var total_targets := []
var can_shoot : bool = true
func _process(delta):
	if total_targets.size() > 0:
		for t in total_targets:
			if current_target != null:
				if current_target.get_parent().progress_ratio < t.get_parent().progress_ratio:
					current_target = t 
			else:
				current_target = t 
		if can_shoot:
			can_shoot = false
			shoot()
			$TimerCD.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		if !total_targets.has(body):
			total_targets.append(body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		if !total_targets.has(body):
			total_targets.erase(body)

func shoot():
	if bullet_scene and current_target and is_instance_valid(current_target):
		var bullet = bullet_scene.instantiate()
		add_child(bullet)
		bullet.set_target_position(current_target.global_position)
		bullet.global_position = $Marker2D.global_position

func _on_timer_cd_timeout() -> void:
	can_shoot = true

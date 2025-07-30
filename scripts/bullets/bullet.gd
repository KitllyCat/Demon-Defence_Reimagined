extends Area2D
const speed := 1000

var direccion : Vector2

func set_target_position(new_target_pos: Vector2):
	look_at(new_target_pos)
	direccion = (new_target_pos - global_position).normalized()
	
func _physics_process(delta):
	position += direccion * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.take_damage(50.0)
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()
	

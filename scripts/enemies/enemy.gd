extends CharacterBody2D

const speed:=60
var health := 500.0

@onready var enemy_path : PathFollow2D = get_parent()

func _physics_process(delta):
	enemy_path.progress = enemy_path.progress + (speed * delta)
	
	if enemy_path.progress_ratio >= 0.99:
		get_parent().queue_free()

func take_damage(damage : float =1.0):
	health -= damage
	if health <= 0:
		get_parent().queue_free()

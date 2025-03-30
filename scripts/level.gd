extends Node2D

@onready var start_position = $StartPosition

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _on_death_zone_body_entered(body):
	body.velocity = Vector2.ZERO
	body.global_position = start_position.global_position

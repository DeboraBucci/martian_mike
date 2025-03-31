extends Node2D

@onready var start_area = $StartArea
var player = null


func _ready():
	player = get_tree().get_first_node_in_group("player")
	
	if player != null:
		player.global_position = start_area.get_spawn_pos()
		
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.touched_player.connect(_on_trap_touched_player)

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func _on_death_zone_body_entered(body):
	reset_player_position()


func _on_trap_touched_player():
	reset_player_position()


func reset_player_position():
	player.velocity = Vector2.ZERO
	player.global_position = start_area.get_spawn_pos()

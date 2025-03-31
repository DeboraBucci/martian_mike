extends Node2D

@export var next_level: PackedScene = null

@onready var start_area = $StartArea
@onready var exit_area = $ExitArea
@onready var death_zone = $DeathZone

var player = null


func _ready():
	player = get_tree().get_first_node_in_group("player")
	
	if player != null:
		player.global_position = start_area.get_spawn_pos()
		
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.touched_player.connect(_on_trap_touched_player)
	
	exit_area.body_entered.connect(_on_exit_body_entered)
	death_zone.body_entered.connect(_on_death_zone_body_entered)

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


func _on_exit_body_entered(body):
	if body is Player && next_level != null:
		exit_area.animate()
		player.player_can_move = false
		
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_packed(next_level)

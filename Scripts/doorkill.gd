extends Area2D

@onready var timer: Timer = $Timer
@onready var death_text: Label

func _ready():
	await get_tree().process_frame
	death_text = get_tree().current_scene.get_node("CanvasLayer2/DeathText")
	print("Timer: ", $Timer)

func _input(event):
	if event.is_action_pressed("Interact"):
		var player = get_player()
		if player:
			show_death_text()
			timer.start()

func get_player():
	for body in get_overlapping_bodies():
		if body.name == "Player":
			return body
	return null

func show_death_text():
	death_text.visible = true
	var screen_size = get_viewport().get_visible_rect().size
	death_text.position = (screen_size - death_text.size) / 2
	Engine.time_scale = 0.7
	
	var player = get_player()
	if player:
		var collider = player.get_node_or_null("CollisionShape2D")
		if collider:
			collider.queue_free()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	GameState.reset()
	Global.score = 0
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

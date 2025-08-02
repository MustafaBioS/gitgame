extends Area2D

@onready var timer: Timer = $Timer
@onready var death_text: Label


func _ready() -> void:
	await get_tree().process_frame
	death_text = get_tree().current_scene.get_node("CanvasLayer2/DeathText") 
	print("DeathText found:", death_text)

func _on_body_entered(body: Node2D) -> void:
	if death_text:
		death_text.visible = true
		var screen_size = get_viewport_rect().size
		death_text.position = (screen_size - death_text.size) / 2
	Engine.time_scale = 0.7
	body.get_node("CollisionShape2D").queue_free()	
	timer.start()
	

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	GameState.reset()
	get_tree().reload_current_scene()

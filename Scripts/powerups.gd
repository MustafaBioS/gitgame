extends Area2D

@export var jump_boost_amount: float = -600.0
@export var boost_duration: float = 60.0

@onready var timer: Timer = $Timer

var player: CharacterBody2D = null

func _ready():
	if GameState.potion_collected:
		queue_free()
		return
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node2D):

	GameState.potion_collected = true
	GameState.boost_time_remaining = boost_duration
	GameState.is_boost_active = true

	player = body
	player.JUMP_VELOCITY = jump_boost_amount

	$CollisionShape2D.disabled = true
	set_deferred("monitoring", false)
	visible = false
	timer.start()
	print("Boost started.")

func _on_timer_timeout():
	if player:
		player.reset_JUMP_VELOCITY()
	queue_free()

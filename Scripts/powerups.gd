extends Area2D

@export var jump_boost_amount: float = -500.0
@export var boost_duration: float = 8
@onready var timer: Timer = $Timer
var player: Node = null

var default_jump_velocity := -300.0

func _ready():
	if GameState.potion_collected:
		queue_free()
		return
	connect("body_entered", Callable(self, "_on_body_entered"))
	$Timer.connect("timeout", Callable(self, "_on_timer_timeout"))

func _on_body_entered(body: Node2D):
	GameState.potion_collected = true
	GameState.boost_time_remaining = boost_duration
	GameState.is_boost_active = true

	player = body
	
	print("Before:", player.JUMP_VELOCITY)
	player.JUMP_VELOCITY = jump_boost_amount
	print("After:", player.JUMP_VELOCITY)
	
	$CollisionShape2D.disabled = true
	set_deferred("monitoring", false)
	visible = false
	timer.start(boost_duration)
	print("Boost started.")

func _on_timer_timeout():
	if player:
		print("Boost started for", boost_duration, "seconds.")
		player.reset_JUMP_VELOCITY()
		print("Boost ended.")
	queue_free()

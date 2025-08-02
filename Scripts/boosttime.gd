extends CanvasLayer

@onready var boost_time: Label = $BoostTime

func _ready():
	await get_tree().process_frame
	var screen_size = get_viewport().get_visible_rect().size
	boost_time.position = Vector2(screen_size.x * 0.65, screen_size.y * 0.07)
	boost_time.visible = false

func _process(delta):
	if GameState.is_boost_active:
		GameState.boost_time_remaining -= delta
		if GameState.boost_time_remaining <= 0:
			GameState.boost_time_remaining = 0
			GameState.is_boost_active = false
			boost_time.visible = false
		else:
			boost_time.visible = true
			boost_time.text = "Jump Boost: %.1fs" % GameState.boost_time_remaining
	else:
		boost_time.visible = false

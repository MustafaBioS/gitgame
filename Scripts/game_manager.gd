extends Node

var score_text: Label = null

func _ready():
	await get_tree().process_frame
	await update_score_label_when_available()
	update_score_display()

func update_score_label():
	var possible_paths = [
		"/root/Game/CanvasLayer2/ScoreText",
		"/root/Level Two/CanvasLayer2/ScoreText"
	]
	for path in possible_paths:
		if has_node(path):
			score_text = get_node(path)
			break

func update_score_label_when_available():
	for i in range(30):
		update_score_label()
		if score_text != null and is_instance_valid(score_text):
			break
		await get_tree().process_frame

func update_score_display():
	if score_text:
		score_text.text = "Score: %d" % Global.score
		var screen_size = get_viewport().get_visible_rect().size
		score_text.position = Vector2(screen_size.x * 0.03, screen_size.y * 0.05)
		score_text.visible = true

func add_point():
	Global.score += 1
	update_score_display()

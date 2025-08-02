extends Node

@onready var score_text: Label = $"/root/Game/CanvasLayer/ScoreText"
var score = 0

func _ready():
	await get_tree().process_frame
	score_text.text = "Score: 0"
	var screen_size = get_tree().root.get_viewport().get_visible_rect().size
	score_text.position = Vector2(screen_size.x * 0.03, screen_size.y * 0.05)
	score_text.visible = true
	
func add_point():
	score +=1
	score_text.text = "Score: %d" % score
	var screen_size = get_tree().root.get_viewport().get_visible_rect().size
	score_text.position = Vector2(screen_size.x * 0.03, screen_size.y * 0.05)
	score_text.visible = true

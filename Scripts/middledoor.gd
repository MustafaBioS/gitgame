extends Area2D

@onready var end_label: Label = $CanvasLayer3/EndLabel

var player_in_range = false
var game_ended = false

func _ready():
	end_label.visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS  
	end_label.process_mode = Node.PROCESS_MODE_ALWAYS

func _on_body_entered(body):
	if body.name == "Player":
		player_in_range = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_range = false

func _unhandled_input(event):
	if player_in_range and not game_ended and event.is_action_pressed("Interact"):
		print("Showing label!")

		end_label.text = """The End...
Press Enter To Play Again!"""
		end_label.visible = true
		
		# Center it on the screen
		var screen_size = get_viewport().size
		end_label.position = Vector2(get_viewport().size) / 2 - end_label.size / 2

		game_ended = true
		get_tree().paused = true

	elif game_ended and event.is_action_pressed("ui_accept"):
		get_tree().paused = false
		GameState.reset()
		Global.score = 0
		get_tree().change_scene_to_file("res://Scenes/game.tscn")

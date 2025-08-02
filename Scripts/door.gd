extends Area2D

@export var target_scene: PackedScene

func _ready():
	pass


func _input(event):
	if event.is_action_pressed("Interact"):
		if !target_scene:
			print("No Scene Available")
			return
		if get_overlapping_bodies().size() > 0:
			next_level()
			
func next_level():
	var err = get_tree().change_scene_to_packed(target_scene)
	
	if err != OK:
		print("An Error Has Occured")

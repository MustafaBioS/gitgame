extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return
	
	var parent = get_parent()
	
	if parent.has_node("AnimationPlayer"):
		parent.get_node("AnimationPlayer").play("drop")
	
	var platform_anim = get_node_or_null("../../Platform3/AnimationPlayer")
	if platform_anim:
		platform_anim.play("save")
	
	await get_tree().create_timer(2).timeout
	
	parent.queue_free()

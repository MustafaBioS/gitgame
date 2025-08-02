extends Node
var potion_collected: bool = false
var boost_time_remaining := 0.0 
var is_boost_active := false


func reset():
	potion_collected = false
	boost_time_remaining = 0.0
	is_boost_active = false

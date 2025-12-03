extends AnimationTree
class_name PlayerAnimationController

func update_player_movement_state(is_moving: bool) -> void:
	var blend_position = 0
	if is_moving:
		blend_position = 1
	
	self["parameters/IdleWalk/blend_position"] = blend_position

func update_player_direction(direction: Vector2):
	self["parameters/IdleWalk/0/blend_position"] = direction
	self["parameters/IdleWalk/1/blend_position"] = direction

func change_to_holding_plate():
	return
	
func change_to_normal():
	return
	
func change_to_interacting_object():
	return

func change_to_looking_phone():
	return

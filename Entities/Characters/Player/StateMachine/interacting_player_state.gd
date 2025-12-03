extends PlayerState
class_name InteractingPlayerState

var _interaction_target: Node

func set_interaction_target(target: Node):
	_interaction_target = target

func enter_state():
	_player.velocity = Vector2.ZERO
	_player.animation_controller.update_player_movement_state(false)
	_player.move_and_slide()
	
	if _interaction_target is InteractableArea:
		_interaction_target.connect("on_interaction_end", on_interaction_end)

func handle_state():
	pass

func exit_state():
	pass
	
func on_interaction_end(target: Node):
	if _interaction_target is InteractableArea:
		target.disconnect("on_interaction_end", on_interaction_end)
	
	_interaction_target = null
	_player.change_state(Player.PlayerStateEnum.IDLE)

extends PlayerState

func enter_state():
	_player.animation_controller.update_player_movement_state(false)

func handle_state():
	var input_vector := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_vector != Vector2.ZERO:
		_player.change_state(Player.PlayerStateEnum.WALKING)

func exit_state():
	pass

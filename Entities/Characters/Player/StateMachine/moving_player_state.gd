extends PlayerState

func enter_state():
	_player.animation_controller.update_player_movement_state(true)

func handle_state():
	var input_vector := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_vector == Vector2.ZERO:
		var player_velocity = _player.velocity
		_player.velocity.x = move_toward(player_velocity.x, 0, _player.SPEED)
		_player.velocity.y = move_toward(player_velocity.y, 0, _player.SPEED)
	else:
		_player.animation_controller.update_player_direction(_player.get_current_direction() * Vector2(1,-1))
		_player.velocity = input_vector * _player.SPEED
	
	if _player.velocity == Vector2.ZERO:
		_player.change_state(Player.PlayerStateEnum.IDLE)

func exit_state():
	pass

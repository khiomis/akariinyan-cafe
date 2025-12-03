extends AspectRatioContainer
class_name PauseMenu

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("game_menu"):
		if visible:
			_close_menu()
			get_viewport().set_input_as_handled()
		else:
			_open_menu()
			get_viewport().set_input_as_handled()
	elif event.is_action_pressed("game_cancel"):
		if !get_tree().paused || !visible: return
		_close_menu()
		get_viewport().set_input_as_handled()

func _open_menu():
	if get_tree().paused || visible: return
	
	get_tree().paused = true
	visible = true

func _close_menu():
	if !get_tree().paused || !visible: return
	
	get_tree().paused = false
	visible = false

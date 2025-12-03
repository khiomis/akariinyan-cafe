extends Control
class_name MachineMenu

var _machine: Machine

func open_machine_menu(machine: Machine):
	if _machine != null or visible: return
	
	_machine = machine
	visible = true

func _input(event: InputEvent) -> void:
	if !event.is_action_pressed("game_cancel"): return
	if _machine == null or !visible: return
	
	_machine.on_menu_closed()
	visible = false
	_machine = null
	get_viewport().set_input_as_handled()

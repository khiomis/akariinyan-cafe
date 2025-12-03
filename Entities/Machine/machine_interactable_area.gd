extends InteractableArea

@onready var _machine: Machine = get_parent()

func set_focus(focused: bool):
	pass

func interact(actor: InteractionActor) -> bool:
	var interacting = super.interact(actor)
	
	if !interacting:
		return false
	
	get_tree().call_group("machine_menu", "open_machine_menu", _machine)
	return true

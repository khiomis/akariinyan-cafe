extends StaticBody2D
class_name Machine

@onready var _interactable_area: InteractableArea = $InteractableArea

func process_item(item):
	pass

func on_menu_closed():
	_interactable_area.end_interaction()

extends Area2D
class_name InteractableArea

var _actor_currently_interacting: InteractionActor

func set_focus(focused: bool):
	pass

func interact(actor: InteractionActor) -> bool:
	if _actor_currently_interacting != null: return false
	_start_interaction(actor)
	return true

func _start_interaction(actor: InteractionActor):
	_actor_currently_interacting = actor
	

func end_interaction() -> bool:
	if _actor_currently_interacting == null: return false
	_actor_currently_interacting = null
	emit_signal("on_interaction_end", self)
	return true


func _on_area_entered(area: Area2D) -> void:
	if area is InteractionActor:
		area.register_area(self)


func _on_area_exited(area: Area2D) -> void:
	if area is InteractionActor:
		area.unregister_area(self)

signal on_interaction_end(interactable_area: InteractableArea)

extends Area2D
class_name InteractionActor

@export var can_focus:= false

var _active_areas: Array[InteractableArea] = []
var _current_area: InteractableArea
var _can_interact:bool = false

func set_can_interact(can_interact):
	_can_interact = can_interact
	_change_current_area(_current_area)

func register_area(area: InteractableArea):
	if _active_areas.find(area) >= 0: return
	_active_areas.push_back(area)
	_on_area_list_changed()

func unregister_area(area: InteractableArea):
	var index = _active_areas.find(area)
	
	if index < 0: return
	
	_active_areas.remove_at(index)
	_on_area_list_changed()
	
func try_to_interact() -> InteractableArea:
	if _current_area == null:
		print("Nothing in range to interact with")
		return null
		
	_current_area.interact(self)
	return _current_area

func _on_area_list_changed():
	_active_areas.sort_custom(_sort_by_distance_to_player)
	
	if _active_areas.size() == 0:
		_change_current_area(null)
	else:
		var nearest_interaction_area = _active_areas[0]
		if nearest_interaction_area != _current_area:
			_change_current_area(nearest_interaction_area)
		

func _change_current_area(area: InteractableArea):
	if _current_area != null:
		_current_area.set_focus(false)
	
	_current_area = area
	emit_signal("on_interactable_area_changed", _current_area)
	
	if _current_area != null and can_focus and _can_interact:
		_current_area.set_focus(true)

func _sort_by_distance_to_player(area1, area2) -> bool:
	var area1_to_actor = global_position.distance_to(area1.global_position)
	var area2_to_actor = global_position.distance_to(area2.global_position)
	
	return area1_to_actor < area2_to_actor

signal on_interactable_area_changed(area: InteractableArea)

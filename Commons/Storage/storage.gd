extends Node
class_name Storage

var _items: Dictionary[Node, int] = {}

func store(data: Node, quantity: int):
	assert(quantity > 0, "quantity must be greater than zero")
	
	return _operate_storage(data, quantity)

func retrive(data: Node, quantity: int):
	assert(quantity > 0, "quantity must be greater than zero")
	
	return _operate_storage(data, quantity * -1)

func _operate_storage(data: Node, quantity: int):
	assert(_check_data_can_store(data) or data.get_children(true).filter(_check_data_can_store).size() > 0, "the object isn't a storable element")
	
	var currentQuantity = _items[data]
	if currentQuantity == null:
		currentQuantity = 0
	
	assert(quantity > 0 or quantity * -1 < currentQuantity, "invality quantity informed for the operation")
	
	_items[data] = currentQuantity + quantity

func get_quantity_available(data: Node) -> int:
	assert(_check_data_can_store(data) or data.get_children(true).filter(_check_data_can_store).size() > 0, "the object isn't a storable element")
	
	var currentQuantity = _items[data]
	if currentQuantity == null:
		return 0
	return currentQuantity

func _check_data_can_store(data: Node) -> bool:
	return data is StorableElement

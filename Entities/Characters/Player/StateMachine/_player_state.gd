@abstract
extends Node
class_name PlayerState

var _player: Player
@export var animation: String
@export var type: Player.PlayerStateEnum

func initialize_state(player: Player):
	_player = player

@abstract func enter_state()
@abstract func handle_state()
@abstract func exit_state()

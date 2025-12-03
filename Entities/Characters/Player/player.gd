extends CharacterBody2D
class_name Player

enum PlayerStateEnum {IDLE, WALKING, INTERACTING};
@export var SPEED := 100.0

@export var _idle_state: PlayerState
@export var _moving_state: PlayerState
@export var _interacting_state: PlayerState

@onready var interaction_actor: InteractionActor = $InteractionActorArea
@onready var animation_controller: PlayerAnimationController = $AnimationTree

var _current_state: PlayerState
var _current_direction: Vector2

func _ready() -> void:
	_current_state = _idle_state
	
	var machine = $StateMachine
	var states = machine.get_children().filter(func (child): return child is PlayerState)
	for state in states:
		state.initialize_state(self)

func _physics_process(_delta: float) -> void:
	assert(_current_state != null)
	
	_update_direction();
	_current_state.handle_state()
	move_and_slide()

func _update_direction():
	if _current_state is InteractingPlayerState: return
	var input_vector := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_vector == Vector2.ZERO: return
	
	_current_direction = input_vector
	animation_controller.update_player_direction(input_vector * Vector2(1,-1))
	animation_controller.update_player_movement_state(input_vector.x != 0 or input_vector.y != 0)

func _unhandled_key_input(event: InputEvent) -> void:
	if _current_state is InteractingPlayerState: return

	if event.is_action_pressed("game_accept"):
		get_viewport().set_input_as_handled()
		var target = interaction_actor.try_to_interact()
		if target != null:
			_start_interaction(target)

func _start_interaction(target: Node):
	_interacting_state.set_interaction_target(target)
	change_state(PlayerStateEnum.INTERACTING)

func change_state(state: PlayerStateEnum):
	_current_state.exit_state()
	if state == PlayerStateEnum.IDLE:
		_current_state = _idle_state
	elif state == PlayerStateEnum.WALKING:
		_current_state = _moving_state
	elif state == PlayerStateEnum.INTERACTING:
		_current_state = _interacting_state
	else:
		_current_state = null
	assert(_current_state != null)
	_current_state.enter_state()

func change_animation(animation: String):
	pass

func get_current_direction() -> Vector2: return _current_direction

extends Resource
class_name InputBindingData

enum INPUTS {
	MOVE_RIGHT,
	MOVE_LEFT,
	MOVE_DOWN,
	MOVE_UP,
	DASH,
	INTERACT,
	TOGGLE_INVENTORY,
	ATTACK,
	ATTACK_ALTERNATE,
	TOGGLE_TOOLTIPS
}

@export var input_movement_map : Dictionary = {
	INPUTS.MOVE_RIGHT: "move_right_p1",
	INPUTS.MOVE_LEFT: "move_left_p1",
	INPUTS.MOVE_DOWN: "move_down_p1",
	INPUTS.MOVE_UP: "move_up_p1",
	INPUTS.DASH: "dash_p1",
	INPUTS.INTERACT: "interact_p1",
	INPUTS.TOGGLE_INVENTORY: "toggle_inventory_p1",
	INPUTS.ATTACK: "attack_p1",
	INPUTS.ATTACK_ALTERNATE: "attack_alternate_p1",
	INPUTS.TOGGLE_TOOLTIPS: "toggle_tooltips"
}

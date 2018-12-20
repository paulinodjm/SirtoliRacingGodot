extends RigidBody2D

export var accel_speed = 90.0
export var rotation_speed = 45.0

func _ready():
	pass

func _physics_process(delta):
	var torque = get_rotation_speed() * get_turn_input()
	set_angular_velocity(torque)
	
	var accel = accel_speed * get_move_input()
	apply_impulse(Vector2(0,0), get_transform().y * accel)

func get_rotation_speed():
	return deg2rad(rotation_speed)

func get_turn_input():
	var input = 0
	if Input.is_action_pressed("game_left"):
		input -= 1
	if Input.is_action_pressed("game_right"):
		input += 1
	return input

func get_move_input():
	var input = 0
	if Input.is_action_pressed("game_accel"):
		input += 1
	if Input.is_action_pressed("game_brake"):
		input -= 1
	return input

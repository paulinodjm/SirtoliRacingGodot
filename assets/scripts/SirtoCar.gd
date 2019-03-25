extends RigidBody2D

export var accel_speed = 90.0
export var rotation_speed = 45.0

const DRAW_AXIS_SCALE = 100
const DRAW_VELOCITY_COLOR = Color.orange
const DRAW_FORWARD_COLOR = Color.blue
const DRAW_STRAFE_COLOR = Color.red
const DRAW_AXIS_WEIGHT = 1
const DRAW_FORCE_WEIGHT = 3

func _ready():
	pass

func _physics_process(delta):
	var torque = get_rotation_speed() * get_turn_input()
	set_angular_velocity(torque)
	
	var accel = accel_speed * get_move_input()
	apply_central_impulse(get_transform().y * accel)
	
	var lateral_friction = -linear_velocity.project(transform.x)
	apply_central_impulse(lateral_friction)
	
func _process(delta):
	update() # @DEBUG: triggers the canvas _draw function

#func _draw():
#	# Draws the local vectors
#
#	# Draws the global vectors
#	draw_set_transform(Vector2.ZERO, -rotation, Vector2.ONE)
#
#	var move_forward = linear_velocity.project(transform.y)
#	var move_strafe = linear_velocity.project(transform.x)
#
#	draw_line(Vector2.ZERO, linear_velocity, DRAW_VELOCITY_COLOR, DRAW_FORCE_WEIGHT)
#	draw_line(Vector2.ZERO, transform.y * DRAW_AXIS_SCALE, DRAW_FORWARD_COLOR, DRAW_AXIS_WEIGHT)
#	draw_line(Vector2.ZERO, transform.x * DRAW_AXIS_SCALE, DRAW_STRAFE_COLOR, DRAW_AXIS_WEIGHT)
#	draw_line(Vector2.ZERO, move_forward, DRAW_FORWARD_COLOR, DRAW_FORCE_WEIGHT)
#	draw_line(Vector2.ZERO, move_strafe, DRAW_STRAFE_COLOR, DRAW_FORCE_WEIGHT)	
#	pass

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

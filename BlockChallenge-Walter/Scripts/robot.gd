extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
# var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped = false;



# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("idle")



func _physics_process(delta):
	
	$AnimationPlayer.play("idle")
	
	if Input.is_action_pressed("ui_right"):
		$Sprite2D.flip_h=false
	
	if Input.is_action_pressed("ui_left"):
		$Sprite2D.flip_h=true
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if is_on_floor():
		has_double_jumped = false
	if Input.is_action_just_pressed("ui_up") and not is_on_floor() and not has_double_jumped:
		has_double_jumped = true
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
# Move and detect collision
	move_and_slide()

func die():
	# Por ejemplo, podrías reiniciar la escena
	get_tree().reload_current_scene()

extends CharacterBody2D
var player
var SPEED = 50
var chase = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	get_node("AnimatedSprite2D").play("Idle")
func _physics_process(delta):
	velocity.y += gravity *delta
	if get_node("AnimatedSprite2D").animation == "Death":
		return
	if chase == true:
		
		get_node("AnimatedSprite2D").play("Jump")
		player = get_node("../../Player/Player")
		
		var direction = (player.position - self.position).normalized()
		
		
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
		else:
			get_node("AnimatedSprite2D").flip_h = false
		velocity.x = direction.x * SPEED
	else:
		
			get_node("AnimatedSprite2D").play("Idle")
			velocity.x = 0
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name== "Player":
		chase = true
		
func _on_player_detection_body_exited(body):
	if body.name== "Player":
		chase = false


func _on_player_death_body_entered(body):
	if body.name== "Player":
		body.velocity.y = -300
		death()


func _on_player_collision_body_entered(body):
	if body.name== "Player":
		if body.health >0:
			body.health -= 1
			death()
		else:
			return
		
func death():
	chase = false
	get_node("AnimatedSprite2D").play("Death")
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()

extends CharacterBody2D

@onready var anim = get_node("AnimatedSprite2D")
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_player_collect_body_entered(body):
	if body.name == "Player":
		
		get_tree().change_scene_to_file("res://victory.tscn")

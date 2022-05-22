extends Node

export(PackedScene) var mob_scene
var score

func _ready():
	randomize()

func game_over():
	$MobTimer.stop()
	$ScoreTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get ready")
	get_tree().call_group("mobs", "queue_free")
	$Music.play()

func _on_MobTimer_timeout():
	var mob = mob_scene.instance()
	
	# get random position on path
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()
	mob.position = mob_spawn_location.position
	
	# get a perpendicular direction
	# + add some randomness
	var direction = mob_spawn_location.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# get a random velocity
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# spawn the child by adding it to the scene
	add_child(mob)

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

extends CanvasLayer

signal start_game

var title = "Dodge the Creeps!"

func _ready():
	$Message.text = title

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game over!")
	
	# wait until the end of the message timer
	yield($MessageTimer, "timeout")
	
	$Message.text = title
	$Message.show()
	
	# make a one-shot timer and wait for it
	# to finish
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_MessageTimer_timeout():
	$Message.hide()

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

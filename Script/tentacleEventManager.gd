extends Node

@export var playerRef: CharacterBody2D 
@onready var struggleMinigame = $"../strangleMiniGame"
var once:int = 0
@onready var timer: Timer = $Timer

func _ready():
	timer.wait_time = randf_range(60.0, 70.0)
	timer.start()

	struggleMinigame.miniGameSuccess.connect(on_mini_game_success)
	struggleMinigame.miniGameFail.connect(on_mini_game_fail)

func _on_timer_timeout() -> void:
	timer.wait_time = randf_range(60.0, 70.0)
	timer.start()
	if once==0:
		$"../HIDE".play()
		once+=1
	print("Tentacle triggered!")
	playerRef.cam.shakeCamera(5.0, 5.0)
	$rumble.play()
	await get_tree().create_timer(4.0).timeout
	$CanvasLayer/AnimatedSprite2D.visible = true
	$tentaclesound.play()
	$CanvasLayer/AnimatedSprite2D.play("default")

	playerRef.movementEnabled = false
	await get_tree().create_timer(2.0).timeout
	
	if playerRef.has_method("isPlayerHidden") and playerRef.isPlayerHidden():
		playerRef.movementEnabled = true
		print("Player is hiding. Tentacle event skipped.")
		$CanvasLayer/AnimatedSprite2D.visible = false
		playerRef.cam.stopShake()
		await get_tree().create_timer(2.0).timeout
		
	else:
		print("Player is NOT hiding. Starting strangle mini-game.")
		showMiniGame()

func showMiniGame():
	if $CanvasLayer/AnimatedSprite2D.visible == false:
		$CanvasLayer/AnimatedSprite2D.visible = true
		$tentaclesound.play()
		$CanvasLayer/AnimatedSprite2D.play("default")
		await $CanvasLayer/AnimatedSprite2D.animation_finished
	struggleMinigame.start_minigame()

func on_mini_game_success():

	print("Mini-game success. Resuming game.")
	get_tree().paused = false
	playerRef.movementEnabled = true
	$CanvasLayer/AnimatedSprite2D.visible = false
	timer.wait_time = randf_range(30.0, 40.0)
	timer.start()

	if playerRef.has_method("enableMovement"):
		playerRef.enableMovement(true)

func _process(delta: float) -> void:
	print(timer.wait_time)
	if struggleMinigame.isGameActive:
		print("ee")
		timer.wait_time = randf_range(60.0, 70.0)
func on_mini_game_fail():
	print("Mini-game fail. Going to Game Over scene.")

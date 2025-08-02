extends Node2D
@export var tentacleScene: PackedScene
@export var tentacleSpawnInterval: float = 3.0
@export var floorScrollSpeed: float = 100.0
@export var player: CharacterBody2D
var canSummon:bool = true
var can:bool = false
func _ready():
	canSummon = false
	await  get_tree().create_timer(10.0).timeout
	canSummon = true
	$TentacleTimer.wait_time = tentacleSpawnInterval
	$TentacleTimer.start()
	$Camera2D.shakeCamera(4000, 1)
func _on_tentacle_timer_timeout() -> void:
	if canSummon:
		var canvasModulate = get_node("CanvasModulate")
		player.modulate = Color(1, 0.5, 0.5)
		canvasModulate.color = Color.RED
		await get_tree().create_timer(0.5).timeout
		player.modulate = Color(1, 1, 1)
		canvasModulate.color = Color.BLACK
		var spawnPos: Vector2 = player.position
		await  get_tree().create_timer(1.0).timeout
		var tentacle = tentacleScene.instantiate()
		tentacle.position = spawnPos
		tentacle.scrollSpeed = floorScrollSpeed
		add_child(tentacle)


func _physics_process(delta: float) -> void:
	if can && Input.is_action_just_pressed("space"):
		
		$AnimationPlayer.play("new_animation")
		await $AnimationPlayer.animation_finished
		get_tree().change_scene_to_file("res://Scene/end_train_cut_scne.tscn")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player2":
		player.canDie = false
		$CanvasLayer/Label.visible = true
		canSummon = false
		can = true

			


func _on_tut_timeout() -> void:
	$CanvasLayer/Label2.visible = false

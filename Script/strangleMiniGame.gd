extends CanvasLayer

signal miniGameSuccess
signal miniGameFail

@onready var greenZone = $greenZone
@onready var progressBar = $progressBar
@onready var timer = $Timer
@onready var animPlayer = $AnimationPlayer

@export var progressSpeed: float
@export var shrinkDuration: float = 4.0
@export var greenZoneMinX := 50
@export var greenZoneMaxX := 450

var progress := 0.0
var isGameActive := false

func _ready():
	visible = false


func start_minigame():
	$tenfight.play()
	progress = 0.0
	isGameActive = true
	visible = true
	progressBar.size.x = 0

	var xPos = randi_range(greenZoneMinX, greenZoneMaxX)
	greenZone.position.x = xPos
	print("playing anim")
	timer.start()

func _process(_delta):
	if Input.is_action_just_pressed("hackerKey"):
		emit_signal("miniGameSuccess")
	if isGameActive and Input.is_action_just_pressed("space"):
		$AudioStreamPlayer2D.play()
		
		progress += progressSpeed
		progressBar.size.x = progress
		print(progressBar.size.x)
		check_for_success()
	if progress>0.0:
		progress-=0.5
		
		progressBar.size.x = progress
func check_for_success():
	if progressBar.global_position.x + progressBar.size.x > greenZone.global_position.x and progressBar.global_position.x < greenZone.global_position.x + greenZone.size.x:
		isGameActive = false
		visible = false
		$tenfight.stop()
		emit_signal("miniGameSuccess")

	


func _on_timer_timeout() -> void:
	if isGameActive:
		isGameActive = false
		visible = false
		$tenfight.stop()
		get_tree().change_scene_to_file("res://Scene/gameover1.tscn")
		emit_signal("miniGameFail")

extends Node2D

@export var maxShakeAmount: float = 10.0 
@export var shakeDuration: float = 5.0  
@export var shakeFrequency: float = 30.0 

var shakeTimer: float = 0.0
var basePosition: Vector2
var shaking: bool = false

func _ready():
	basePosition = position
func start_shaking():
	shaking = true
	shakeTimer = 0.0

func _process(delta: float) -> void:
	if shaking:
		shakeTimer += delta
		
		var intensity = min(shakeTimer / shakeDuration, 1.0)
		
		var offset = Vector2(
			randf_range(-1, 1),
			randf_range(-1, 1)
		).normalized() * maxShakeAmount * intensity
		
		position = basePosition + offset
	else:
		position = basePosition

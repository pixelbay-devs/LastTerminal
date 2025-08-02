extends Camera2D

var isShaking = false
var shakeDuration = 0.0
var shakeTime = 0.0
var shakeStrength = 0.0

var originalOffset := Vector2.ZERO

func _ready():
	originalOffset = offset
	randomize()

func shakeCamera(duration: float, strength: float):
	isShaking = true
	shakeDuration = duration
	shakeTime = 0.0
	shakeStrength = strength

func _process(delta):
	if isShaking:
		shakeTime += delta

		if shakeTime >= shakeDuration:
			isShaking = false
			offset = originalOffset
		else:
			var xJitter = randf_range(-1.0, 1.0) * shakeStrength
			var yJitter = randf_range(-1.0, 1.0) * shakeStrength
			offset = originalOffset + Vector2(xJitter, yJitter)

func stopShake():
	isShaking = false
	offset = originalOffset

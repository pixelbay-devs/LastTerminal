extends Node2D

var a:int = 0
func _on_fake_body_entered(body: Node2D) -> void:
	if body.name=="Player" && a==0:
		$fake/fakevocal.play()
		a+=1
		


func _on_fake_body_exited(body: Node2D) -> void:
	$fake/fakevocal.stop()

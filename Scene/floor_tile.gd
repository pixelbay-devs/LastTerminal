extends Node2D

@export var moveSpeed: float = 100.0    
@export var tileHeight: float = 32.0   

@export var spriteNodes: Array[NodePath]

var scrollManager: Node2D           

func _ready():
	scrollManager = get_parent()
	randomize()

	for path in spriteNodes:
		var sprite = get_node_or_null(path)
		if sprite:
			sprite.visible = false

	if spriteNodes.size() > 0:
		var randomIndex = randi() % spriteNodes.size()
		var chosenSprite = get_node(spriteNodes[randomIndex])
		if chosenSprite:
			chosenSprite.visible = true

func _process(delta: float) -> void:
	position.y += moveSpeed * delta

	if position.y >= tileHeight * scrollManager.get_child_count():
		position.y -= tileHeight * scrollManager.get_child_count()

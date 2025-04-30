extends Teleporter

func _ready():
	super._ready()
	init($"../Teleporter_right", EXIT_DIRECTION.RIGHT)

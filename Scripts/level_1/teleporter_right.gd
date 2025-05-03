extends Teleporter

func _ready():
	super._ready()
	init($"../Teleporter_left", ExitDirection.LEFT)

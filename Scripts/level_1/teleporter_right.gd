extends Teleporter

func _ready():
	super._ready()
	init(get_node("../Teleporter_left"), exit_direction.LEFT )

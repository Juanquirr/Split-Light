extends Teleporter

func _ready():
	super._ready()
	init(get_node("../Teleporter_right"), exit_direction.RIGHT)

extends Control

class_name BasePlanet

var override_time := false
var original_colors: PackedColorArray
var time = 1000
var planet_color_amount := 10
@export var relative_scale : float = 1.0
@export_range(8, 4096, 1) var pixels: int = 16
@export var should_dither = false
@export var planet_seed: int = 432784891
@export var center_point: Control
@export var max_light_radius := 350.0
@export var color_palette: PackedColorArray

func _ready() -> void:
	self.set_pixels(pixels)
	self.set_dither(should_dither)
	seed(planet_seed)
	self.set_seed(planet_seed)
	self.set_colors(get_packed_color_array())
	original_colors = self.get_colors()
	
func get_packed_color_array() -> PackedColorArray:
	if color_palette.size() != planet_color_amount:
		push_warning("Colors array must have exactly %s elements for %s. Using default." % [planet_color_amount, self.name])
		return get_colors()
	
	return PackedColorArray(color_palette)

func set_pixels(_amount: float):
	pass
func set_light(_pos: Vector2):
	pass
func set_seed(_sd: float):
	pass
func set_rotates(_r: float):
	pass
func update_time(_t: float):
	pass
func set_custom_time(_t: float):
	pass

func get_multiplier(mat: ShaderMaterial):
	return (round(mat.get_shader_parameter("size")) * 2.0) / mat.get_shader_parameter("time_speed")
	
func _process(delta: float):
	time += delta
	if !override_time:
		update_time(time)
		
	change_light_source_on_mouse_moved()

func change_light_source_on_mouse_moved() -> void:
	var center: Vector2 = self.center_point.get_screen_position()
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	var offset: Vector2 = mouse_pos - center
	var clamped_offset: Vector2 = offset.limit_length(self.max_light_radius)
	var clamped_pos: Vector2 = center + clamped_offset
	var normal = (clamped_pos / center) / 1.8
	set_light(normal)

func set_dither(_d: bool):
	pass

func get_dither() -> bool:
	return false

func get_colors() -> PackedColorArray:
	return [Color(255, 255, 255)]

func set_colors(_colors: PackedColorArray):
	pass

func get_colors_from_shader(mat: ShaderMaterial, uniform_name: String = "colors"):
	return mat.get_shader_parameter(uniform_name)

func set_colors_on_shader(mat: ShaderMaterial, colors: PackedColorArray, uniform_name: String = "colors"):
	mat.set_shader_parameter(uniform_name, colors)

func randomize_colors():
	pass

# Using ideas from https://www.iquilezles.org/www/articles/palettes/palettes.htm
func _generate_new_colorscheme(n_colors, hue_diff = 0.9, saturation = 0.5) -> PackedColorArray:
#	var a = Vector3(rand_range(0.0, 0.5), rand_range(0.0, 0.5), rand_range(0.0, 0.5))
	var a = Vector3(0.5,0.5,0.5)
#	var b = Vector3(rand_range(0.1, 0.6), rand_range(0.1, 0.6), rand_range(0.1, 0.6))
	var b = Vector3(0.5,0.5,0.5) * saturation
	var c = Vector3(randf_range(0.5, 1.5), randf_range(0.5, 1.5), randf_range(0.5, 1.5)) * hue_diff
	var d = Vector3(randf_range(0.0, 1.0), randf_range(0.0, 1.0), randf_range(0.0, 1.0)) * randf_range(1.0, 3.0)

	var cols = PackedColorArray()
	var n = float(n_colors - 1.0)
	n = max(1, n)
	for i in range(0, n_colors, 1):
		var vec3 = Vector3()
		vec3.x = (a.x + b.x *cos(6.28318 * (c.x*float(i/n) + d.x)))
		vec3.y = (a.y + b.y *cos(6.28318 * (c.y*float(i/n) + d.y)))
		vec3.z = (a.z + b.z *cos(6.28318 * (c.z*float(i/n) + d.z)))

		cols.append(Color(vec3.x, vec3.y, vec3.z))
	
	return cols

func get_layers() -> Dictionary:
	var layers = []
	for c in get_children():
		layers.append({"name": c.get_name(), "visible": c.visible})
	return layers

func toggle_layer(num):
	get_children()[num].visible = !get_children()[num].visible

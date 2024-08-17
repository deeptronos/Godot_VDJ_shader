extends Control

const VU_COUNT = 16
const FREQ_MAX = 11050.5
const MIN_DB = 60
const WIDTH = 800
const HEIGHT = 250
const HEIGHT_SCALE = 8.0
const ANIMATION_SPEED = 0.1

var spectrum
var min_values = []
var max_values = []
var mag = 0.
var tween

# Called when the node enters the scene tree for the first time.
func _ready():
	#test_tween();
	tween = get_tree().create_tween();
	spectrum = AudioServer.get_bus_effect_instance(0,0)
	min_values.resize(VU_COUNT)
	min_values.fill(0.0)
	max_values.resize(VU_COUNT)
	max_values.fill(0.0)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var data = []
	var prev_hz = 0
	
	var mag = spectrum.get_magnitude_for_frequency_range(200., 600.).length()
	var engy = clampf((MIN_DB + linear_to_db(mag)) / MIN_DB, 0 ,1)
	var hgt = engy * HEIGHT * HEIGHT_SCALE
	var mng = remap(hgt, MIN_DB, HEIGHT*HEIGHT_SCALE, 0., 1.)
	#tween.tween_method(set_shader_value, 0., mng, delta);

	$TextureRect.material.set_shader_parameter("arb2", mng);


	for i in range(1, VU_COUNT + 1):
		var hz = i * FREQ_MAX / VU_COUNT;
		var magnitude = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
		var energy = clampf((MIN_DB + linear_to_db(magnitude)) / MIN_DB, 0 ,1)
		var height = energy * HEIGHT * HEIGHT_SCALE;
		data.append(height)
		prev_hz = hz

	for i in range(VU_COUNT):
		if data[i] > max_values[i]:
			max_values[i] = data[i]
		else:
			max_values[i] = lerp(max_values[i], data[i], ANIMATION_SPEED)

		if data[i] <= 0.0:
			min_values[i] = lerp(min_values[i], 0.0, ANIMATION_SPEED)
	
	var rmp = remap(data[VU_COUNT/2], MIN_DB, HEIGHT* HEIGHT_SCALE, 0, 3.5)
	#var mng = remap(hgt, MIN_DB, HEIGHT*HEIGHT_SCALE, 0., 1.)
	$TextureRect.material.set_shader_parameter("arb", rmp);
	
	



func test_tween():
	var tween = get_tree().create_tween();
	tween.tween_method(set_shader_value, 0., 3.5, 2);
	
func set_shader_value(value: float):
	$TextureRect.material.set_shader_parameter("arb", value);

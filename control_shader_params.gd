extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	test_tween();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func test_tween():
	var tween = get_tree().create_tween();
	tween.tween_method(set_shader_value, 0., 3.5, 2);
	
func set_shader_value(value: float):
	$TextureRect.material.set_shader_parameter("arb", value);

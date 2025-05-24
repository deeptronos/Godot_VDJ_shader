extends Node

func _ready():
	OS.open_midi_inputs()
	print(OS.get_connected_midi_inputs())

func _input(input_event):
	if input_event is InputEventMIDI:
		if input_event.pitch != 0:
			_print_midi_info(input_event)

func _print_midi_info(midi_event):
	print(midi_event)
	print("Channel ", midi_event.channel)
	print("Message ", midi_event.message)
	print("Pitch ", midi_event.pitch)
	print("Velocity ", midi_event.velocity)
	print("Instrument ", midi_event.instrument)
	print("Pressure ", midi_event.pressure)
	print("Controller number: ", midi_event.controller_number)
	print("Controller value: ", midi_event.controller_value)

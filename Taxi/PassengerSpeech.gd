extends Node2D

@onready var _speech_label = $PassengerSpeechLabel
@onready var _timer = $Timer


func _ready() -> void:
	JourneyManager.new_journey.connect(_on_new_journey)


func _on_new_journey(journey : Node) -> void:
	var street_name : String = journey.destination_road_name

	_speech_label.text = "To " + street_name
	_speech_label.visible = true

	_timer.start()


func _on_timer_timeout():
	_speech_label.visible = false

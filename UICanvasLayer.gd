extends CanvasLayer


func _ready() -> void:
	Events.road_entered.connect(_on_road_entered)


func _on_road_entered(road_name : String) -> void:
	$StreetNameLabel.text = road_name

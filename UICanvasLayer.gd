extends CanvasLayer


func _ready():
	Events.road_entered.connect(_on_road_entered)


func _on_road_entered(road_name : String):
	$StreetNameLabel.text = road_name

extends TileMap

var spawn_locations : Array[Vector2]

func get_possible_pickup_dropoff_locations() -> Array[Vector2]:
	var all_tilemap_cells = get_used_cells(0)

	for tilemap_cell in all_tilemap_cells:
		var cell_data = get_cell_tile_data(0, tilemap_cell)
		var spawn_offset = cell_data.get_custom_data("spawn_offset")

		if spawn_offset != Vector2.ZERO:
			# Per https://www.reddit.com/r/godot/comments/18jcugp/how_can_the_rotation_of_a_particular_tile_in_a/kdkzz48/
			var cell_alt = get_cell_alternative_tile(0, tilemap_cell)
			if cell_alt & TileSetAtlasSource.TRANSFORM_TRANSPOSE:
				spawn_offset = Vector2(spawn_offset.y, spawn_offset.x)
			if cell_alt & TileSetAtlasSource.TRANSFORM_FLIP_H:
				spawn_offset.x *= -1
			if cell_alt & TileSetAtlasSource.TRANSFORM_FLIP_V:
				spawn_offset.y *= -1

			var cell_location = map_to_local(tilemap_cell)

			spawn_locations.append(cell_location + spawn_offset)

	return spawn_locations

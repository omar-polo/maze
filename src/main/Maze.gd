extends Node2D

export (int) var height := 16
export (int) var width := 16

var _maze := []
var _queue := []
var _edges := []
var _edges_weight := []
var _cost := []
var _found := []


func _xy_to_idx(x: int, y: int) -> int:
	return y * width + x


func _queue_min() -> int:
	var m = null
	var idx := 0
	for i in _queue.size():
		var e = _queue[i]
		if m == null or _cost[e] < _cost[m]:
			m = e
			idx = i

	var t = _queue[idx]
	_queue.remove(idx)
	return t


func _maze_create() -> void:
	var size := width * height

	_edges.resize(size)
	_edges_weight.resize(size)
	_maze.resize(size)
	_cost.resize(size)
	_found.resize(size)

	# initialize
	for i in size:
		_maze[i] = []
		_edges_weight[i] = []

		var x := int(floor(i % width))
		var y := int(floor(i / width))

		if x > 0:
			_maze[i].append(_xy_to_idx(x - 1, y))
		if x < width - 1:
			_maze[i].append(_xy_to_idx(x + 1, y))
		if y > 0:
			_maze[i].append(_xy_to_idx(x, y - 1))
		if y < height - 1:
			_maze[i].append(_xy_to_idx(x, y + 1))

		for t in _maze[i].size():
			_edges_weight[i].append(randf())

	for i in size:
		_cost[i] = 999

	for i in size:
		_found[i] = false

	# patch the first node (the starting one)
	_cost[0] = 0
	_found[0] = true
	_queue.append(0)

	# main loop of the algo
	while _queue.size() != 0:
		var v := _queue_min()
		_found[v] = true

		for i in _maze[v].size():
			var w: int = _maze[v][i]
			var c: float = _edges_weight[v][i]
			if not _found[w] and c < _cost[w]:
				_cost[w] = c
				_edges[w] = v
				_queue.append(w)


func _draw() -> void:
	# draw the box
	$walls.set_cell(-1, -1, 0)
	$bg.set_cell(-1, -1, 0)
	for x in width * 2:
		$bg.set_cell(x, -1, 0)
		$walls.set_cell(x, -1, 0)
	for y in height * 2:
		$bg.set_cell(-1, y, 0)
		$walls.set_cell(-1, y, 0)

	# fill the screen with walls
	for x in width * 2:
		for y in height * 2:
			$bg.set_cell(x, y, 0)
			$walls.set_cell(x, y, 0)

	# remove the wall from the position of each node
	for x in width:
		for y in height:
			$walls.set_cell(x * 2, y * 2, -1)

	# dig a passage on the selected edges
	for v in _edges.size():
		if _edges[v] == null:
			continue
		var w: int = _edges[v]

		var vx := int(floor(v % width))
		var vy := int(floor(float(v) / height))
		var wx := int(floor(w % width))
		var wy := int(floor(float(w) / height))

		var tx := 0
		var ty := 0

		if vx == wx:
			tx = vx * 2
			ty = vy + wy
		else:
			tx = vx + wx
			ty = vy * 2
		$walls.set_cell(tx, ty, -1)


func _ready() -> void:
	_maze_create()
	# print("weights:", _edges_weight)
	# print("edges:", _edges)
	_draw()
	$walls.update_bitmask_region(Vector2(-1, -1), Vector2(width * 2, height * 2))

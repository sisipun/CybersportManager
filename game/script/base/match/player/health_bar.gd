class_name HealthBar
extends ProgressBar


func init(_max_value: float) -> void:
	print(_max_value)
	min_value = 0
	max_value = _max_value
	value = _max_value

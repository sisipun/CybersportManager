class_name HealthBar
extends ProgressBar


func init(_max_value: float) -> void:
	min_value = 0
	max_value = _max_value
	value = _max_value

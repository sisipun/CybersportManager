class_name BaseMigration
extends Resource


@export var _path: String = ""
@export var _file_name: String = ""


func migrate(database: Database) -> void:
	var file_path = _path + '/' + _file_name
	if not FileAccess.file_exists(file_path):
		print('Migration file', file_path, 'not found')
		return

	var file = FileAccess.open(file_path, FileAccess.READ)
	_migrate(file, database)
	file.close()


func _migrate(_file: FileAccess, _database: Database) -> void:
	pass

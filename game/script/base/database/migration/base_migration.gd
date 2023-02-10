class_name BaseMigration
extends Resource


export (String) var _path: String = ""
export (String) var _file_name: String = ""


func migrate(database: Database) -> void:
	var file_path = _path + '/' + _file_name
	var file: File = File.new()
	if not file.file_exists(file_path):
		print('Migration file', file_path, 'not found')
		return
	
	assert(file.open(file_path, File.READ) == OK)
	_migrate(file, database)
	file.close()


func _migrate(_file: File, _database: Database) -> void:
	pass

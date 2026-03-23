@tool
extends EditorPlugin

# 完善后的后缀列表：包含脚本、场景配置、计算着色器、渲染着色器
const VALID_EXTENSIONS = [".gd", ".tscn", ".glsl", ".gdshader"]
# 排除不需要扫描的资源和版本控制目录
const EXCLUDE_DIRS = [".godot", "addons", ".git", "bin"]

func _enter_tree():
	add_tool_menu_item("导出 AI 上下文 (Export Context)", _on_export_pressed)

func _exit_tree():
	remove_tool_menu_item("导出 AI 上下文 (Export Context)")

func _on_export_pressed():
	print("[AI Exporter] 正在深度扫描项目代码与着色器资源...")
	var file_paths = []
	_scan_directory("res://", file_paths)
	
	if file_paths.is_empty():
		print("[AI Exporter] 未找到任何符合条件的文件。")
		return
		
	var final_output = "=== 项目全量上下文快照 ===\n"
	final_output += "生成时间: " + Time.get_datetime_string_from_system() + "\n"
	final_output += "环境版本: Godot 4.6 / Forward+ (Vulkan)\n"
	final_output += "=========================\n\n"
	
	for path in file_paths:
		var file = FileAccess.open(path, FileAccess.READ)
		if file:
			var content = file.get_as_text()
			# 针对不同后缀使用不同的 Markdown 语言标签，确保 AI 读取时的可读性
			var lang = "gdscript"
			if path.ends_with(".tscn"): 
				lang = "toml" # Godot 的场景文件格式接近 toml
			elif path.ends_with(".glsl") or path.ends_with(".gdshader"):
				lang = "glsl"
			
			final_output += "### FILE_PATH: " + path + " ###\n"
			final_output += "```" + lang + "\n"
			final_output += content + "\n"
			final_output += "```\n\n"
			file.close()
	
	# 保存至项目根目录
	var save_path = "res://full_project_context.txt"
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	if save_file:
		save_file.store_string(final_output)
		save_file.close()
		
		# 触发编辑器文件系统刷新
		var editor_fs = EditorInterface.get_resource_filesystem()
		if editor_fs:
			editor_fs.scan()
			
		print("[AI Exporter] 导出成功！文件已更新至: ", save_path)
		OS.alert("项目文档已生成/更新，请查看：res://full_project_context.txt", "导出完成")
	else:
		printerr("[AI Exporter] 无法写入文件，请检查磁盘权限。")

# 递归扫描函数
func _scan_directory(path: String, output_paths: Array):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				if file_name != "." and file_name != ".." and not file_name in EXCLUDE_DIRS:
					var next_path = path.path_join(file_name) + "/"
					_scan_directory(next_path, output_paths)
			else:
				for ext in VALID_EXTENSIONS:
					if file_name.ends_with(ext):
						output_paths.append(path.path_join(file_name))
						break
			file_name = dir.get_next()
		dir.list_dir_end()

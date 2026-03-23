AI Context Exporter for Godot 4.6
中文说明 | English Description

中文说明
简介
AI Context Exporter 是一款专为 Godot 4.6 开发者设计的轻量级编辑器插件。它能够一键扫描并打包项目中的场景结构 (.tscn)、脚本 (.gd) 以及着色器代码 (.glsl, .gdshader)，生成一份结构清晰的 Markdown 文档。Word document automation

这份文档旨在为 Cursor, Claude, ChatGPT 或 Gemini 等大语言模型提供最完整的项目上下文，帮助 AI 更精准地理解你的节点层级、Shader 逻辑和资源绑定，从而给出真正可用的代码。

主要功能
一键全量导出：自动递归扫描 res:// 目录。
智能格式化：自动根据文件后缀（GDScript, GLSL, TOML）添加 Markdown 代码高亮标签。
着色器支持：完美支持 Compute Shader (.glsl) 和 Godot Shader (.gdshader)。
排除干扰：自动跳过 .godot, addons 等非业务代码文件夹。
实时刷新：生成后自动触发 Godot 文件系统扫描，无需切换窗口。
安装方法
下载本项目，将 addons/ai_context_exporter 文件夹放入你项目的 res://addons/ 目录下。
在 Godot 菜单中选择 项目 -> 项目设置 -> 插件。
勾选 AI Context Exporter 后方的“启用”。
在顶部菜单栏选择 项目 -> 工具 -> 导出 AI 上下文。

English Description
Introduction
AI Context Exporter is a lightweight editor plugin specifically designed for Godot 4.6 developers. It scans and packages project scene structures (.tscn), scripts (.gd), and shader codes (.glsl, .gdshader) into a single, well-structured Markdown document with one click.Document management system

This tool is built to provide Large Language Models (LLMs) like Cursor, Claude, ChatGPT, or Gemini with the most comprehensive project context. It helps AI accurately understand your node hierarchies, shader logic, and resource bindings, resulting in highly functional code suggestions.

Key Features
One-Click Full Export: Automatically recursively scans the res:// directory.
Smart Formatting: Adds Markdown syntax highlighting tags based on file extensions (GDScript, GLSL, TOML).
Shader Ready: Full support for Compute Shaders (.glsl) and Godot Shaders (.gdshader).
Smart Exclusion: Automatically skips non-essential folders like .godot, addons, and .git.
Auto-Refresh: Triggers Godot's filesystem scan immediately after generation.
Installation
Download this project and move the addons/ai_context_exporter folder into your project's res://addons/ directory.
Go to Project -> Project Settings -> Plugins in the Godot editor.
Check the "Enable" box next to AI Context Exporter.
Navigate to Project -> Tools -> Export AI Context in the top menu bar.
License
This project is licensed under the MIT License.

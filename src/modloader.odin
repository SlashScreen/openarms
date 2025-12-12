package main

import "core:encoding/json"
import "core:os/os2"
import "core:strings"

MOD_FOLDER :: "mods"

ModManifest :: struct {
	mod_name :   string,
	game_entry : string,
	menu_entry : string,
}

mount_mods :: proc() -> bool {
	paths, err := os2.read_directory_by_path(MOD_FOLDER, 0, context.temp_allocator)
	defer free_all(context.temp_allocator)
	if err != nil {
		log_err("No mods path found.")
		return false
	}

	for fi in paths {
		if !(fi.type == .Directory || fi.type == .Symlink) do continue
		log_debug("Mounting mod %s", fi.fullpath)
		vfs_mount(strings.clone(fi.fullpath))
	}

	return true
}

get_game_entry_point :: proc() -> (string, bool) {
	path, ok := vfs_find("manifest.json")
	if !ok {
		log_err("No manifest.json found")
		return "", false
	}

	manifest, m_ok := load_manifest_json(path)
	if !m_ok {
		log_err("Error loading manifest.json")
		return "", false
	}

	if len(manifest.game_entry) > 0 do return manifest.game_entry, true

	return "", false
}

@(private = "file")
load_manifest_json :: proc(path : string) -> (ModManifest, bool) {
	data, ok := vfs_read_file(path)
	defer delete(data)
	if !ok do return {}, false

	manifest : ModManifest
	err := json.unmarshal_string(data, &manifest)
	if err != nil do return {}, false

	return manifest, true
}


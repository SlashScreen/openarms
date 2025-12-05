package main

import "core:os"
import "core:os/os2"
import "core:slice"
BUILTIN_RESOURCES :: "client_resources"
DEFAULT_MOD_CAPACITY :: 8

// Mounted mods, sorted by priority
mounted_paths : [dynamic]string

vfs_init :: proc() {
	mounted_paths = make([dynamic]string, DEFAULT_MOD_CAPACITY)
	vfs_mount(BUILTIN_RESOURCES)
}

vfs_deinit :: proc() {
	delete(mounted_paths)
}

vfs_mount :: proc(path : string) {
	append(&mounted_paths, path)
}

vfs_unmount :: proc(path : string) {
	#reverse for p, idx in mounted_paths {
		if p == path {
			ordered_remove(&mounted_paths, idx)
			return
		}
	}
}

vfs_find :: proc(path : string) -> (string, bool) #optional_ok {
	for root in mounted_paths {
		elems := [?]string{root, path}
		f, err := os2.join_path(elems[:], context.allocator)
		defer delete(f)
		if err != nil do return "", false

		if os2.is_file(f) do return f, true
	}
	return "", false
}

vfs_list_dir :: proc(path : string) -> [dynamic]string {
	list := make([dynamic]string)

	for root in mounted_paths {
		elems := [?]string{root, path}
		f, ferr := os2.join_path(elems[:], context.allocator)
		defer delete(f)
		if ferr != nil do continue

		file_dirs, derr := os2.read_directory_by_path(f, 0, context.allocator)
		defer os2.file_info_slice_delete(file_dirs, context.allocator)
		if derr != nil do continue

		for file in file_dirs {
			append(&list, file.fullpath)
		}
	}

	_ = slice.unique(list[:])

	return list
}


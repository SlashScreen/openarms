package main

import "core:os/os2"
import "core:slice"
import "core:strings"

BUILTIN_RESOURCES :: "client_resources"
DEFAULT_MOD_CAPACITY :: 8

// Mounted mods, sorted by priority
@(private = "file")
mounted_paths : [dynamic]string

vfs_init :: proc() {
	mounted_paths = make([dynamic]string)
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
		f, ferr := strings.join(elems[:], "/")
		if ferr != nil do return "", false
		if os2.exists(f) do return f, true
	}
	return "", false
}

vfs_list_dir :: proc(path : string) -> [dynamic]string {
	list := make([dynamic]string)

	for root in mounted_paths {
		elems := [?]string{root, path}
		// TODO: Use OS or whatever
		f, ferr := strings.join(elems[:], "/")
		defer delete(f)
		if ferr != nil do continue

		file_dirs, derr := os2.read_directory_by_path(f, 0, context.allocator)
		defer os2.file_info_slice_delete(file_dirs, context.allocator)
		if derr != nil do continue

		for file in file_dirs do append(&list, file.fullpath)
	}

	slice.sort(list[:])
	deduped := slice.unique(list[:])
	resize(&list, len(deduped))

	return list
}

vfs_read_file :: proc(path : string) -> (string, bool) {
	data, err := os2.read_entire_file_from_path(path, context.allocator)
	if err != nil do return "", false
	return string(data), true
}


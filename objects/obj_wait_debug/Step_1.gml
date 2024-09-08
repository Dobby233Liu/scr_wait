/// @description Cleans up entries for dead instances.

for (var index = ds_map_find_first(timers); !is_undefined(index); index = ds_map_find_next(timers, index)) {
    if (!instance_exists(index) || timers[? index].is_expired())
        ds_map_delete(timers, index);
}
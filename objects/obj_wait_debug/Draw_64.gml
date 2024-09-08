/// @description Prints active timers to screen.

var font = draw_get_font()
var font_h = font >= 0 ? font_get_size(font) : 16
var xx = 0, yy = 0

for (var index = ds_map_find_first(timers); !is_undefined(index); index = ds_map_find_next(timers, index)) {
    var value = timers[? index];
    draw_text(xx, yy, string("{0}({1}) - {2}/{3}", real(index.id), object_get_name(index.object_index), value.time, value.duration));
    yy += font_h;
}
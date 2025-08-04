function scr_wait_cb() {}

function scr_wait_cb_on_timer_creation() {
    with (obj_wait_debug)
        timers[? other.id] = other._scw_wait_timer;
}
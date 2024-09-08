// (C) 2024 Liu Wenyuan
// Distributed under the Boost Software License, Version 1.0.
// (See accompanying file scr_wait_LICENSE.txt or copy at
// https://www.boost.org/LICENSE_1_0.txt)

// This script provides a function that enables waiting for a certain
// amount of time before executing certain code.
// For example, this is useful for waiting for a certain amount of time
// in cutscene code.

/// Starts a timer for this instance, then ticks it until it expires.
/// Returns whether the timer has expired or not.
///
/// If one is already present, it won't be overriden regardless of
/// the duration passed in this call.
/// If the existing timer's duration doesn't match the duration getting
/// passed in, it will not get ticked.
///
/// You may check instance variable `_scw_waiting` to know if a timer
/// has been started.
///
/// @param {Real} duration # Measured by frames (as the default rate is 1)
/// @returns {Bool}
function scr_wait(duration) {
    if duration <= 0
        return true;

    if !is_struct(variable_instance_get(id, "_scw_wait_timer")) {
        _scw_waiting = duration;
        _scw_wait_timer = new obj_wait_timer(duration);
        with (obj_wait_debug)
            timers[? other.id] = other._scw_wait_timer;
    } else if _scw_wait_timer.duration != duration
        return false;

    var expired = _scw_wait_timer.tick();
    if (expired) {
        _scw_waiting = 0;
        delete _scw_wait_timer;
    }

    return expired;
}

/// Timer created by scr_wait for each instance.
/// @param {Real} _duration # Measured by frames (as the default rate is 1)
function obj_wait_timer(_duration) constructor {
    /// The amount of time this timer has ticked for.
    time = 0;

    /// The maximum time until this timer expires.
    duration = _duration;

    /// The amount of time to progress each tick.
    rate = 1;

    /// Returns whether the timer has expired or not.
    /// @returns {Bool}
    is_expired = function() {
        time = clamp(time, 0, duration);
        return time == duration;
    }

    /// Increases time until the timer expires.
    /// @returns {Bool}
    tick = function() {
        time += rate;
        return is_expired();
    }
}
# cython: language_level=3
#  Drakkar-Software OctoBot-Websockets
#  Copyright (c) Drakkar-Software, All rights reserved.
#
#  This library is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Lesser General Public
#  License as published by the Free Software Foundation; either
#  version 3.0 of the License, or (at your option) any later version.
#
#  This library is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  Lesser General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public
#  License along with this library.

cdef class Feed:
    cdef str api_key
    cdef str api_secret

    cdef int timeout
    cdef int timeout_interval
    cdef int book_update_interval
    cdef int updates

    cdef bint create_loop
    cdef bint is_connected
    cdef bint do_deltas
    cdef bint should_stop

    cdef public list pairs
    cdef public list time_frames
    cdef public list channels

    cdef public dict callbacks

    # objects
    cdef public object loop
    cdef public object logger
    cdef public object websocket
    cdef public object websocket_task
    cdef public object ccxt_client
    cdef public object async_ccxt_client
    cdef object _watch_task
    cdef object last_msg

    cdef __initialize(self, list pairs, list channels, dict callbacks)
    cdef on_close(self)
    cdef list get_auth(self)
    cdef list get_pairs(self)
    cdef double fix_timestamp(self, double ts)
    cdef double timestamp_normalize(self, double ts)
    cdef str feed_to_exchange(self, feed)
    cdef float safe_float(self, dict dictionary, key, default_value)

    cpdef start(self)
    cpdef stop(self)
    cpdef close(self)

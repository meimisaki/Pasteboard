package com.sorakasugano.pasteboard;

import redis.clients.jedis.*;

public interface Runner<T> {
    public T run(Jedis jedis);
}

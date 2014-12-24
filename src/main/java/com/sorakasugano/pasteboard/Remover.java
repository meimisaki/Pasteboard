package com.sorakasugano.pasteboard;

import redis.clients.jedis.*;
import com.sorakasugano.pasteboard.Writer;

public class Remover extends Writer {
    @Override
    public Object call(Jedis jedis) {
        return null;
    }
}

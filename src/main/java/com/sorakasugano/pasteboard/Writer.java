package com.sorakasugano.pasteboard;

import java.util.*;
import redis.clients.jedis.*;

public abstract class Writer extends Actor {
    @Override
    public Map<String, Boolean> keys() {
        Map<String, Boolean> keys = super.keys();
        keys.put(type + ":" + id, true);
        return keys;
    }
}

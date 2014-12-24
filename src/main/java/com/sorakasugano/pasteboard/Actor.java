package com.sorakasugano.pasteboard;

import java.util.*;
import redis.clients.jedis.*;

public abstract class Actor<T> {
    public String type = null;
    public String id = null;
    public abstract T call(Jedis jedis) throws Exception;
    public Map<String, Boolean> keys() {
        Map<String, Boolean> keys = new HashMap<String, Boolean>();
        return keys;
    }
}

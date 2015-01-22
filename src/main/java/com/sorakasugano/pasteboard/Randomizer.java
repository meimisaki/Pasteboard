package com.sorakasugano.pasteboard;

import java.util.*;
import redis.clients.jedis.*;

public class Randomizer extends Actor<String> {
    private static final Random random = new Random();
    public String subtype = null;
    private String list() {
        return (type == null ? "" : type + ":" + id + ":") + subtype + "-list";
    }
    @Override
    public String call(Jedis jedis) throws Exception {
        String key = list();
        long len = jedis.zcard(key);
        if (len == 0) return null;
        int idx = random.nextInt((int)len);
        for (String id : jedis.zrange(key, idx, idx + 1)) {
            return id;
        }
        return null;
    }
    @Override
    public Map<String, Boolean> keys() {
        Map<String, Boolean> keys = super.keys();
        keys.put(list(), false);
        return keys;
    }
}

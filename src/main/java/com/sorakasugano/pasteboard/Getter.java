package com.sorakasugano.pasteboard;

import java.util.*;
import redis.clients.jedis.*;
import com.sorakasugano.pasteboard.Reader;

public class Getter extends Reader<Map<String, String>> {
    @Override
    public Map<String, String> call(Jedis jedis) throws Exception {
        String key = type + ":" + id;
        if (!jedis.exists(key)) return null;
        Map<String, String> out = jedis.hgetAll(key);
        out.put("id", id);
        return out;
    }
}

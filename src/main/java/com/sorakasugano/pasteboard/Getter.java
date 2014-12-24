package com.sorakasugano.pasteboard;

import java.util.*;
import redis.clients.jedis.*;
import com.sorakasugano.pasteboard.Reader;

public class Getter extends Reader<Map<String, String>> {
    public Map<String, String> call(Jedis jedis) throws Exception {
        Map<String, String> out = jedis.hgetAll(type + ":" + id);
        out.put("id", id);
        return out;
    }
}

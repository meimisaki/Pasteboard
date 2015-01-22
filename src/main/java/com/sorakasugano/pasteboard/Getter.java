package com.sorakasugano.pasteboard;

import java.util.*;
import redis.clients.jedis.*;

public class Getter extends Reader<Map<String, String>> {
    @Override
    public Map<String, String> call(Jedis jedis) throws Exception {
        String key = type + ":" + id;
        if (!jedis.exists(key)) return null;
        Map<String, String> out = jedis.hgetAll(key);
        for (Map.Entry<String, String> entry : out.entrySet()) {
            char[] chars = entry.getValue().toCharArray();
            byte[] bytes = new byte[chars.length];
            for (int i = 0 ; i < chars.length ; ++i) bytes[i] = (byte)chars[i];
            out.put(entry.getKey(), new String(bytes, "UTF-8"));
        }
        out.put("id", id);
        return out;
    }
}

package com.sorakasugano.pasteboard;

import java.util.*;
import redis.clients.jedis.*;

class StarsCounter extends Reader<Long> {
    @Override
    public Long call(Jedis jedis) throws Exception {
        return jedis.scard(type + ":" + id + ":star-list");
    }
    @Override
    public Map<String, Boolean> keys() {
        Map<String, Boolean> keys = super.keys();
        keys.put(type + ":" + id + ":star-list", false);
        return keys;
    }
}

public class DBUtils {
    public static Long countStars(String id) throws Exception {
        StarsCounter counter = new StarsCounter();
        counter.type = "code";
        counter.id = id;
        return Adapter.invoke(counter);
    }
}

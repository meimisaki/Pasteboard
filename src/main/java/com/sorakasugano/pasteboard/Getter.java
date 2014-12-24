package com.sorakasugano.pasteboard;

import java.util.*;
import redis.clients.jedis.*;
import com.sorakasugano.pasteboard.Adapter;
import com.sorakasugano.pasteboard.Runner;
import com.sorakasugano.pasteboard.Reader;

public class Getter extends Reader<Map<String, String>> {
    @Override
    public Map<String, String> call() throws Exception {
        return Adapter.run(new Runner<Map<String, String>>() {
            @Override
            public Map<String, String> run(Jedis jedis) {
                return jedis.hgetAll(type + ":" + id);
            }
        });
    }
}

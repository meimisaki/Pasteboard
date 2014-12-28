package com.sorakasugano.pasteboard;

import java.util.*;
import redis.clients.jedis.*;
import com.sorakasugano.pasteboard.Adapter;
import com.sorakasugano.pasteboard.Reader;
import com.sorakasugano.pasteboard.Getter;

public class Selector extends Reader<List<Map<String, String>>> {
    public String subtype = null;
    public String alias = null;
    public int offset = 0;
    public int limit = -1;
    private String list() {
        return (type == null ? "" : type + ":" + id + ":") + subtype + "-list";
    }
    @Override
    public List<Map<String, String>> call(Jedis jedis) throws Exception {
        Set<String> set = jedis.zrevrange(list(), offset, limit < 0 ? -1 : offset + limit);
        List<Map<String, String>> out = new LinkedList<Map<String, String>>();
        for (String id : set) {
            Getter getter = new Getter();
            getter.type = alias == null ? subtype : alias;
            getter.id = id;
            out.add(Adapter.invoke(getter));
        }
        return out;
    }
}

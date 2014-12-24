package com.sorakasugano.pasteboard;

import java.util.*;
import java.text.*;
import redis.clients.jedis.*;
import com.sorakasugano.pasteboard.Writer;

public class Setter extends Writer {
    public String owner = null;
    public Map<String, String> object = null;
    public boolean replace = true;
    private static String ISOString(Date date) {
        DateFormat iso = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
        iso.setTimeZone(TimeZone.getTimeZone("UTC"));
        return iso.format(date);
    }
    private String list() {
        return (owner == null ? "" : owner + ":") + type + "-list";
    }
    public Boolean call(Jedis jedis) throws Exception {
        String key = type + ":" + id;
        boolean exists = jedis.exists(key);
        if (!exists || replace) {
            Date date = new Date();
            String time = ISOString(date);
            if (!exists) object.put("created_time", time);
            object.put("modified_time", time);
            jedis.hmset(key, object);
            jedis.zadd(list(), date.getTime(), id);
        }
        return !exists;
    }
    @Override
    public Map<String, Boolean> keys() {
        Map<String, Boolean> keys = super.keys();
        keys.put(list(), true);
        return keys;
    }
}

package com.sorakasugano.pasteboard;

import java.util.*;
import javax.servlet.http.*;
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

abstract class StarHelper extends Writer {
    public String user = null;
    @Override
    public Map<String, Boolean> keys() {
        Map<String, Boolean> keys = super.keys();
        keys.put(type + ":" + id + ":star-list", true);
        keys.put("user:" + user + ":star-list", true);
        return keys;
    }
}

public class DBUtils {
    public static Map<String, String> self(HttpServletRequest req) throws Exception {
        String token = null;
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("token")) {
                    token = cookie.getValue();
                    break;
                }
            }
        }
        if (token != null) {
            Reader<String> reader = new Reader<String>() {
                @Override
                public String call(Jedis jedis) throws Exception {
                    return jedis.get(type + ":" + id);
                }
            };
            reader.type = "token";
            reader.id = token;
            String id = Adapter.invoke(reader);
            if (id != null) {
                Getter getter = new Getter();
                getter.type = "user";
                getter.id = id;
                return Adapter.invoke(getter);
            }
        }
        return null;
    }
    public static Long countStars(String id) throws Exception {
        StarsCounter counter = new StarsCounter();
        counter.type = "code";
        counter.id = id;
        return Adapter.invoke(counter);
    }
    public static void star(String cid, String uid) throws Exception {
        StarHelper helper = new StarHelper() {
            @Override
            public Object call(Jedis jedis) throws Exception {
                jedis.sadd(type + ":" + id + ":star-list", user);
                jedis.zadd("user:" + user + ":star-list", new Date().getTime(), id);
                return null;
            }
        };
        helper.type = "code";
        helper.id = cid;
        helper.user = uid;
        Adapter.invoke(helper);
    }
    public static void unstar(String cid, String uid) throws Exception {
        StarHelper helper = new StarHelper() {
            @Override
            public Object call(Jedis jedis) throws Exception {
                jedis.srem(type + ":" + id + ":star-list", user);
                jedis.zrem("user:" + user + ":star-list", id);
                return null;
            }
        };
        helper.type = "code";
        helper.id = cid;
        helper.user = uid;
        Adapter.invoke(helper);
    }
}

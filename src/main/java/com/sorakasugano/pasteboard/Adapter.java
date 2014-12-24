package com.sorakasugano.pasteboard;

import java.util.*;
import java.util.concurrent.locks.*;
import redis.clients.jedis.*;
import redis.clients.jedis.exceptions.*;
import com.sorakasugano.pasteboard.Actor;
import com.sorakasugano.pasteboard.Runner;

public class Adapter {
    private static Map<String, ReadWriteLock> locks = new WeakHashMap<String, ReadWriteLock>();
    private static JedisPool pool = null;
    public static <T> T run(Runner<T> runner) throws Exception {
        synchronized (JedisPool.class) {
            if (pool == null) {
                JedisPoolConfig config = new JedisPoolConfig();
                pool = new JedisPool(config, "127.0.0.1");
            }
        }
        Jedis jedis = null;
        try {
            jedis = pool.getResource();
            return runner.run(jedis);
        }
        catch (JedisException except) {
            if (jedis != null) {
                pool.returnBrokenResource(jedis);
                jedis = null;
            }
            throw except;
        }
        finally {
            if (jedis != null) pool.returnResource(jedis);
        }
    }
    private static Map<String, ReadWriteLock> lock(Map<String, Boolean> keys) {
        Map<String, ReadWriteLock> out = new HashMap<String, ReadWriteLock>();
        synchronized (Adapter.class) {
            for (Map.Entry<String, Boolean> entry : keys.entrySet()) {
                String key = entry.getKey();
                ReadWriteLock lock = null;
                if (locks.containsKey(key)) lock = locks.get(key);
                else lock = locks.put(key, new ReentrantReadWriteLock());
                out.put(key, lock);
                if (entry.getValue()) lock.writeLock().lock();
                else lock.readLock().lock();
            }
        }
        return out;
    }
    private static void unlock(Map<String, Boolean> keys) {
        synchronized (Adapter.class) {
            for (Map.Entry<String, Boolean> entry : keys.entrySet()) {
                ReadWriteLock lock = locks.get(entry.getKey());
                if (entry.getValue()) lock.writeLock().unlock();
                else lock.readLock().unlock();
            }
        }
    }
    public static <T> T invoke(Actor<T> actor) throws Exception {
        Map<String, Boolean> keys = actor.keys();
        Map<String, ReadWriteLock> locks = lock(keys);
        try {
            return actor.call();
        }
        finally {
            unlock(keys);
        }
    }
}

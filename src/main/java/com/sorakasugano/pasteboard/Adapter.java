package com.sorakasugano.pasteboard;

import java.io.*;
import java.util.*;
import java.util.concurrent.locks.*;
import org.apache.commons.lang3.*;
import redis.clients.jedis.*;
import redis.clients.jedis.exceptions.*;
import com.sorakasugano.pasteboard.Actor;
import com.sorakasugano.pasteboard.InvalidIdentifierException;

public class Adapter {
    private static Map<String, ReadWriteLock> locks = new WeakHashMap<String, ReadWriteLock>();
    private static JedisPool pool = null;
    private static int index = 0;
    private static void initialize() throws IOException {
        synchronized (JedisPool.class) {
            if (pool == null) {
                JedisPoolConfig config = new JedisPoolConfig();
                config.setMaxActive(-1);
                pool = new JedisPool(config, "127.0.0.1");
                InputStream in = null;
                try {
                    in = Adapter.class.getClassLoader().getResourceAsStream("database.properties");
                    Properties props = new Properties();
                    props.load(in);
                    index = Integer.parseInt(props.getProperty("index"));
                }
                catch (Exception except) {
                    // pass
                }
                finally {
                    if (in != null) in.close();
                }
            }
        }
    }
    private static Map<String, ReadWriteLock> lock(Map<String, Boolean> keys) {
        Map<String, ReadWriteLock> out = new HashMap<String, ReadWriteLock>();
        synchronized (Adapter.class) {
            for (Map.Entry<String, Boolean> entry : keys.entrySet()) {
                String key = entry.getKey();
                ReadWriteLock lock = locks.get(key);
                if (lock == null) {
                    lock = new ReentrantReadWriteLock();
                    locks.put(key, lock);
                }
                out.put(key, lock);
                if (entry.getValue()) lock.writeLock().lock();
                else lock.readLock().lock();
            }
        }
        return out;
    }
    private static void unlock(Map<String, Boolean> keys, Map<String, ReadWriteLock> locks) {
        synchronized (Adapter.class) {
            for (Map.Entry<String, Boolean> entry : keys.entrySet()) {
                ReadWriteLock lock = locks.get(entry.getKey());
                if (entry.getValue()) lock.writeLock().unlock();
                else lock.readLock().unlock();
            }
        }
    }
    public static <T> T invoke(Actor<T> actor) throws Exception {
        if (StringUtils.containsAny(actor.id, ":@")) {
            throw new InvalidIdentifierException("Invalid identifier: " + actor.id);
        }
        Map<String, Boolean> keys = actor.keys();
        Map<String, ReadWriteLock> locks = lock(keys);
        try {
            initialize();
            Jedis jedis = null;
            try {
                jedis = pool.getResource();
                jedis.select(index);
                return actor.call(jedis);
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
        finally {
            unlock(keys, locks);
        }
    }
}

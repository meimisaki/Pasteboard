package com.sorakasugano.pasteboard;

import java.util.*;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import redis.clients.jedis.*;
import redis.clients.jedis.exceptions.*;
import com.sorakasugano.pasteboard.Runner;
import com.sorakasugano.pasteboard.Reader;
import com.sorakasugano.pasteboard.Writer;

public class Adapter {
    private static Map<String, ReadWriteLock> locks = new ConcurrentHashMap<String, ReadWriteLock>();
    private static JedisPool pool = null;
    public static <T> T run(Runner<T> runner) throws Exception {
        synchronized (Adapter.class) {
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
    public static <T> T read(Reader<T> reader) throws Exception {
        ReadWriteLock lock = locks.putIfAbsent(reader.toString(), new ReentrantReadWriteLock());
        lock.readLock().lock();
        try {
            return reader.call();
        }
        finally {
            lock.readLock().unlock();
        }
    }
    public static void write(Writer writer) throws Exception {
        ReadWriteLock lock = locks.putIfAbsent(writer.toString(), new ReentrantReadWriteLock());
        lock.writeLock().lock();
        try {
            writer.run();
        }
        finally {
            lock.writeLock().unlock();
        }
    }
}

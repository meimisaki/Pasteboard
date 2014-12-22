package com.sorakasugano.pasteboard;

import java.util.*;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import com.sorakasugano.pasteboard.Getter;
import com.sorakasugano.pasteboard.Setter;

public class Adapter {
    private static Map<String, ReadWriteLock> locks = new ConcurrentHashMap<String, ReadWriteLock>();
    public static Map<String, String> get(Getter getter) throws Exception {
        ReadWriteLock lock = locks.putIfAbsent(getter.toString(), new ReentrantReadWriteLock());
        lock.readLock().lock();
        try {
            return getter.call();
        }
        finally {
            lock.readLock().unlock();
        }
    }
    public static void set(Setter setter) throws Exception {
        ReadWriteLock lock = locks.putIfAbsent(setter.toString(), new ReentrantReadWriteLock());
        lock.writeLock().lock();
        try {
            setter.run();
        }
        finally {
            lock.writeLock().unlock();
        }
    }
}

package com.sorakasugano.pasteboard;

import java.util.*;
import java.util.concurrent.*;
import java.util.concurrent.locks.*;
import com.sorakasugano.pasteboard.Reader;
import com.sorakasugano.pasteboard.Writer;

public class Adapter {
    private static Map<String, ReadWriteLock> locks = new ConcurrentHashMap<String, ReadWriteLock>();
    public static Object read(Reader reader) throws Exception {
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

package com.sorakasugano.pasteboard;

import java.util.*;
import java.util.concurrent.*;

public abstract class Actor<T> implements Callable<T> {
    public String type = null;
    public String id = null;
    public Map<String, Boolean> keys() {
        Map<String, Boolean> keys = new HashMap<String, Boolean>();
        return keys;
    }
}

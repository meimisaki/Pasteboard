package com.sorakasugano.pasteboard;

import java.util.*;

public abstract class Reader<T> extends Actor<T> {
    @Override
    public Map<String, Boolean> keys() {
        Map<String, Boolean> keys = super.keys();
        keys.put(type + ":" + id, false);
        return keys;
    }
}

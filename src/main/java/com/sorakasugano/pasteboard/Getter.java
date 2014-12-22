package com.sorakasugano.pasteboard;

import java.util.*;
import java.util.concurrent.*;
import com.sorakasugano.pasteboard.Actor;

public class Getter extends Actor implements Callable<Map<String, String>> {
    public Getter(String type, String id) {
        super(type, id);
    }
    @Override
    public Map<String, String> call() {
        return null;
    }
}

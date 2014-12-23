package com.sorakasugano.pasteboard;

import java.util.*;
import java.util.concurrent.*;
import com.sorakasugano.pasteboard.Reader;

public class Selector extends Reader<Map<String, String>[]> {
    private int offset = 0;
    private int limit = -1;
    private String keyword = null;
    @Override
    public Map<String, String>[] call() {
        return null;
    }
}

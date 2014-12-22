package com.sorakasugano.pasteboard;

import java.util.*;
import java.util.concurrent.*;
import com.sorakasugano.pasteboard.Getter;

public class Selector extends Getter {
    private int mOffset;
    private int mLimit;
    private String mKeyword;
    public Selector(String type, String id, int offset, int limit, String keyword) {
        super(type, id);
        mOffset = offset;
        mLimit = limit;
        mKeyword = keyword;
    }
    @Override
    public Map<String, String> call() {
        return null;
    }
}

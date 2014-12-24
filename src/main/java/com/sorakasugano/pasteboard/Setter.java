package com.sorakasugano.pasteboard;

import java.util.*;
import java.text.*;
import com.sorakasugano.pasteboard.Writer;

public class Setter extends Writer {
    public Map<String, String> object = null;
    private static String ISOString(Date date) {
        DateFormat iso = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
        iso.setTimeZone(TimeZone.getTimeZone("UTC"));
        return iso.format(date);
    }
    @Override
    public Object call() {
        return null;
    }
}

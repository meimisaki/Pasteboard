package com.sorakasugano.pasteboard;

import java.util.*;
import java.text.*;
import com.sorakasugano.pasteboard.Writer;

public class Setter extends Writer {
    public Map<String, String> object = null;
    public static String now() {
        DateFormat iso = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
        iso.setTimeZone(TimeZone.getTimeZone("UTC"));
        return iso.format(new Date());
    }
    @Override
    public void run() {
        
    }
}

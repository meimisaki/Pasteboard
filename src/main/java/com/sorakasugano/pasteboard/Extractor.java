package com.sorakasugano.pasteboard;

import java.util.*;
import javax.servlet.http.*;

public class Extractor {
    private HttpServletRequest request = null;
    public Extractor(HttpServletRequest req) {
        request = req;
    }
    public Map<String, String> extract(String... keys) throws NullPointerException {
        Map<String, String> object = new HashMap<String, String>();
        for (String key : keys) {
            String value = request.getParameter(key);
            if (value == null) throw new NullPointerException();
            object.put(key, value);
        }
        return object;
    }
}

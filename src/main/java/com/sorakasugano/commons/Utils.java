package com.sorakasugano.commons;

import com.google.gson.*;

public class Utils {
    private static final Gson gson = new Gson();
    public static String JSONEncode(Object in) {
        return in == null ? "" : gson.toJson(in);
    }
}

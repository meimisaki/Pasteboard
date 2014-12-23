package com.sorakasugano.pasteboard;

public abstract class Actor {
    public String type = null;
    public String subtype = null;
    public String id = null;
    @Override
    public String toString() {
        return type + ":" + id + (subtype == null ? "" : ":" + subtype + "-list");
    }
}

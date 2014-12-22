package com.sorakasugano.pasteboard;

public class Actor {
    private String mType;
    private String mId;
    public Actor(String type, String id) {
        mType = type;
        mId = id;
    }
    public String type() {
        return mType;
    }
    public String id() {
        return mId;
    }
    @Override
    public String toString() {
        return mType + ":" + mId;
    }
}

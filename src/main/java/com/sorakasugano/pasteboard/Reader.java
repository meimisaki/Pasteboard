package com.sorakasugano.pasteboard;

import java.util.concurrent.*;
import com.sorakasugano.pasteboard.Actor;

public abstract class Reader<T> extends Actor implements Callable<T> {
}

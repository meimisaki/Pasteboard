package com.sorakasugano.pasteboard;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class StarServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            String path = req.getContextPath();
            String uri = req.getRequestURI().substring(path.length() + 1);
            boolean star = uri.startsWith("star");
            String cid = uri.substring(star ? 5 : 7);
            String uid = DBUtils.self(req).get("id");
            if (star) DBUtils.star(cid, uid);
            else DBUtils.unstar(cid, uid);
        }
        catch (Exception except) {
            res.setStatus(500);
        }
    }
}

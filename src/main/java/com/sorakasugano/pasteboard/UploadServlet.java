package com.sorakasugano.pasteboard;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.apache.commons.io.*;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.servlet.*;
import org.apache.commons.fileupload.util.*;
import com.sorakasugano.commons.*;

public class UploadServlet extends HttpServlet {
    private static final int SIZE_THRESHOLD = 2 * 1024 * 1024;
    private static final int FILE_SIZE_MAX = 2 * 1024 * 1024;
    private static final int SIZE_MAX = FILE_SIZE_MAX * 10;
    private File tmpDir = null;
    private File uploadDir = null;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        doPost(req, res);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        if (!ServletFileUpload.isMultipartContent(req)) return ;
        synchronized (UploadServlet.class) {
            if (uploadDir == null) {
                uploadDir = new File(FilenameUtils.concat(req.getRealPath("/"), "../upload"));
                if (!uploadDir.isDirectory()) uploadDir.mkdir();
            }
        }
        try {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setRepository(tmpDir);
            factory.setSizeThreshold(SIZE_THRESHOLD);
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setFileSizeMax(FILE_SIZE_MAX);
            upload.setSizeMax(SIZE_MAX);
            Map<String, String> out = new HashMap<String, String>();
            for (FileItem item : upload.parseRequest(req)) {
                String uuid = UUID.randomUUID().toString();
                String ext = FilenameUtils.getExtension(item.getName());
                String name = uuid + ("".equals(ext) ? "" : "." + ext);
                try {
                    item.write(new File(FilenameUtils.concat(uploadDir.getPath(), name)));
                }
                catch (Exception except) {
                    // pass
                }
                finally {
                    out.put(item.getFieldName(), name);
                }
            }
            res.getWriter().println(Utils.JSONEncode(out));
        }
        catch (FileUploadException except) {
            res.getWriter().println(except);
        }
    }
    @Override
    public void init() throws ServletException {
        super.init();
        tmpDir = new File(System.getProperty("java.io.tmpdir"));
    }
}

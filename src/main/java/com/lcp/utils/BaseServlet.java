package com.lcp.utils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;

/**
 * description: 分发用户请求
 * author: 沫凌
 * create: 2019-03-04 15:51
 */
@WebServlet("/BaseServlet")
public abstract class BaseServlet extends HttpServlet {

    @Override
    public void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("utf-8");
        String methodName = req.getParameter("method");
        if (methodName == null || methodName.length() == 0) {
            methodName = "execute";
        }
        try {
            //反射机制
            Class cla = this.getClass();
            Method method = cla.getMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
            method.invoke(this, req, resp);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public abstract void execute(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException;
}

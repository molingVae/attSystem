package com.lcp.fliter;

import com.lcp.dao.UserDao;
import com.lcp.pojo.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLDecoder;

/**
 * description:  自动登录
 * author: 沫凌
 * create: 2019-03-06 8:51
 */
@WebFilter(urlPatterns = "/login.jsp")
public class AutoLoginFliter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
                         FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        //防止中文乱码
        request.setCharacterEncoding("utf-8");

        //从Cookie 取出autoLogin.name password

        String autoLogin = null;
        String name = null;
        String password = null;
        Cookie[] cookies = request.getCookies();
        //判断是否存在Cookie
        if (cookies != null && cookies.length > 0) {
            for (Cookie cookie : cookies) {
                if ("autoLogin".equals(cookie.getName())) {
                    autoLogin = cookie.getValue();
                }
                if ("name".equals(cookie.getName())) {
                    name = URLDecoder.decode(cookie.getValue(), "utf-8");
                }
                if ("password".equals(cookie.getName())) {
                    password = cookie.getValue();
                }
            }
        }
        //判断是否为退出，如若退出则将autoLogin清除，并且  autoLogin = null使其直接放行
        String loginEdit = request.getParameter("loginEdit");
        if ("false".equals(loginEdit)) {
            for (Cookie cookie : cookies) {
                if ("autoLogin".equals(cookie.getName())) {
                    cookie.setMaxAge(0);
                }
            }
            autoLogin = null;
        }
        //判断是否登录
        if (autoLogin != null) {
            //判断是否Cookie存在name 与password
            if (name != null && password != null) {
                //与数据库进行交互校验
                User user = new User();
                user.setName(name);
                user.setPassword(password);

                UserDao userDao = new UserDao();
                User user1 = userDao.login(user);

                if (user1 != null) {
                    response.sendRedirect("main.jsp");
                }
            }
        } else {
            //若不自动登录放行
            filterChain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {

    }
}

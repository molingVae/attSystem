package com.lcp.fliter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

/**
 * description: 记住我与自动登录 拦截器
 * author: 沫凌
 * create: 2019-03-05 14:29
 */
@WebFilter(urlPatterns = "/UserServlet")
public class RemberMeFliter implements Filter {

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

        String methodName = request.getParameter("method");

        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        String autoLogin = request.getParameter("autoLogin");
         //System.out.println(name);
        //拦截login请求
        if ("login".equals(methodName)) {

            //若是autoLogin不为空 则自动登录 ，存入Cookie
            if (autoLogin != null) {
                Cookie cookie = new Cookie("autoLogin", autoLogin);
                //设置Cookie的有效期为3天
                cookie.setMaxAge(60 * 60 * 24 * 3);
                response.addCookie(cookie);
            }
            //不自动登录
            else {

                Cookie[] cookies = request.getCookies();
                //判断是否存在Cookie
                if (cookies != null && cookies.length > 0) {
                    for (Cookie cookie : cookies) {
                        if ("autoLogin".equals(cookie.getName())) {
                            //清除autoLogin Cookie
                            cookie.setMaxAge(0);
                        }
                        response.addCookie(cookie);
                    }
                }
            }

            //若是rememberMe不为空 则记住密码
            if (rememberMe != null) {
                //将name解码  URLEncoder.encode(name, "utf-8")
                Cookie cookie1 = new Cookie("name", URLEncoder.encode(name, "utf-8"));
                Cookie cookie2 = new Cookie("password", password);
                //设置Cookie的有效期为3天
                cookie1.setMaxAge(60 * 60 * 24 * 3);
                cookie2.setMaxAge(60 * 60 * 24 * 3);
                response.addCookie(cookie1);
                response.addCookie(cookie2);

            }
            //不记住密码
            else {
                Cookie[] cookies = request.getCookies();
                //判断是否存在Cookie
                if (cookies != null && cookies.length > 0) {
                    for (Cookie cookie : cookies) {
                        if ("name".equals(cookie.getName())) {
                            //清除autoLogin Cookie
                            cookie.setMaxAge(0);

                        }
                        if ("password".equals(cookie.getName())) {
                            //清除autoLogin Cookie
                            cookie.setMaxAge(0);
                        }
                        response.addCookie(cookie);
                    }
                }
            }

            //结束放行
            filterChain.doFilter(servletRequest, servletResponse);
        }
        //若不是login放行
        else {
            filterChain.doFilter(servletRequest, servletResponse);
        }

    }

    @Override
    public void destroy() {

    }
}

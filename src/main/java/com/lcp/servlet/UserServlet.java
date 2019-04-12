package com.lcp.servlet;

import com.lcp.pojo.User;
import com.lcp.service.UserService;
import com.lcp.utils.BaseServlet;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

/**
 * description: 用户相关
 * author: 沫凌
 * create: 2019-03-04 16:07
 */

@WebServlet("/UserServlet")
public class UserServlet extends BaseServlet {

    private UserService userService = new UserService();

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        System.out.println("前端没有传入方法");
    }

    /**
     * 登录校验
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void login(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        User user = new User();
        user.setName(req.getParameter("name"));
        user.setPassword(req.getParameter("password"));

        //调用Userservice
        User user1 = userService.login(user);

        if (user1 != null) {
            HttpSession session = req.getSession();
            //把用户信息存入session
            session.setAttribute("user", user1);
            // System.out.println(session.getAttribute("user"));
            resp.sendRedirect("main.jsp");
        } else {
            req.setAttribute("message", "账号或密码错误");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }

    }

    /**
     * 查询用户
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void userSearch(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        //获取搜索信息  用户名/部门ID
        String name = req.getParameter("name");
        String department_id = req.getParameter("department_id");

        List<User> userList = userService.userSearch(name, department_id);
        // System.out.println(userList.toString());
        req.setAttribute("userList", userList);
        req.getRequestDispatcher("user/userSearch.jsp").forward(req, resp);

    }

    /**
     * 删除用户
     *
     * @param req
     * @param resp
     * @throws IOException
     */
    public void deleteUser(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        String id = req.getParameter("id");
        int i = userService.deleteUser(Integer.parseInt(id));
        String mess = "删除失败";
        if (i > 0) {
            mess = "删除成功";
        }
        PrintWriter writer = resp.getWriter();
        writer.print("<script> alert('" + mess + "');window.location='UserServlet?method=userSearch'; </script>");
        writer.flush();
        writer.close();
        //  req.getRequestDispatcher("UserServlet?method=userSearch").forward(req, resp);

    }

    /**
     * 批量删除
     *
     * @param req
     * @param resp
     * @throws IOException
     */
    public void userCheckDelete(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        String id = req.getParameter("ids");
        PrintWriter writer = resp.getWriter();
        //判断是否选择
        if (id != null && id.length() > 0) {
            Map<String, Boolean> map = userService.userCheckDelete(id);
            String errId = null;
            for (Map.Entry<String, Boolean> entry : map.entrySet()) {
                if (!entry.getValue()) {
                    errId = entry.getKey() + ",";
                }
            }

            String mess = "删除成功";
            if (errId != null && errId.length() > 0) {
                mess = "删除失败" + errId;
            }
            writer.print("<script> alert('" + mess + "');window.location='UserServlet?method=userSearch'; </script>");
        } else {
            writer.print("<script> alert('没有选中用户！');window.location='UserServlet?method=userSearch'; </script>");

        }
        writer.flush();
        writer.close();
    }

    /**
     * 添加用户
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void addUser(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, InvocationTargetException, IllegalAccessException {

        User user = new User();
        //封装user信息使用BeanUtils
        Map<String, String[]> map = req.getParameterMap();
        BeanUtils.populate(user, map);
       /* user.setAccount(req.getParameter("account"));
        user.setName(req.getParameter("name"));
        user.setPassword(req.getParameter("password"));
        user.setDepartment_id(Integer.parseInt(req.getParameter("department_id")));
        user.setSex(Integer.parseInt(req.getParameter("sex")));
        user.setMobile(req.getParameter("mobile"));
        user.setEmail(req.getParameter("email"));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        user.setBirthday(new java.sql.Date(sdf.parse(req.getParameter("birthday")).getTime()));*/
        int i = userService.addUser(user);
        String mess = "添加失败";
        if (i > 0) {
            mess = "添加成功";
        }
        PrintWriter writer = resp.getWriter();
        writer.print("<script> alert('" + mess + "');window.location='UserServlet?method=userSearch'; </script>");
        writer.flush();
        writer.close();
        //System.out.println(user.toString());
        //转发后会携带本request域导致只能查询到此插入用户，所以只能使用重定向
        //req.getRequestDispatcher("UserServlet?method=userSearch").forward(req, resp);
        // resp.sendRedirect("UserServlet?method=userSearch");

    }

    /**
     * 修改用户
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void updateUser(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, InvocationTargetException, IllegalAccessException {

        User user = new User();
        //封装user信息
        Map<String, String[]> map = req.getParameterMap();
        BeanUtils.populate(user, map);

        int i = userService.updateUser(user);
        String mess = "修改失败";
        if (i > 0) {
            mess = "修改成功";
        }
        PrintWriter writer = resp.getWriter();
        //修改个人信息
        if (req.getParameter("info") != null) {
            //更改Session
            User user1 = userService.getMyInfo(user.getId());

            HttpSession session = req.getSession();
            //把用户信息存入session
            session.setAttribute("user", user1);
            writer.print("<script> alert('" + mess + "');window.location='user/myInfoUpdate.jsp'; </script>");
        } else {
            writer.print("<script> alert('" + mess + "');window.location='UserServlet?method=userSearch'; </script>");
        }
        writer.flush();
        writer.close();
        //resp.sendRedirect("UserServlet?method=userSearch");

    }

    /**
     * 根据用户ID获取用户信息
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void getUserById(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String id = req.getParameter("id");
        User user = userService.getUserById(Integer.parseInt(id));
        // System.out.println(user.toString());
        req.setAttribute("user", user);
        req.getRequestDispatcher("user/userUpdate.jsp").forward(req, resp);

    }

    /**
     * 修改密码
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void updatePass(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        //判断密码是否正确
        User user = new User();
        user.setName(((User) session.getAttribute("user")).getName());
        user.setPassword(req.getParameter("password"));
        User user1 = userService.login(user);
        PrintWriter writer = resp.getWriter();
        if (user1 == null) {
            writer.print("<script> alert('原始密码错误');window.location='user/myPasswordUpdate.jsp'; </script>");
        } else {
            //获取当前用户Id
            Integer id = ((User) session.getAttribute("user")).getId();

            int i = userService.updatePass(req.getParameter("password"), id);
            String mess = "修改失败";
            if (i > 0) {
                mess = "修改成功";
            }

            writer.print("<script> alert('" + mess + "');window.location='user/myPasswordUpdate.jsp'; </script>");

        }
        writer.flush();
        writer.close();

    }
}

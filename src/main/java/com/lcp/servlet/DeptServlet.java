package com.lcp.servlet;

import com.lcp.pojo.Dept;
import com.lcp.service.DeptService;
import com.lcp.utils.BaseServlet;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

/**
 * description:
 * author: 沫凌
 * create: 2019-03-11 10:10
 */
@WebServlet(urlPatterns = "/DeptServlet")
public class DeptServlet extends BaseServlet {

    private DeptService deptService = new DeptService();

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        System.out.println("前端没有传入方法");
    }

    /**
     * 查询部门
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void deptSearch(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        //获取搜索信息  部门
        String department_name = req.getParameter("department_name");

        List<Dept> deptList = deptService.deptSearch(department_name);
        // System.out.println(userList.toString());
        req.setAttribute("deptList", deptList);
        req.getRequestDispatcher("dept/deptSearch.jsp").forward(req, resp);

    }

    /**
     * 添加部门
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void addDept(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, InvocationTargetException, IllegalAccessException {
        //封装
        Dept dept = new Dept();
        BeanUtils.populate(dept, req.getParameterMap());
        int i = deptService.addDept(dept);
        String mess = "添加失败";
        if (i > 0) {
            mess = "添加成功";
        }
        PrintWriter writer = resp.getWriter();
        writer.print("<script> alert('" + mess + "');window.location='DeptServlet?method=deptSearch'; </script>");
        writer.flush();
        writer.close();

    }

    /**
     * 删除部门
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void deleteDept(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        String department_id = req.getParameter("id");
        int i = deptService.deleteDept(Integer.parseInt(department_id));
        String mess = "删除失败";
        if (i > 0) {
            mess = "删除成功";
        }
        PrintWriter writer = resp.getWriter();
        writer.print("<script> alert('" + mess + "');window.location='DeptServlet?method=deptSearch'; </script>");
        writer.flush();
        writer.close();
    }

    /**
     * 批量删除部门
     *
     * @param req
     * @param resp
     * @throws IOException
     */
    public void deptCheckDelete(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        String department_ids = req.getParameter("ids");
        PrintWriter writer = resp.getWriter();

        if (department_ids != null && department_ids.length() > 0) {
            Map<String, Boolean> map = deptService.deptCheckDelete(department_ids);
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
            writer.print("<script> alert('" + mess + "');window.location='DeptServlet?method=deptSearch'; </script>");
        } else {
            writer.print("<script> alert('没有选择部门！');window.location='DeptServlet?method=deptSearch'; </script>");

        }
        writer.flush();
        writer.close();
    }

    /**
     * 修改部门
     *
     * @param req
     * @param resp
     * @throws IOException
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     */
    public void updateDept(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, InvocationTargetException, IllegalAccessException {
        //封装
        Dept dept = new Dept();
        BeanUtils.populate(dept, req.getParameterMap());
        int i = deptService.updateDept(dept);
        String mess = "修改失败";
        if (i > 0) {
            mess = "修改成功";
        }
        PrintWriter writer = resp.getWriter();
        writer.print("<script> alert('" + mess + "');window.location='DeptServlet?method=deptSearch'; </script>");
        writer.flush();
        writer.close();
    }

    /**
     * 根据部门ID获取部门信息
     *
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    public void getDeptById(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String department_id = req.getParameter("id");
        Dept dept = deptService.getDeptById(Integer.parseInt(department_id));
        // System.out.println(user.toString());
        req.setAttribute("dept", dept);
        req.getRequestDispatcher("dept/deptUpdate.jsp").forward(req, resp);

    }

}

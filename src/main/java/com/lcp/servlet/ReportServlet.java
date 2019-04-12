package com.lcp.servlet;

import com.lcp.pojo.Report;
import com.lcp.service.ReportService;
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
 * create: 2019-03-12 14:42
 */
@WebServlet(urlPatterns = "/ReportServlet")
public class ReportServlet extends BaseServlet {

    private ReportService reportService = new ReportService();

    /**
     * 添加日报
     *
     * @param request
     * @param response
     * @throws InvocationTargetException
     * @throws IllegalAccessException
     * @throws IOException
     */
    public void addReport(HttpServletRequest request, HttpServletResponse response)
            throws InvocationTargetException, IllegalAccessException, IOException {
        Report report = new Report();
        BeanUtils.populate(report, request.getParameterMap());
        int i = reportService.addReport(report);
        String mess = "添加失败";
        if (i > 0) {
            mess = "添加成功";
        }
        PrintWriter writer = response.getWriter();
        writer.print("<script> alert('" + mess + "');window.location='ReportServlet?method=reportSearch'; </script>");
        writer.flush();
        writer.close();

    }

    /**
     * 查询日报
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    public void reportSearch(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        List<Report> reportList;
        if (name == null && startTime == null && endTime == null) {
            reportList = reportService.reportAllSearch();

        } else {
            //根据name,satrtTime,endTime查询
            reportList = reportService.reportSearch(name, startTime, endTime);
        }
        request.setAttribute("reportList", reportList);
        request.getRequestDispatcher("report/reportSearch.jsp").forward(request, response);

    }

    /**
     * 修改日报
     *
     * @param req
     * @param resp
     */
    public void updateReport(HttpServletRequest req, HttpServletResponse resp)
            throws InvocationTargetException, IllegalAccessException, IOException {
        Report report = new Report();
        BeanUtils.populate(report, req.getParameterMap());
        int i = reportService.updateReport(report);
        String mess = "修改失败";
        if (i > 0) {
            mess = "修改成功";
        }
        PrintWriter writer = resp.getWriter();
        writer.print("<script> alert('" + mess + "');window.location='ReportServlet?method=reportSearch'; </script>");
        writer.flush();
        writer.close();
    }

    /**
     * 根据日报Id获取信息
     *
     * @param request
     * @param response
     */
    public void getReportById(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String report_id = request.getParameter("id");
        Report report = reportService.getReportById(Integer.parseInt(report_id));
        request.setAttribute("report", report);
        request.getRequestDispatcher("report/reportUpdate.jsp").forward(request, response);

    }

    /**
     * 删除部门
     *
     * @param request
     * @param response
     * @throws IOException
     */
    public void deleteReport(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String id = request.getParameter("id");
        int i = reportService.deleteReport(Integer.parseInt(id));
        String mess = "删除失败";
        if (i > 0) {
            mess = "删除成功";
        }
        PrintWriter writer = response.getWriter();
        writer.print("<script> alert('" + mess + "');window.location='ReportServlet?method=reportSearch'; </script>");
        writer.flush();
        writer.close();

    }

    /**
     * 批量删除
     *
     * @param req
     * @param resp
     * @throws IOException
     */
    public void reportCheckDelete(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        String id = req.getParameter("ids");
        PrintWriter writer = resp.getWriter();
        //判断是否选择
        if (id != null && id.length() > 0) {
            Map<String, Boolean> map = reportService.reportCheckDelete(id);
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
            writer.print("<script> alert('" + mess + "');window.location='ReportServlet?method=reportSearch'; </script>");
        } else {
            writer.print("<script> alert('没有选中日报！');window.location='ReportServlet?method=reportSearch'; </script>");

        }
        writer.flush();
        writer.close();
    }

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        System.out.println("前端没有传入方法");

    }
}

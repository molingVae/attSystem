package com.lcp.service;

import com.lcp.dao.ReportDao;
import com.lcp.pojo.Report;
import com.lcp.utils.TimeUtil;
import org.apache.commons.collections.map.HashedMap;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * description:
 * author: 沫凌
 * create: 2019-03-12 14:46
 */
public class ReportService {

    private ReportDao reportDao = new ReportDao();

    public int addReport(Report report) {
        return reportDao.addReport(report);
    }

    public List<Report> reportAllSearch() {
        return reportDao.reportAllSearch();
    }

    public Report getReportById(int report_id) {
        return reportDao.getReportById(report_id);
    }

    public int updateReport(Report report) {
        return reportDao.updateReport(report);
    }

    public int deleteReport(int id) {
        return reportDao.deleteReport(id);
    }

    public Map<String, Boolean> reportCheckDelete(String id) {
        Map<String, Boolean> map = new HashedMap();
        String[] ids = id.split(",");
        for (String i : ids) {
            if (i != null && i.length() > 0) {
                int s = reportDao.deleteReport(Integer.parseInt(i));
                if (s > 0) {
                    map.put(i, true);
                } else {
                    map.put(i, false);
                }

            }
        }
        return map;
    }

    /**
     * 根据日期进行筛选
     *
     * @param name
     * @param startTime
     * @param endTime
     * @return
     */
    public List<Report> reportSearch(String name, String startTime, String endTime) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date start = null;
        Date end = null;
        try {
            start = new Date(sdf.parse(startTime).getTime());
            end = new Date(sdf.parse(endTime).getTime());
        } catch (ParseException e) {
            e.printStackTrace();
        }

        //根据name模糊查询所有
        List<Report> reportList = reportDao.reportSearch(name);
        List<Report> reportList1 = new ArrayList<>();
        //根据日期进行筛选
        for (Report report : reportList) {
            //获取到日期
            Date report_date = report.getReport_date();

            //使用时间工具类进行筛选
            if (TimeUtil.compareDate(end, report_date) && TimeUtil.compareDate(report_date, start)) {
                //如果成功
                reportList1.add(report);
            }
        }
        return reportList1;

    }
}

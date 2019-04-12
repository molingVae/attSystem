package com.lcp.dao;

import com.lcp.pojo.Report;
import com.lcp.utils.C3P0Util;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.List;

/**
 * description:
 * author: 沫凌
 * create: 2019-03-12 15:05
 */
public class ReportDao {

    public int addReport(Report report) {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "insert into t_report_record(account,report_date,work_process," +
                "work_content,tomorrow_plan,problem,other) values(?,?,?,?,?,?,?)";
        Object[] params = {report.getAccount(), report.getReport_date(), report.getWork_process(), report.getWork_content()
                , report.getTomorrow_plan(), report.getProblem(), report.getOther()};
        try {
            int i = queryRunner.update(sql, params);
            return i;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Report> reportAllSearch() {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "SELECT a.*,b.name from t_report_record a JOIN t_user_info b ON a.account=b.ACCOUNT";
        try {
            List<Report> reportList = queryRunner.query(sql, new BeanListHandler<>(Report.class));
            // System.out.println(userList);
            if (reportList != null) {
                return reportList;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Report getReportById(int report_id) {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "SELECT a.*,b.name from t_report_record a JOIN t_user_info b ON a.account=b.ACCOUNT AND a.report_id=?";

        try {
            Report report = queryRunner.query(sql, new BeanHandler<>(Report.class), report_id);
            // System.out.println(userList);
            if (report != null) {
                return report;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int updateReport(Report report) {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "update t_report_record set account=?,report_date=?,work_process=?," +
                "work_content=?,tomorrow_plan=?,problem=?,other=? where report_id=?";
        Object[] params = {report.getAccount(), report.getReport_date(), report.getWork_process(), report.getWork_content()
                , report.getTomorrow_plan(), report.getProblem(), report.getOther(), report.getReport_id()};
        try {
            int i = queryRunner.update(sql, params);
            return i;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int deleteReport(int id) {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "delete from t_report_record where report_id=?";
        int i = 0;
        try {
            i = queryRunner.update(sql, id);
            // return i;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }

    public List<Report> reportSearch(String name) {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "SELECT a.*,b.name from t_report_record a JOIN t_user_info b ON a.account=b.ACCOUNT and b.name LIKE ?";
        Object[] params = {"%" + name + "%"};
        try {
            List<Report> reportList = queryRunner.query(sql, new BeanListHandler<>(Report.class), params);
            // System.out.println(userList);
            if (reportList != null) {
                return reportList;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

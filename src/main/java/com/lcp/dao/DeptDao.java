package com.lcp.dao;

import com.lcp.pojo.Dept;
import com.lcp.utils.C3P0Util;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.List;

/**
 * description:
 * author: 沫凌
 * create: 2019-03-11 10:19
 */
public class DeptDao {

    public List<Dept> deptSearch(String department_name) {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "select * from t_department where department_name like ?";
        Object[] params = {'%' + department_name + '%'};
        try {
            List<Dept> deptList = queryRunner.query(sql, new BeanListHandler<>(Dept.class), params);
            if (deptList != null) {
                return deptList;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;

    }

    public List<Dept> deptAllSearch() {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "select * from t_department";
        List<Dept> deptList = null;
        try {
            deptList = queryRunner.query(sql, new BeanListHandler<>(Dept.class));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return deptList;
    }

    public int addDept(Dept dept) {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "insert into t_department(department_id,department_name,managers) values(?,?,?)";
        Object[] params = {dept.getDepartment_id(), dept.getDepartment_name(), dept.getManagers()};

        try {
            int i = queryRunner.update(sql, params);
            return i;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int deleteDept(int department_id) {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "delete from t_department where department_id=?";
        Object[] params = {department_id};
        int i = 0;
        try {
            i = queryRunner.update(sql, params);
            // return i;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }

    public Dept getDeptById(int department_id) {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "select * from t_department where department_id=?";
        try {
            Dept dept = queryRunner.query(sql, new BeanHandler<>(Dept.class), department_id);
            if (dept != null) {
                return dept;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;

    }

    public int updateDept(Dept dept) {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "update t_department set department_name=?,managers=? where department_id=?";
        Object[] params = {dept.getDepartment_name(), dept.getManagers(), dept.getDepartment_id()};

        try {
            int i = queryRunner.update(sql, params);
            return i;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}

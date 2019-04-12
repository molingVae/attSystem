package com.lcp.dao;

import com.lcp.pojo.User;
import com.lcp.utils.C3P0Util;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.SQLException;
import java.util.List;

/**
 * description:
 * author: 沫凌
 * create: 2019-03-04 16:14
 */
public class UserDao {

    public User login(User user) {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "select * from t_user_info where name=?";
        Object[] params = {user.getName()};

        try {
            User user1 = queryRunner.query(sql, new BeanHandler<>(User.class), params);
            if (user1 != null && user.getPassword().equals(user1.getPassword())) {
                return user1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<User> userSearch(String name, String department_id) {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "select a.*,b.department_name from t_user_info a  JOIN t_department b " +
                "ON a.department_id=b.department_id and a.name like ? and a.department_id=?";
        Object[] params = {'%' + name + '%', department_id};

        try {
            List<User> userList = queryRunner.query(sql, new BeanListHandler<>(User.class), params);
            if (userList != null) {
                return userList;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;

    }

    public List<User> userAllSearch() {
        // System.out.println("aaa");
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "select a.*,b.department_name from t_user_info a JOIN t_department b ON a.department_id=b.department_id";
        try {
            List<User> userList = queryRunner.query(sql, new BeanListHandler<>(User.class));
            // System.out.println(userList);
            if (userList != null) {
                return userList;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int deleteUser(int id) {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "delete from t_user_info where id=?";
        Object[] params = {id};
        int i = 0;
        try {
            i = queryRunner.update(sql, params);
            // return i;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }

    public int addUser(User user) {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "insert into t_user_info(account,password,name,department_id,sex,mobile,birthday,email,user_type,mylevel) " +
                "values(?,?,?,?,?,?,?,?,?,?) ";
        Object[] params = {user.getAccount(), user.getPassword(), user.getName(), user.getDepartment_id(),
                user.getSex(), user.getMobile(), user.getBirthday(), user.getEmail(), user.getUser_type(), user.getMylevel()};
        int i = 0;
        try {
            i = queryRunner.update(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }

    public User getUserById(int id) {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "select * from t_user_info where id=?";
        try {
            User user = queryRunner.query(sql, new BeanHandler<>(User.class), id);
            if (user != null) {
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int updateUser(User user) {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "update t_user_info set account=?,password=?,name=?,department_id=?,sex=?,mobile=?,birthday=?,email=?,user_type=?,mylevel=? where id=?";
        Object[] params = {user.getAccount(), user.getPassword(), user.getName(), user.getDepartment_id(),
                user.getSex(), user.getMobile(), user.getBirthday(), user.getEmail(),user.getUser_type(),user.getMylevel(), user.getId()};
        int i = 0;
        try {
            i = queryRunner.update(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;
    }

    public User getMyInfo(Integer id) {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "select * from t_user_info where id=?";
        User user = null;
        try {
            user = queryRunner.query(sql, new BeanHandler<>(User.class), id);
            //  return user;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public int updatePass(String password, Integer id) {
        QueryRunner queryRunner = new QueryRunner(C3P0Util.getDataSource());
        String sql = "update t_user_info set password=? where id=?";
        Object[] params = {password, id};
        int i = 0;
        try {
            i = queryRunner.update(sql, params);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return i;

    }
}

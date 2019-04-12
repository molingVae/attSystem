package com.lcp.service;

import com.lcp.dao.UserDao;
import com.lcp.pojo.User;
import org.apache.commons.collections.map.HashedMap;

import java.util.List;
import java.util.Map;

/**
 * description:
 * author: 沫凌
 * create: 2019-03-04 16:12
 */
public class UserService {

    private UserDao userDao = new UserDao();

    public User login(User user) {
        //调用dao
        return userDao.login(user);
    }

    public List<User> userSearch(String name, String department_id) {

        //若用户名/部门ID不为空
        if (name != null && department_id != null && !("".equals(name)) && !("".equals(department_id))) {
            return userDao.userSearch(name, department_id);
        }
        return userDao.userAllSearch();
    }

    public int deleteUser(int id) {
        return userDao.deleteUser(id);
    }

    public int addUser(User user) {
        return userDao.addUser(user);
    }

    public User getUserById(int id) {
        return userDao.getUserById(id);
    }

    public int updateUser(User user) {
        return userDao.updateUser(user);
    }

    public User getMyInfo(Integer id) {
        return userDao.getMyInfo(id);
    }

    public int updatePass(String password, Integer id) {
        return userDao.updatePass(password, id);
    }

    public Map<String, Boolean> userCheckDelete(String id) {
        Map<String, Boolean> map = new HashedMap();
        String[] ids = id.split(",");
        for (String i : ids) {
            if (i != null && i.length() > 0) {
                int s = userDao.deleteUser(Integer.parseInt(i));
                if (s > 0) {
                    map.put(i, true);
                } else {
                    map.put(i, false);
                }

            }
        }
        return map;
    }
}

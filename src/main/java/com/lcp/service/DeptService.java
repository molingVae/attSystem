package com.lcp.service;

import com.lcp.dao.DeptDao;
import com.lcp.pojo.Dept;
import org.apache.commons.collections.map.HashedMap;

import java.util.List;
import java.util.Map;

/**
 * description:
 * author: 沫凌
 * create: 2019-03-11 10:16
 */
public class DeptService {

    private DeptDao deptDao = new DeptDao();

    public List<Dept> deptSearch(String department_name) {
        if (department_name == null || "".equals(department_name)) {
            return deptDao.deptAllSearch();
        }
        return deptDao.deptSearch(department_name);
    }

    public int addDept(Dept dept) {

        return deptDao.addDept(dept);
    }

    public int deleteDept(int department_id) {
        return deptDao.deleteDept(department_id);
    }

    public Dept getDeptById(int department_id) {
        return deptDao.getDeptById(department_id);
    }

    public int updateDept(Dept dept) {
        return deptDao.updateDept(dept);
    }

    public Map<String,Boolean> deptCheckDelete(String department_ids) {
        Map<String,Boolean> map=new HashedMap();

        String[] ids = department_ids.split(",");
        for (String i : ids) {
            if(i!=null && i.length()>0){
               int s= deptDao.deleteDept(Integer.parseInt(i));
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

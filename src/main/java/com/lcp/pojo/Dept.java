package com.lcp.pojo;

import lombok.Data;

import java.sql.Date;

/**
 * description:
 * author: 沫凌
 * create: 2019-03-11 10:16
 */
@Data
public class Dept {
    private Integer department_id;
    private String department_name;
    private String managers;
    private Integer total_user;
    private Date create_time;
}

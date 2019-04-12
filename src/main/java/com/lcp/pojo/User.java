package com.lcp.pojo;

import lombok.Data;

import java.sql.Date;

/**
 * description: 用户pojo
 * author: 沫凌
 * create: 2019-03-04 14:27
 */
@Data
public class User {

    private Integer id;
    private String account;
    private String password;
    private String name;
    private Integer department_id;
    private int sex;
    private Date birthday;
    private String mobile;
    private String email;
    private int user_type;
    private Date create_time;
    private int mylevel;
    private int state;
    private String department_name;

}

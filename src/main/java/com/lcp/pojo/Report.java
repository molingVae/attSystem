package com.lcp.pojo;

import lombok.Data;

import java.sql.Date;

/**
 * description:
 * author: 沫凌
 * create: 2019-03-12 14:39
 */
@Data
public class Report {

    private Integer report_id;
    private String account;
    private Date report_date;
    private String work_process;
    private String work_content;
    private String tomorrow_plan;
    private String problem;
    private String other;

    //外加
    private String name;
}

package com.lcp.utils;

import com.mchange.v2.c3p0.ComboPooledDataSource;

import javax.sql.DataSource;

/**
 * description:
 * author: 沫凌
 * create: 2019-03-04 18:07
 */
public class C3P0Util {
    private static ComboPooledDataSource  dataSource = new ComboPooledDataSource ("mysql");

    public static DataSource getDataSource(){
        return dataSource;
    }

}

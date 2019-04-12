package com.lcp.utils;



import java.util.*;

/**
 * description:
 * author: 沫凌
 * create: 2019-01-17 18:38
 */
public class TimeUtil {

    /**
     * 判断当前时间是否在[startTime, endTime]区间，注意时间格式要一致
     *
     * @param nowTime   当前时间
     * @param startTime 开始时间
     * @param endTime   结束时间
     * @return
     * @author jqlin
     */
    public static boolean isEffectiveDate(Date nowTime, Date startTime, Date endTime) {
        if (nowTime.getTime() == startTime.getTime()
                || nowTime.getTime() == endTime.getTime()) {
            return true;
        }

        Calendar date = Calendar.getInstance();
        date.setTime(nowTime);

        Calendar begin = Calendar.getInstance();
        begin.setTime(startTime);

        Calendar end = Calendar.getInstance();
        end.setTime(endTime);

        if (date.after(begin) && date.before(end)) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 判断日期的大小 date1>date2才返回ture
     *
     * @param date1
     * @param date2
     * @return
     */
    public static boolean compareDate(Date date1, Date date2) {
        if (date1.getTime() > date2.getTime())
            return true;
        else if (date1.getTime() < date2.getTime())
            return false;
        else
            return false;
    }

    /**
     * 根据当前时间判断日期的大小
     *
     * @return
     */
    public static boolean compareDateByTime(Date date) {
        Date now = new Date();
        if (date.getTime() < now.getTime())
            return true;
        return false;
    }



}

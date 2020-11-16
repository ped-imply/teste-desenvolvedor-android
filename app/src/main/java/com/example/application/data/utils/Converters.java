package com.example.application.data.utils;

import androidx.room.TypeConverter;

import java.math.BigDecimal;
import java.util.Date;

public class Converters {

    @TypeConverter
    public static Date fromTimestamp(Long timestamp) {
        return timestamp == null ? null : new Date(timestamp);
    }

    @TypeConverter
    public static Long toTimestamp(Date date) {
        return date == null ? null : date.getTime();
    }

    @TypeConverter
    public static BigDecimal fromDouble(Double value) {
        return value == null ? null : new BigDecimal(value);
    }

    @TypeConverter
    public static Double toDouble(BigDecimal value) {
        return value == null ? null : value.doubleValue();
    }

}

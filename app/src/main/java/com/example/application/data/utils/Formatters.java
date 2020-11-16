package com.example.application.data.utils;

import java.math.BigDecimal;
import java.text.NumberFormat;
import java.util.Locale;

public class Formatters {

    public static String currencyFormat(BigDecimal value) {
        if (value == null)
            return "R$ 0,00";

        try {
            return String.format("%s",
                    NumberFormat.getCurrencyInstance(new Locale("pt", "BR"))
                            .format(value));
        } catch (IllegalArgumentException e) {
            return "R$ 0,00";
        }
    }

    public static String decimalFormat(BigDecimal value) {
        if (value == null)
            return "0,00";

        try {
            return String.format("%s",
                    NumberFormat.getNumberInstance(new Locale("pt", "BR"))
                            .format(value));
        } catch (IllegalArgumentException e) {
            return "0,00";
        }
    }

}

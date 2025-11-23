package utilities;

import jakarta.servlet.http.HttpServletRequest;

public class RequestUtil {

    public static int getInt(HttpServletRequest request, String name, int defaultValue) {
        try {
            int value = Integer.parseInt(request.getParameter(name));
            return value > 0 ? value:defaultValue;
        } catch (Exception e) {
            return defaultValue;
        }
    }

    public static String getString(HttpServletRequest request, String name, String defaultValue) {
        try {
            String value = (String)(request.getParameter(name));
            return value != null ? value:defaultValue;
        } catch (Exception e) {
            return defaultValue;
        }
    }

    public static Boolean getBool(HttpServletRequest request, String name) {
        try {
            Boolean value = Boolean.parseBoolean(request.getParameter(name));
            return value;
        } catch (Exception e) {
            return false;
        }
    }

    public static Double getDouble(HttpServletRequest request, String name, Double defaultValue) {
        try {
            Double value = Double.parseDouble(request.getParameter(name));
            return value > 0 ? value:defaultValue;
        } catch (Exception e) {
            return defaultValue;
        }
    }

    // different with int, so integer return null
    public static Integer getInteger(HttpServletRequest request, String name, Integer defaultValue) {
        try {
            Integer value = Integer.parseInt(request.getParameter(name));
            return value > 0 ? value:defaultValue;
        } catch (Exception e) {
            return defaultValue;
        }
    }

}
